-- Rex key bindings, migrated from herdr/config.toml and kitty/inc/maps.conf.
-- A binding here replaces the Rex default on the same key.

-- Sessions (Herdr workspaces)
rex.bind("alt+n", "session.new")
rex.bind("alt+p", "session.switch")
rex.bind("alt+s", "client.sidebar.toggle")

-- Tabs
rex.bind("alt+left", "client.tab.previous")
rex.bind("alt+right", "client.tab.next")
rex.bind("alt+t", "client.tab.new")
rex.bind("alt+w", "client.tab.close")
rex.bind("cmd+left", "client.tab.previous")
rex.bind("cmd+right", "client.tab.next")
rex.bind("shift+cmd+w", "client.tab.close")

-- Panes
rex.bind("alt+[", "pane.focus", { direction = "left" })
rex.bind("alt+]", "pane.focus", { direction = "right" })
rex.bind("alt+shift+]", "pane.focus", { direction = "down" })
rex.bind("alt+shift+[", "pane.focus", { direction = "up" })
rex.bind("alt+enter", "pane.split", { direction = "right" })
rex.bind("alt+shift+enter", "pane.split", { direction = "down" })
rex.bind("shift+cmd+enter", "pane.split", { direction = "auto" })
rex.bind("alt+x", "pane.close")
rex.bind("alt+z", "pane.zoom")
rex.bind("cmd+z", "pane.zoom")
rex.bind("shift+up", "pane.move", { direction = "up" })
rex.bind("shift+left", "pane.move", { direction = "left" })
rex.bind("shift+right", "pane.move", { direction = "right" })
rex.bind("shift+down", "pane.move", { direction = "down" })
