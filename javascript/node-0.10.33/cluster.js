// cluster is used to create a cluster of node processes
// useful for taking advantage of multi-core cpus
// useful for creating child processes that share all server ports
// the api documents all expected lifecycle events related to master/worker 
// creation, usage, mgmt and destructin processes

var cluster = require('cluster');
var http = require('http');
var numCPUs = require('os').cpus().length;
// console.log(numCPUs)

if (cluster.isMaster) {
  // Fork workers.
  for (var i = 0; i < numCPUs; i++) {
    cluster.fork();
  }

  // Go through all workers
  function eachWorker(callback) {
    for (var id in cluster.workers) {
      callback(cluster.workers[id]);
    }
  }
  eachWorker(function(worker) {
    worker.send('big announcement to all workers');
    console.log(worker.workerID)
  });

  cluster.on('exit', function(worker, code, signal) {
    console.log('worker ' + worker.process.pid + ' died');
  });
} else {
  // Workers can share any TCP connection
  // In this case its a HTTP server
  http.createServer(function(req, res) {
    console.log(req)
    res.writeHead(200);
    res.end("hello world\n");
  }).listen(8000);
}
