## JAVASCRIPT THE GOOD PARTS

##### FALSY

  -  false, null, undefined, "", 0, NaN
  -  All other values are truthy including true, 'false' and all objects.


#### LOGIC & CONTROL FLOW

  ```javascript
    var go = function (expr) {
      switch (expr) {
        case "bonkers":
          console.log("i'm all bonkers today")
          break
        default:
          console.log("nothing interesting here folks")
      }
    }
  ```
