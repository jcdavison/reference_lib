var names = new Array
console.log(names)
console.log("names = " + names + "and is " + names.length + " elements long" )

//push
console.log("\n#push - adds one element to the end of array")
console.log("names = " + names + " names.push('john') returns " + names.push('john') + " names = " + names )
console.log("names = " + names + " names.push('joan') returns " + names.push('joan') + " names = " + names )

//pop
console.log("\n#pop - removes last element from the end of the array")
console.log("names = " + names + " names.pop() returns " + names.pop() + " names = " + names )

//reverse
var names = [ "john", "jane", "jim" ]
console.log("\n#reverse - reverse order of array")
console.log("names = " + names + " names.reverse() returns " + names.reverse() + " names = " + names )

//shift
var names = [ "john", "jane", "jim" ]
console.log("\n#shift - removes first element of array, opposite of pop")
console.log("names = " + names + " names.shift() returns " + names.shift() + " names = " + names )

//unshift
var names = [ "john", "jane", "jim" ]
console.log("\n#unshift(['new', 'elements']) - adds elements to beginning of array")
console.log("names = " + names + " names.unshift(['tim', 'jan']) returns " + names.unshift(['tim', 'jan']) + " names = " + names )

//sort
var letters = [ "z", "x", "y", "d", "c", "a" ]
console.log("\n#sort - sort order of array")
console.log("letters = " + letters + " letters.sort() returns " + letters.sort() + " letters = " + letters )

//splice
var names = [ "john", "jane", "jim" ]
console.log("\n#splice - splice(starting_element,qty,['new','elements']) deletes and adds elements to array")
console.log("names = " + names + " names.splice(1) returns " + names.splice(1) + " names = " + names )
var names = [ "john", "jane", "jim" ]
console.log("names = " + names + " names.splice(2) returns " + names.splice(2) + " names = " + names )
var names = [ "john", "jane", "jim" ]
console.log("names = " + names + " names.splice(0,1) returns " + names.splice(0,1) + " names = " + names )
var names = [ "john", "jane", "jim" ]
console.log("names = " + names + " names.splice(0,1,'mary') returns " + names.splice(0,1,'mary') + " names = " + names )
var names = [ "john", "jane", "jim" ]
console.log("names = " + names + " names.splice(0,0,'mary') returns " + names.splice(0,0,'mary') + " names = " + names )

//concat
var names = [ "john", "jane", "jim" ]
console.log("\n#concat - concat two arrays together")
console.log("names = " + names + " names.concat([1,2,3,4,5]) returns " + names.concat([1,2,3,4,5]) + " names = " + names )

//join
var names = [ "john", "jane", "jim" ]
console.log("\n#join - joins elements of array")
console.log("names = " + names + "names.join() returns " + names.join() + "names.length = " + names.length )
console.log("names = " + names + "names.join('') returns " + names.join('') + "names.length = " + names.length )
var name = names.join()
console.log("names = " + names + " name = names.join(), name = " + name + "name.length = " + name.length )
var name = names.join('')
console.log("names = " + names + " name = names.join(''), name = " + name + "name.length = " + name.length )

//slice
var names = [ "john", "jane", "jim" ]
console.log("\n#slice - slices elements of array")
console.log("names = " + names + "names.slice(0,1) returns " + names.slice(0,1) + " names = " + names )
console.log("names = " + names + "names.slice(0,2) returns " + names.slice(0,2) + " names = " + names )
