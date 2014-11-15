var names = new String
console.log(names)
console.log("names = " + names + "and is " + names.length + " elements long" )

//charAt/charCodeAt
names = "john joe davis clair"
console.log("\n#charAt - returns the char at a given position")
console.log("names = " + names + " names.charAt('3') returns " + names.charAt('3') + " names = " + names )
console.log("names = " + names + " names.charCodeAt('3') returns " + names.charCodeAt('3') + " names = " + names )

//concat
names = "john joe davis clair"
console.log("\n#concat - joins two string")
console.log("names = " + names + " names.concat(' mary mike moe') returns " + names.concat(' mary mike moe') + " names = " + names )

//indexOf
names = "john joe davis clair"
console.log("\n#indexOf - finds the starting position of a given string, if present")
console.log("names = " + names + " names.indexOf('davis') returns " + names.indexOf('davis')  + " names = " + names )

//lastIndexOf
names = "john joe davis joe clair joe"
console.log("\n#lastIndexOf - finds last occurence's starting position of a given string")
console.log("names = " + names + " names.lastIndexOf('joe') returns " + names.lastIndexOf('joe')  + " names = " + names )

//match
names = "john joe davis joe clair joe"
console.log("\n#match - regex matcher")
console.log("names = " + names + " names.match('joe') returns " + names.match('joe')  + " names = " + names )
console.log("names = " + names + " names.match(/joe/) returns " + names.match(/joe/)  + " names = " + names )

//replace
names = "john joe davis joe clair joe"
console.log("\n#match - regex matcher")
console.log("names = " + names + " names.replace(/(joe clair)/,'no one else' ) returns " + "\n" + names.replace(/(joe clair)/,'no one else')  + " names = " + names )

//search
names = "john joe davis joe clair joe"
console.log("\n#search - regex searcher")
console.log("names = " + names + " names.search(/(joe clair)/) returns " + "\n" + names.search(/(joe clair)/)  + " names = " + names )

//slice
names = "john joe davis joe clair joe"
console.log("\n#slice - creates a selection from a string")
console.log("names = " + names + " names.slice(4) returns " + "\n" + names.slice(4)  + " names = " + names )
console.log("names = " + names + " names.slice(4,8) returns " + "\n" + names.slice(4,8)  + " names = " + names )

//split
names = "john joe davis joe clair joe"
console.log("\n#split") 
console.log("names = " + names + " names.split(' ') returns " + "\n" + names.split(' ')  + " names = " + names )

//substr
names = "john joe davis joe clair joe"
console.log("\n#substr, kind of like slice") 
console.log("names = " + names + " names.substr(4,10) returns " + "\n" + names.substr(4,10)  + " names = " + names )

//toLowerCase
names = "John Joe Davis Joe Clair Joe"
console.log("\n#toLowerCase, changes the case") 
console.log("names = " + names + " names.toLowerCase returns " + "\n" + names.toLowerCase()  + " names = " + names )

//toUpperCase
names = "John Joe Davis Joe Clair Joe"
console.log("\n#toUpperCase, changes the case") 
console.log("names = " + names + " names.toUpperCase returns " + "\n" + names.toUpperCase()  + " names = " + names )

//trim
names = "      John Joe Davis Joe Clair Joe       "
console.log("\n#trim off the white space") 
console.log("names = " + names + " names.trim returns " + "\n" + names.trim()  + " names = " + names )

//trimRight
names = "      John Joe Davis Joe Clair Joe       "
console.log("\n#trimRight off the white space") 
console.log("names = " + names + " names.trimRight returns " + "\n" + names.trimRight()  + " names = " + names )

//trimLeft
names = "      John Joe Davis Joe Clair Joe       "
console.log("\n#trimLeft off the white space") 
console.log("names = " + names + " names.trimLeft returns " + "\n" + names.trimLeft()  + " names = " + names )

//valueOf
names = "John Joe Davis Joe Clair Joe"
names_array = ["John", "Joe", "Davis", "Joe", "Clair", "Joe" ]
console.log("\n#valueOf") 
console.log("names = " + names + " names.valueOf() returns " + "\n" + names.valueOf()  + " names = " + names )
console.log("names_array = " + names_array + " names_array.valueOf() returns " + "\n" + names_array.valueOf()  + " names_array = " + names_array )

