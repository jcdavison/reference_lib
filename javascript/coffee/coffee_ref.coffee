# COFFEE SCRIPT BASICS
# not understood topics
# mixins, class extension, destructuring assignments
# to compile coffee, => coffee --compile file.name


func = -> 

#a typical function is defined below
multiply = ( a=1, b=2 ) ->
  a * b

some_function = (params) =>
  # the fat arrow ensure that the context of the element
  # that the function was called in is maintained.  

some_object = { one: 1, two: 2 }
#or 
some_object =  one: 1, two: 2 
# braces are optional
some_object = 
  one: 1
  two: 2
# and also multi-line def is ok
some_array = [1,2,3]
# must have brackets, or else it might think it was an object...

if true == true
  alert("everything ok")
  # the line break is the then
if true != true then "panic"
  # or a then statement on the same line
console.log "foo" if bar == true

if true is true
  console.log "true"
# lots of flow control tools
if true isnt true
  console.log "not true"

bar = "using ruby style stuff"
foo = "some variable that gets interpolated by #{bar}"

unless bar 
  console.log "foo"

#loops

for name in ["name1", "name2", "name3"]
  console.log name
for name, i in ["name1", "name2", "name3"]
  console.log i # yields index
  console.log name # yields actual value

num = 6
minstrel = while num -= 1
  num + "brave sir robin ran away"

# ARRAYS
range = [1..5] 
first_two = ["one", "two", "three"][0..1]
# the 0..1 acts as slice of position zero and one
numbers = [0..9]
numbers[3..5] = [-3,-4,-5]
my = "my string"[0..1]
# slice works on strings too
some_array = ["john", "jim", "mary"]
console.log "foo" if "john" in some_array

# ALIAS
@ This
@savior = true
:: prototype
? checks for null or undefined #useful to avoid type conversion problems
some_variable = other ? 45 # ? acts like ruby ||
object.first_function()?.other_function() # ? ensures that first_function doesn't return null
object.first_function().other_function?() # ? checks if other_function is defined or it won't call

# CLASSES

class House
  constructor: (name) ->
    @name = name
  constructor: (@name) ->
    #same as above

#instance properties
class House
  price: 4
  sell: (customer) ->
home = new House
home.sell(new Customer)
#also prserving context
class House
  price: 5
  sell: => 
    console.log "show me the #{@price} money"
home = new House
$("#sell").click(home.sell)
#class properties can be set by defining them on this
class House
  this.find = (name) ->
House.find("some house")
class House
  @find: (name) ->
House.find("some other house")
#inheritence is done through extends...
#coffee used prototypal so all objects correctly inherit
class House
  constructor: (@name) ->
  built: -> 
    false
class Room extends House
  constructor: ->
    super("building")
  crumbled: -> 
    not @built()
home = new House("SomePlace")

# EACH
some_function(item) for item in array
# MAP parens are mandatory
result = (item.name for item in array)
# SELECT
result = (item for item in array when item.name is "some name")
# INCLUDE
included = "test" in array
# PROPERTY ITERATION uses for and of as in is reserved for arrays
object = { one: 1, two: 2 }
console.log("#{key} = #{value}") for key, value of object
# AND - OR - IS - ISNT coffee script likes semantic code
and == && # and is preferred for readability
or == || # or is
is == ==
isnt == !=
object |= {}
# but because js recognizes "" or 0 as null
object ?= {} # is even better

# EXTERNAL LIBRARIES
$ = jQuery
$ -> 
  $(".el").click ->
    console.log "foo"

# DO executes a function immediately
# scope is contained only inside this function
type = do ->
#
