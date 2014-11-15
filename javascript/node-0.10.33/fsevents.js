// POSIX wrapper that operates in synchronous and a-synsynchronous fashions
// Portable Operating System Interface
// http://en.wikipedia.org/wiki/POSIX

var fs = require('fs');

var example = 'example'

fs.mkdir(example, ['0777'], function () {
  fs.writeFile(example + '/' + 'file.txt', 'this is a file')
  fs.readdir(example, function (error, files) {
    console.log(files)
  });
});
