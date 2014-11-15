zlib = require('zlib')
// bindings to zip/gzip etc

var gzip = zlib.createGzip();
var fs = require('fs');
var inp = fs.createReadStream('input.txt');
var out = fs.createWriteStream('input.txt.gz');

inp.pipe(gzip).pipe(out);

//  useful note the compression that has occured
//  http://cl.ly/image/222e2m031x0c
