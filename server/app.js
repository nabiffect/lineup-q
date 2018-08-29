const express = require('express')
const bodyParser = require('body-parser');

const app = express()
app.use(bodyParser.urlencoded({extended:true}))
app.use(bodyParser.json())

//Nagle Algorithm off
app.use(function(req,res,next){
	req.connection.setNoDelay(true);
	if (req.url.match(/^\/(css|js|img|font|png|jpg|jpeg|gif|bmp)\/.+/)) {
	} else {
		res.header("Cache-Control", 'private, no-cache, no-store, must-revalidate');
		res.header('Expires', '0');
		res.header('Pragma', 'no-cache');
	}
	respCorsHeader(req,res);
	next();
});

function respCorsHeader(req,res) {
	// res.header("Access-Control-Allow-Origin", req.protocol+"://" + apiinfo.origin_domain);
	res.header("Access-Control-Allow-Origin", "*");
	res.header("Access-Control-Allow-Headers", "X-Requested-With");
	res.header("Access-Control-Allow-Methods", "POST, GET, PUT, DELETE, OPTIONS");
	res.header("Access-Control-Allow-Credentials", true);
	return res;
}

const fs = require('fs')
const key = JSON.parse(fs.readFileSync('./.key', 'utf8'))
require('./api')(app, key);

const server = app.listen(3000, function(){
  console.log('server is running on port 3000')
});

const io = require('socket.io')(server);

io.on('connection', (socket) => {
  console.log("connected:"+socket.id);

  socket.on('SEND_MESSAGE', (data) => {
    io.emit('MESSAGE', data);
  });
});