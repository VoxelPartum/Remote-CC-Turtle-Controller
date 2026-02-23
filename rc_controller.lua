

local ws, err = http.websocket("ws://localhost:8080")

if err then
	print(err)
elseif ws then
	while true do
		term.clear()
		term.setCursorPos(1,1)
		print("Running VosX v0.1")
		--wsRequest.send(string.format("Turtle's coords are: %d, %d, %d.", curX, curY, curZ))
		local rawMessage = ws.recieve()
		if rawMessage == nil then
			break
		end
		local message = textUtils.unserialiseJSON(rawMessage)
		if message == nil then
			print("womp")
			break
		else
			print(message)
		end
	end
end
