// http://en.wikipedia.org/wiki/Transmission_Control_Protocol
// useful for creating a tcp server

var net = require('net');

var server = net.createServer(function(connection) { //'connection' listener
  console.log('server connected');
  connection.on('end', function() {
    console.log('server disconnected');
  });
  connection.write('hello\r\n');
  connection.pipe(connection);
});
server.listen(8124, function() { //'listening' listener
  console.log('server bound');
});
