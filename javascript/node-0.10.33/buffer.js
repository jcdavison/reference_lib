// js is unicode friendly but not friendly to binary data.  
// a buffer is a structure that allows us to handle octet stream
// raw data is stored in the buffer, simil to array but it stores raw memory allocations from 
// outside the V8 heap
// this object seems pretty straight forward in the docs
// though i'm not entirely sure I have a model of what/how i would use it


buf = new Buffer(256);
len = buf.write('\u00bd + \u00bc = \u00be', 0);
console.log(len + " bytes: " + buf.toString('utf8', 0, len));
