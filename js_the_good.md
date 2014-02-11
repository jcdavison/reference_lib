## JAVASCRIPT THE GOOD PARTS

##### FALSY

  -  false, null, undefined, "", 0, NaN
  -  All other values are truthy including true, 'false' and all objects.


#### LOGIC & CONTROL FLOW

##### switch (param) { case "condition": {}}

  -  useful for branching logic

```javascript
  var go = function (expr) {
    switch (expr) {
      case "bonkers":
        console.log("i'm all bonkers today")
        break
      case "smiles":
        console.log("i'm all smiles today")
        break
      default:
        console.log("nothing interesting here folks")
    }
  }

  go('bonkers') // i'm all bonkers
```

##### WHILE

  - executes while the condition remains truthy

```javascript
  var countUp = function (n) {
    while (n < 5 ) {
      console.log(n);
      n ++;
    }
  }
  countUp(1)
```

##### for (condition) {}

```javascript
obj = ["a", "b", "c"]
for (element in obj) {
  console.log(obj[element]);
}
```

##### do {} while ()

```javascript
(function() {
  var x = 1;
  do {
    console.log("i'm doing something", x ++);
  } 
  while (x < 5);
})();
```

##### TRY {} CATCH () {}

- useful for conditional logic based on exceptions or code that won't run

```javascript
  (function() {
    try {
    console.log(variablethatdoesntexist)
    } 
    catch (param) {
      console.log(param)
    }
  })();
```

##### THROW

- useful for raising customer errors 

```javascript
(function() {
  throw "this doesn't work"
})();
```

## ON OBJECTS

#### GLOBAL ABATEMENT

  - don't store things on the global variable scope...

```javascript
  App = {};
  App.services = {
    doStuff: function () {
      console.log("doStuff")
    }
  }
  App.services.doStuff()
```

# NOTE, THINK ABOUT THIS...

  - the simple types of JS are numbers, strings, boleans null and undefined
  - EVERYTHING ELSE IS AN OBJECT...
  - Objects are mutable key collections....
  - arrays are objects, functions are objects, regular expressions are objects, objects are objects
  - an object is a container of properties, a property has a name and value
  - a name can be a string or empty string
  - a property can be any JS value expect undefined
  - inheritence is tied to prototype linkage, useful for initialization and memory consumption.
  - names can be legal JS names, ie first_name but for first-name it must be a string 'first-name'



##### INTROSPECTION, typeof, hasOwnProperty

```javascript
(function() {
  obj = {name: "john", age: 1}
  console.log(typeof obj.name)
  console.log(obj.hasOwnProperty('name'))
})();
```

##### ENUMERATION notes...

  - Consider iterating through an object and wanting all the properties, a filter is needed to ensure functions/prototypes don't get returned, unless of course, that is desired behavior.

```javascript
(function() {
  obj = {name: "john", age: 1, doStuff: function () {console.log("doStuff");}}
  for (e in obj) {
    if (typeof obj[e] !== 'function') {
      console.log(obj[e]);
    }
  }
})();
```
  - delete

```javascript
(function() {
  obj = {
    name: "john", 
    age: 1, 
    doStuff: function () {console.log("doStuff");}
  }

  console.log(obj.name);
  delete obj.name;
  console.log(obj.name);
  
})();

```

## ON FUNCTIONS

  - functions are object
  - objects are collections of name/value paris with a hidden link to a prototype object
  - objects produced from object literals are linked to Object.prototype
  - every function is also created with 1. function's context and 2. code that implements the functions behavior
  - functions are also all created with a prototype property, its value is an object with a constructor property who's value is the function
  - functions can be sotred in variables, objects and arrays, they can be passed as arguments and can be returned from other functions, since they are objects, they can also have functions.
  - the link between the context of the function and its behavior is governed by the closure, aka, 'this'.


### FUNCTION INVOCATION PATTERNS
some useful background
http://doctrina.org/Javascript-Function-Invocation-Patterns.html

#### METHOD INVOCATION PATTERN

  - when a function is stored as the property of an object, it is called a method.

```javascript
var newObject = {
  value: 0,
  increment: function(inc){
    this.value += inc;
  }
}
newObject.increment(2)
console.log(newObject.value) // 2
```

#### FUNCTION INVOCATION PATTERN

  - when a function is called strictly by using (), and is bound to the global context, this is messy 
  - think about calling functions inside function, if the function is called .someFunction() what is the scope it gets called on? 

```javascript
(console.log("this is happening"))
```

#### CONSTRUCTOR INVOCATION PATTERN

  - when a function is called strictly by using (), and is bound to the global context, this is messy.
  - this is not a recommended style of usage.

```javascript
// create an object with a status property
var Quo = function (string) {
  this.status = string;
}
console.log(Quo)
// give all intances a public method .get_status()
Quo.prototype.get_status = function () {
  return this.status;
}

var newQuo = new Quo("happy")
console.log(newQuo.get_status())
```

#### APPLY INVOCATION PATTERN 
  - works by "applying" applying to an object..

```javascript
var obj = {
  message: "hey"
};
var displayGreeting = function () {
  console.log(this.message);
}
displayGreeting.apply(obj);

```

#### FUNCTIONS' ARGUMENTS
  - args is an 'array-like' object, that can be iterated on.

```javascript
var sum = function () {
  if (arguments.length > 0) {
    console.log(arguments)
  }
}
sum(1,2,3)
```

#### RETURN

  - functions always return something when they reach the end of the {}
  - undefined is returned if no return value specified.

#### EXCEPTIONS
  - not totally disimilar to ruby

```javascript
var add = function (a,b) {
 if (typeof a !== 'number'|| typeof b !== 'number') {
   throw {
     name: "TypeError",
     message: "use numbers"
   };
 }
 return a + b
}

var try_it = function () {
  try {
    add("seven");
  } catch (e) {
    console.log(e.name + " " + e.message);
  }
}
try_it()
```

### AUGMENTING TYPES

  - to add methods to Types, create a prototype on Function and then add to whatever.

```javascript
Function.prototype.method = function (name, func) {
  this.prototype[name] = func;
  return this
}
Number.method('integer', function () {
  return Math[ this < 0 ? 'ceil' : 'floor'](this);
});
console.log((-10/3).integer());
```

### USEFUL THOUGHTS ON CLOSURE


```javascript
var Obj = function () {
  var value = 0;

  return {
    increment: function (inc) {
      value += typeof inc === 'number' ? inc : 1;
    },
    getValue: function (inc) {
      return value
    }
  };
}();

console.log(Obj);
console.log(Obj.increment());;
console.log(Obj.getValue());;
```

- in the above, value is not accesible outside of the function that Obj returns
- in the below, myQuo has direct acces to status, provided via closure
- hmm, after rereading this section, i'm still not sure I'm getting the finer points of good vs bad, but my code still runs...

```javascript
var quo = function (status) {
  return {
    get_status: function () {
      return status;
    }
  };
};

var myQuo = quo("amazed")
console.log(myQuo.get_status())
```

#### CallBacks

```javascript
function DoSomething( activity, activity2, callback) {
  console.log(activity + " " + activity2)
    if(callback) {
      callback()
    }
};

function callBackFunc() {
  console.log("the callback is done");
}

DoSomething("bowl", "ski", callBackFunc)
```


#### TODO

  - not sure I understand currying
