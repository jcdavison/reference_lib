// The crypto module offers a way of encapsulating secure credentials to be used as part of a secure HTTPS net or http connection.
// It also offers a set of wrappers for OpenSSL's hash, hmac, cipher, decipher, sign and verify methods.
// apparently, this doesn't even work
// node is telling me that 'crypto' is undefined
// node docs say this is cat 2 unstable, mostly to be avoided...

require('crypto') 

var ciphers = crypto.getCiphers();
console.log(ciphers)
