const socket = require("ws");

const webSocket = new socket.Server({port:5656});

console.log("Opening server now.")
var connectionCount = 0;
var clients = [];

webSocket.on("connection", wsClient => {
	
	
	connectionCount++;
	clients.push(wsClient);
	
	console.log("Something connected, number of connections: "+connectionCount);
	
	wsClient.on("message", messageData => {
		console.log("recieved message: "+messageData.toString());
		
		clients.forEach(function(client){
            var jsonData = JSON.stringify(messageData.toString(), null, 4)
            client.send(messageData.toString())
        })
		
	})
	
	wsClient.on("close",()=>{
		console.log("Something disconnected");
		connectionCount--;
	})
})const socket = require("ws");
var clients = [];
const webSocket = new socket.Server({port:5656});

webSocket.on("connection", wsClient => {
	console.log("Something connected");
	
	clients.push(wsClient);
	
	wsClient.on("message", messageData => {
		console.log("recieved message: "+messageData);
	})
	
	wsClient.on("close",()=>{
		console.log("Something disconnected");
		clients.pop(wsClient);
		
	})
})var clients = [];
const webSocket = new WebSocket("ws://127.0.0.1:8080");


webSocket.addEventListener("open", () => {
	
log("Working?");

pingInterval = setInterval(() => {
	log(`SENT: ping: ${counter}`);
	webSocket.send("ping");
},1000);

})
