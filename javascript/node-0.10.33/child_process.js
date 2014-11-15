// this makes sense
// seems like it might be useful in application
// to spawn child processes to do things
// and then fire a call back when done
var spawn = require('child_process').spawn,
    grep  = spawn('grep', ['blah']);

console.log('Spawned child pid: ' + grep.pid);
console.log('connected status: ' + grep.connected)

grep.stdin.end();
