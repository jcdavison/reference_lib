// Generated by CoffeeScript 1.8.0
(function() {
  var hash, obj, prop;

  hash = {
    attr1: 'john',
    attr2: 'jane'
  };

  obj = {
    a: "value of a",
    b: 2,
    c: 3
  };

  for (prop in obj) {
    obj[prop] = null;
  }

  console.log(obj);

}).call(this);
