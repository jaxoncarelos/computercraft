local ws,err = http.websocket("ws://7e2f-174-23-159-230.ngrok.io")
if ws then
    while true do
        local msg = ws.receive()
        local obj = textutils.unserializeJSON(msg)
         print(obj['func'])
        local func = loadstring(obj['func'])
        if not (string.find(obj['func'], "inspect()")) and string.len(obj['func']) > 0 then
            func()
        else
            local ok,data = turtle.inspect()
            if ok then
                ws.send(textutils.serialiseJSON(data))
            else
                ws.send("\"No Block!\"")
            end
        end
    end
end