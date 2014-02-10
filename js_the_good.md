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

## ON OBJECTS

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


