print = (string) ->
  console.log string

example_function = ->
  print "some function"
example_function()

add_numbers = (a,b) ->
  c = a + b
  print c
add_numbers(4,5)

#object instantiations
print "\nan object can be created with or without braces"
print "person1 = { name: 'john', city: 'san francisco' }"
print "person2 = name: 'jane', city: 'san matero'"
person1 = { name: 'john', city: 'san francisco' }
person2 =  name: 'jane', city: 'san mateo'
print( "person1.name = " + person1.name + "\nperson2.name = " + person2.name )

#conditional logic is like ruby
print "\nconditional logic and extrapolition is like ruby"
x = "secret_token"
if x == "secret_token"
  print "#{x}"

print "\nif then is useful..."
check_token = (token) -> 
  print "if token == 'secret_token' then print 'the token is good'"
  if token == 'secret_token' then print 'the token is good'
check_token(x)

print "\nthe trailing if statement"
check_token = (token) -> 
   print "the token is good" if token == "secret_token"
check_token(x)

print "\nthe is statement"
check_token = (token) ->
   print "the token is good" if token is "secret_token"
check_token(x)

print "\nunless token == secret, do something else"
check_token = (token) ->
  unless token == "secret"
    print "that isn't the right token"
check_token(x)

names = [ 'john', 'jim', 'jane', 'joan' ]
print "\n for element in #{names}"
print_array = (array) ->
  for element in names
    print element
print_array(names)

print "\nnames = #{names}\nnames[0..1] = #{names[0..1]}"
#the do if in business isn't working, wtf
print "return 'skillet' if 'john' in names= #{print 'skillet' if 'john' in names}"

#what is this anyways?  
print "\n@ is an alias for this"
print "@ = #{@}"

#now for the main course, classes, aka, prototype

class Space
  constructor: (title, sides) ->
    @title = title
    @sides = sides
print "\ncreate a new space obj alpha = new Space('parisoma', 4) #{alpha = new Space('parisoma', 4)}"
print "alpha.sides = #{alpha.sides}"

class Space
  constructor: (@title, @sides) ->
  #instance variables can be instantiated at construction ie @param1, @paramn

alpha = new Space('citizen space', 8)
print "\nalpha = new Space('citizen space', 8), alpha.title = #{alpha.title}"

class Person extends Space
  constructor: (@name) ->
    super('Person')

print "\ncreate a new person obj person = new Person('john') #{person = new Person('john')}"
person.title = "the hub"
print "person.title = #{person.title}"
print "note that title is an attribute inherited from the space obj"
print person

#Each
print "\n#each"
names = [ 'john', 'jim', 'jane', 'joan' ]
# some_function(element) for element in array
print "print(element) for element in names"
print(element) for element in names

#Map
# new_array = (element.function() for element in other_array)
print "\n#map"
print "names = #{names}"
new_array = (element.toUpperCase() for element in names)
print "new_array = (element.toUpperCase() for element in names)"
print "print new_array #{new_array}\nnames = #{names}"

#select
print "\n#select"
print "names = #{names}"
new_array = (element.toUpperCase() for element in names when element == 'john')
print "new_array = (element.toUpperCase() for element in names when element == 'john')"
print "new_array = #{new_array}"

#key value iteration
hash_object = { name: 'john', location: 'san francisco' }
print "\nhash_object = { name: 'john', location: 'san francisco' }"
print "print('\#{key} = \#{value} for key, value of hash_object = #{ key = value for key, value of hash_object } " 
