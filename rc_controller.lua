if turtle.getFuelLevel() == 0 then
	turtle.refuel()
end

local ws, err = http.websocket("ws://localhost:5656")

if err then
	print(string.format("Error: %s",err))
elseif ws then
	ws.send(string.format("Hi! I'm at %s, %s, %s",gps.locate()))
	turtle.forward()
	sleep(2)
	ws.send(string.format("Now I'm at %s, %s, %s",gps.locate()))
	turtle.turnLeft()
	turtle.back()
	ws.close()
end
