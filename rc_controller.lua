curX,curY,curZ = gps.locate()
--print("Current Coordinates:", curX, curY, curZ)

coords = {}
for i=0,3 do
--coords[i] = read()
end

--print((curX-desX),(curY-desY),(curZ-desZ))

local request = http.get("http://127.0.0.1:5000/")
print(request.readAll())
request.close()
