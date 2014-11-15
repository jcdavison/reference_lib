// For printing to stdout and stderr. 
// Similar to the console object functions provided by most web browsers, here the output is sent to stdout or stderr.

count = [1, 2, 4, 5]
console.log('count: %d', count[0]);
console.warn(count)


console.time('100-elements');
for (var i = 0; i < 100; i++) {
  ;
}
console.timeEnd('100-elements');
