const socket = require("ws");
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
