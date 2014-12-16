# note, 'john' is a primitive and new String('john') is an object, they aren't the same.

person = "john"
console.log person.charCodeAt 1

console.log person.concat person

console.log person.match /jo/
console.log person.match(/jo/)[0]

people = 'john-abby-mike-mary'
console.log people.split '-'

console.log people.anchor people
