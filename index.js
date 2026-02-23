var clients = [];
const webSocket = new WebSocket("ws://127.0.0.1:8080");


webSocket.addEventListener("open", () => {
	
log("Working?");

pingInterval = setInterval(() => {
	log(`SENT: ping: ${counter}`);
	webSocket.send("ping");
},1000);

})
