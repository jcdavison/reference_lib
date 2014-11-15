// you must explicitly enter 'repl' to work with the code 
// as in ruby pry
// useful commands are 'next', 'repl', 'cont'
// add a debugger statement to the code
// run the code with 'node debug file.js'
// running with debug automatically sets the nature of the code to be step by step
// inserting debugger creates preexisting break points in the code

var one = 1
var two = 2

var addition = function (args) {
  for (arg in args) {
    console.log(arg + one)

    console.log(arg + two)
  }
}

var integers = [1,2]
addition(integers)
