## JAVASCRIPT THE GOOD PARTS

##### FALSY

  -  false, null, undefined, "", 0, NaN
  -  All other values are truthy including true, 'false' and all objects.


#### LOGIC & CONTROL FLOW

##### SWITCH and CASE

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

##### FOR

```javascript
obj = ["a", "b", "c"]
for (element in obj) {
  console.log(obj[element]);
}
```

##### DO

```javascript
(function() {
  var x = 1;
  do {
    console.log("i'm doing something", x ++);
  } 
  while (x < 5);
})();
```
