const socket = require("ws");

const webSocket = new socket.Server({port:5656});

console.log("Opening server now.")
var connectionCount = 0;
var clients = [];
var worldInfo = {};

webSocket.on("connection", wsClient => {
	
	
	connectionCount++;
	clients.push(wsClient);
	
	console.log("Something connected, number of connections: "+connectionCount);
	var computerCount = 0;
	wsClient.on("message", messageData => {
		console.log("recieved message: "+messageData);
		
		if(JSON.parse(messageData).operation == "appendWorldInfo"){
			const obj = JSON.parse(messageData);
			worldInfo[obj.xCoord+"_"+obj.yCoord+"_"+obj.zCoord] = obj.blockData;
		}
		if(JSON.parse(messageData).operation == "getWorldInfo"){
			const worldPos = JSON.parse(messageData);
			console.log(worldInfo[worldPos.xCoord+"_"+worldPos.yCoord+"_"+worldPos.zCoord]);
			
			clients.forEach(function(client){
				if(worldInfo[worldPos.xCoord+"_"+worldPos.yCoord+"_"+worldPos.zCoord] != undefined){
					client.send(JSON.stringify({operation:"displayWorldInfo", blockData:worldInfo[worldPos.xCoord+"_"+worldPos.yCoord+"_"+worldPos.zCoord].name}));
				}
				else{
					client.send(JSON.stringify({operation:"displayWorldInfo", blockData:"Unknown Block"}));
				}
			})
		}
		
		clients.forEach(function(client){
            client.send(messageData.toString());
        })
		
	})
	
	wsClient.on("close",()=>{
		console.log("Something disconnected");
		connectionCount--;
	})
})
