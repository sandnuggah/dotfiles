local hotkey = hs.hotkey.bind({}, "escape", function() end)

hs.application.watcher.new(function(name, event)
    if event == hs.application.watcher.activated then
        if name == "Safari" then
            hotkey:enable()
        else
            hotkey:disable()
        end
    end
end):start()
