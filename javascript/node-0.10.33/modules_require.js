// require useful for including things

var circle = require('./lib/circle.js');
console.log( 'The area of a circle of radius 4 is '
           + circle.area(4));

// if you want the root of a module to export a function
// or export a complete object in one assignment vice building it one property at a time
// use the module.exports = function (args ) { // return } example is square.js

var square = require('./lib/square.js');
var mySquare = square(2);
console.log('The area of my square is ' + mySquare.area());
