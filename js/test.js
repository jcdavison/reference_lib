var Animal = {
  extinctionStatus: "dead"
}

if (typeof Object.create !== 'function') {
  Object.create = function (o) {
    var F = function () {};
    F.prototype = o;
    return new F();
  };
};	

var dog = Object.create(Animal)
console.log(dog.extinctionStatus)
