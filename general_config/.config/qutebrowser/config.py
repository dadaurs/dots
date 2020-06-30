#  |||||||||||     ||||||||     |\\       ||  ||||||||||||
# ||||           ||||||||||||   ||\\      ||  ||
#|||            ||||      ||||  || \\     ||  ||
#||             |||        |||  ||  \\    ||  ||
#||             |||        |||  ||   \\   ||  ||||||||
#||             |||        |||  ||    \\  ||  ||
#||             |||        |||  ||     \\ ||  ||
#|||            ||||      ||||  ||      \\||  ||
# ||||           ||||||||||||   ||       \||  ||
#  |||||||||||     ||||||||     ||        \|  ||




# config.source('colors.py')
c.tabs.favicons.scale = 1
# c.tabs.indicator.padding = {"top": 0, "right": 0, "bottom": 0, "left": 0}
# c.tabs.position = "left"
# c.tabs.show = "switching"
# c.tabs.title.format = ""
c.content.cookies.accept = 'all'
c.content.geolocation = 'ask'
c.content.webgl = True
# c.downloads.remove_finished = 800
c.auto_save.session = True
c.editor.command = ["st", "-e", "nvim", "{}"]
c.scrolling.smooth = True
# config.bind('xx', 'set tabs.show always;; later 5000 set tabs.show switching')
# config.bind('xb', 'config-cycle statusbar.hide')
config.unbind('<Ctrl-v>')
config.unbind('b')
config.bind('<Ctrl-m>', 'spawn --detach mpv --force-window yes {url}')
config.bind(';',':') 
c.url.start_pages = ["/home/dada/.config/qutebrowser/min-startpage/min.html"]
c.url.searchengines = {"DEFAULT":"https://duckduckgo.com/?q={}",
        "y":"https://www.youtube.com/results?search_query={}",
        "g":"https://www.google.com/search?q={}",
        "r":"https://www.reddit.com/search/?q={}" ,
        "gw": "https://wiki.gentoo.org/index.php?search={}",
        "aw":"https://wiki.archlinux.org/index.php?search={}",
        "w":"https://en.wikipedia.org/wiki/{}",
        "z":"http://gpo.zugaina.org/Search?search={}",
        "u":"https://unicode-table.com/en/search/?q={}",
        "tpb":"https://pirate-bay.net/search?q={}",
        "git":"https://github.com/search?q={}"}
# c.fonts.completion.category = "bold 10pt CozetteVector" 
# c.fonts.completion.entry = "10pt CozetteVector" 
# c.fonts.debug_console = "10pt CozetteVector" 
# # c.fonts.donwloads = "12pt CozetteVector" 
# c.fonts.hints = "13pt CozetteVector" 
# c.fonts.keyhint = "10pt CozetteVector" 
# c.fonts.messages.error = "12pt CozetteVector" 
# c.fonts.messages.info = "12pt CozetteVector" 
# c.fonts.messages.warning = "12pt CozetteVector" 
# c.fonts.monospace = "12pt CozetteVector" 
# c.fonts.prompts = "10pt CozetteVector" 
# c.fonts.statusbar = "10pt CozetteVector" 
# c.fonts.tabs = "12pt CozetteVector" 
c.url.start_pages = "/home/dada/.config/qutebrowser/min-startpage/min.html"
config.source('qutewal.py')
