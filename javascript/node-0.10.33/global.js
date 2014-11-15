// in the browser, top level scope is the 'global' scope
// node isn't the same
// in node, the top level scope is the highest most scope inside a module
// global objects are avail in all modules
// there is a slight difference between being in the global scope and being module accessible
//
// look at node api docs for Process, Console, Buffer, Require, Module
// setTimeout, clearTimeout, setInterval, clearInterval are all global avail


// __filename

console.log(__filename)
console.log(__dirname)
