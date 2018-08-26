const express = require('express');
const app = express();

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