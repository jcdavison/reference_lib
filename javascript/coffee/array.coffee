# .map() returns a new array
n = [1,2,3,3,3,2,2]
result = n.map (e,i,o) ->
  e + 2
console.log result

# .forEach() vanilla left to right iteration
n = [1,2,3,3,3,2,2]
n.forEach (e,i,o) ->
  console.log e + 2

# .every checks if all elements match a condition
console.log 'is true?', n.every (e,i,o) ->
  typeof e is 'number'

# filter, like .select()
n = [1,2,3,3,3,2,2]
o = n.filter (e,i,o) ->
  e == 2
console.log o

# check if Array
console.log Array.isArray n

result = n.reduce (previous, current) ->
  return previous + current
console.log result
