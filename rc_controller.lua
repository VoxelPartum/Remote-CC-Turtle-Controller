
function fuel()
	if turtle.getFuelLevel() <= 100 then
		if turtle.refuel() == false then
			ws.send(textutils.serializeJSON({err = "fuel"}))
		end
	end
end

--Orienting the turtle to face East.
gpsXOld, gpsYOld, gpsZOld = gps.locate()
turtle.forward()
gpsXNew, gpsYNew, gpsZNew = gps.locate()
turtle.back()

if (gpsXNew-gpsXOld) == 1 then     --Facing North [Z-]
elseif (gpsXOld-gpsXNew) == 1 then --Facing South [Z+]
	turtle.turnRight()
	turtle.turnRight()
elseif (gpsZNew-gpsZOld) == 1 then --Facing East [X+]
	turtle.turnLeft()
	turtle.turnLeft()
else 							   --Facing West [X-]
	turtle.turnRight()
end

ws, err = http.websocket("ws://localhost:5656")
if err then
	print(string.format("Error: %s",err))
else
	--== This is the logic of the program. ==--
	print("VoxOS RC Turtle Controller vAlpha")
	while true do
		fuel()
		local message = ws.receive()
		if message then
			local deserializedMessage = textutils.unserializeJSON(message)
			if deserializedMessage.operation == "rolecall" then
				coordinates = {gps.locate()}
				ws.send(textutils.serializeJSON({xPos = coordinates[1], yPos = coordinates[2], zPos = coordinates[3]}))				
			else
				curX, curY, curZ = gps.locate()
				desX = deserializedMessage.xPos == "" and curX or deserializedMessage.xPos ~= "" and deserializedMessage.xPos
				desY = deserializedMessage.yPos == "" and curY or deserializedMessage.xPos ~= "" and deserializedMessage.yPos
				desZ = deserializedMessage.zPos == "" and curZ or deserializedMessage.xPos ~= "" and deserializedMessage.zPos
				--(That feels like a very scuffed ternary function.)
				print(curX-desX, curY-desY, curZ-desZ)
				
				if (curX-desX) >= 0 then --Moving East [X+]
					turtle.turnLeft()
					turtle.turnLeft()
					for i=1, math.abs(curX-desX) do
						turtle.forward()
					end
					turtle.turnLeft()
					turtle.turnLeft()

				else -- Moving West [X-]
					for i=1, math.abs(curX-desX) do
						turtle.forward()
					end					
				end
				
				if (curZ-desZ) >=0 then --Moving North [Z+]
					turtle.turnLeft()
					for i=1, math.abs(curZ-desZ) do
						turtle.forward()
					end
					turtle.turnRight()
				else
					turtle.turnRight()
					for i=1, math.abs(curZ-desZ) do
						turtle.forward()
					end
					turtle.turnLeft()
				end
				if (curY-desY) >=0 then
					for i=1, math.abs(curY-desY) do
						turtle.down()
					end
				else
					for i=1, math.abs(curY-desY) do
						turtle.up()
					end
				end
			end
		end
	end
	ws.close()
end
