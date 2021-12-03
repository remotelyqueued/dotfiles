# -*- mode: python -*-

import os
from qutebrowser.config.configfiles import ConfigAPI  # noqa: F401
from qutebrowser.config.config import ConfigContainer  # noqa: F401
from enum import Enum

config = config  # type: ConfigAPI # noqa: F821
c = c  # type: ConfigContainer # noqa: F821

initial_start = c.tabs.background == False

if initial_start:
    # ui
    # c.completion.scrollbar.width = 10
    c.tabs.position = 'top'
    c.tabs.show = 'multiple'
    # c.tabs.favicons.show = False
    c.tabs.favicons.show = 'never'
    c.tabs.width = 1
    c.tabs.title.format = '{title}'
    c.tabs.title.alignment = 'center'
    c.downloads.position = 'bottom'
    # c.tabs.favicons.show = False
    # c.statusbar.hide = False
    c.zoom.default = 100
    

    # behavior
    c.downloads.location.prompt = False
    c.hints.scatter = False
    c.url.searchengines = {'DEFAULT': 'https://google.com/search?q={}' }
    c.url.default_page = "https://google.com"
    c.url.start_pages = "https://google.com"
    c.content.plugins = True
    c.input.insert_mode.auto_load = True
    c.input.insert_mode.auto_leave = False
    c.tabs.background = True
    c.editor.command = ["subl3", "{}"]
    c.auto_save.session = True
    c.tabs.indicator.width = 0
    c.fonts.statusbar = '9pt Iosevka Nerd Font'
    # binds
    # config.bind('<Shift-i>', 'config-source')
    config.bind('t', 'open -t')
    # config.bind('<Ctrl-Up>', 'zoom-in')
# mustache templated from current theme
theme = {
    'panel': {
        'height': 8,
    },

    'fonts': {
        'main': 'Iosevka Nerd Font',
        'tab_bold': True,
        'tab_size': 9,
    },

    'colors': {
        'bg': {
            'normal': '#404040',
            'active': '#404040',
            'inactive': '#404040',
        },

        'fg': {
            'normal': '#dddddd',
            'active': '#dddddd',
            'inactive': '#dddddd',

            # completion and hints
            'match': '#FFCC66',
        },
    }
}

# colors
colors = theme['colors']

def setToBG(colortype, target):
    config.set('colors.' + target, colors['bg'][colortype])

def setToFG(colortype, target):
    config.set('colors.' + target, colors['fg'][colortype])

def colorSync(colortype, setting):
    if setting.endswith('.fg'):
        setToFG(colortype, setting)
    elif setting.endswith('.bg'):
        setToBG(colortype, setting)
    elif setting.endswith('.top') or setting.endswith('.bottom'):
        setToFG(colortype, setting)
    else:
        setToFG(colortype, setting + '.fg')
        setToBG(colortype, setting + '.bg')

targets = {
    'normal' : [
        'statusbar.normal',
        'statusbar.command',
        'tabs.even',
        'tabs.odd',
        'hints',
        'downloads.bar.bg',
        ],

    'active' : [
        'tabs.selected.even',
        'tabs.selected.odd',
        'statusbar.insert',
        'downloads.stop',
        'prompts',
        'messages.warning',
        'messages.error',

        'completion.item.selected',

        'statusbar.url.success.http.fg',
        'statusbar.url.success.https.fg',

        'completion.category',
    ],

    'inactive' : [
        'completion.scrollbar',
        'downloads.start',
        'messages.info',
        'completion.fg',
        'completion.odd.bg',
        'completion.even.bg',

        'completion.category.border.top',
        'completion.category.border.bottom',
        'completion.item.selected.border.top',
        'completion.item.selected.border.bottom',
    ],

    'match' : [
        'completion.match.fg',
        'hints.match.fg',
    ]
}

for colortype in targets:
    for target in targets[colortype]:
        colorSync(colortype, target)

setToFG('active', 'statusbar.progress.bg')

config.set('hints.border', '1px solid ' + colors['fg']['normal'])

# tabbar
def makePadding(top, bottom, left, right):
    return { 'top': top, 'bottom': bottom, 'left': left , 'right': right }

# TODO improve this logic
surround = round((theme['panel']['height'] - 6) / 2)
c.tabs.padding = makePadding(surround,surround,8,8)
c.tabs.indicator.padding = makePadding(0,0,0,0)

# fonts
c.fonts.monospace = theme['fonts']['main']

tabFont = str(theme['fonts']['tab_size']) + 'pt ' + theme['fonts']['main']
if theme['fonts']['tab_bold']:
    tabFont = 'bold ' + tabFont

c.fonts.tabs = tabFont
