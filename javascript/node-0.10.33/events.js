// events  
// lots of node objects emit events, anything that emits and event is an instance of 
// events.EventEmitter

var net = require('net');
var server = net.createServer(function(connection) { //'connection' listener
  console.log('server connected');

  // connection.on('end', function() {} )
  // is an example of an EventEmitter
  connection.on('connection', function (stream) {
    console.log('someone connected!');
    console.log(stream)
  });

  connection.on('end', function() {
    console.log('server disconnected');
  });

  connection.write('hello\r\n');
  connection.pipe(connection);
});

server.listen(8000, function() { //'listening' listener
  console.log('server bound');
});
