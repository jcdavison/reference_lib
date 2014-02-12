puts "[ 1,2,3,4,5 ] & [ 1,3 ] returns " + ([ 1,2,3,4,5 ] & [ 1,3 ]).to_s 
puts "\n[ 1,2,3,4,5 ] * 3 returns #{([ 1,2,3,4,5 ] * 3).to_s }"
puts "\n[ 1,2,3,4,5 ] * \",\" returns '#{([ 1,2,3,4,5 ] * ",").to_s }'"
puts "\n[ 1,2,3,4,5 ] + [6,7,8] returns #{([ 1,2,3,4,5 ] + [6,7,8]).to_s }"
puts "\n[ 1,2,3,4,5 ] - [4,5] returns #{([ 1,2,3,4,5 ] - [4,5]).to_s }"
puts "\n[ 1,2,3,4,5 ] << [6] << 5 returns #{([ 1,2,3,4,5 ] << [6] << 5).to_s }"

puts "\n COMMON USEFUL ENUMERATIVES"
puts "\n#select"
numbers = [ 1, 2, 3, 3, 3, 3, 4 ]
puts "numbers = #{numbers}\nnumbers.select {|n| n%2 == 0} returns #{numbers.select {|n| n%2 == 0}}, numbers = #{numbers}"
puts "numbers.select! {|n| n%2 == 0} returns #{numbers.select! {|n| n%2 == 0}}, numbers = #{numbers}"
puts "works like .keep_if"

puts "\n#collect"
names = [ "john", "jane", "jim", "joan" ]
puts "names.collect {|name| name.upcase} returns #{names.collect{|name| name.upcase}}, names = #{names}"
puts "names.collect! {|name| name.upcase} returns #{names.collect!{|name| name.upcase}}, names = #{names}"

puts "\nreverse_each"
numbers = [ 1, 2, 3, 4, 5 ]
output = []
puts "numbers = #{numbers}\noutput = #{output}\nnumbers.reverse_each {|n| output << n+1} returns #{numbers.reverse_each {|n| output << n+1}}, output = #{output} "
puts "like each but starts at array[-1] and goes to array[0]"

puts "\n#each"
output = []
puts "numbers = #{numbers}\noutput = #{output}\nnumbers.each {|n| output << n+1} returns #{numbers.each {|n| output << n+1}}, output = #{output} useful for iteration"

puts "\n#each_index"
names = [ "john", "jane", "jim", "joan" ]
output = []
puts "names = #{names}\noutput = #{output}\nnames.each_index {|n| output << n} returns #{names.each_index {|n| output << n}}, output = #{output} useful for iteration"

puts "\n#map"
numbers = [ 1, 2, 3, 4, 5 ]
puts "numbers = #{numbers}\nnumbers.map {|n| n+2 } returns #{numbers.map {|n| n+2}} numbers = #{numbers}"

puts "END ENUMERATIVES"
puts "\n#assoc"
names = [ "john", "jane", "jim", "joan" ]
numbers = [ 1, 2, 3, 4, 5 ]
composite = [ names, numbers ]

puts "\n#assoc"
puts "names= #{names}, numbers= #{numbers}, composite= #{composite}"
puts "composite.assoc('john') returns #{composite.assoc('john')}"
puts "\n#at"
puts "names.at[0] returns #{names.at(0)}"

puts "\n#clear"
puts "names.clear returns #{names.clear}, this impacts the array object"

puts "\n#compact"
names = [ "john",nil,"jane",nil,"jim","joan" ]
puts "\nnames = #{names}\nnames.compact returns #{names.compact}"

puts "\n#concat"
numbers = [ 1, 2, 3, 4, 5 ]
puts "names = #{names}\nnumbers = #{numbers}\nnames.concat(numbers) returns #{names.concat(numbers)}"

puts "\n#count"
puts "numbers = #{numbers}\nnumbers.count {|n| n%2==0} returns #{numbers.count {|n| n%2==0}}, useful for counting qty of conditions met"

puts "\n#cycle"
names = [ "john", "jane", "jim", "joan" ]
names_output = []
puts "names = #{names}\nnames_output = #{names_output}\nnames.cycle(2) {|name| names_output << name } returns #{ names.cycle(2){|name| names_output << name } } and names_output = #{ names_output }"
puts "if no param .cycle('n') is passed, cycle will execute ad infinitum"

puts "\n#delete"
puts "names = #{names}\nnames.delete('john') returns #{names.delete('john').to_s} and names = #{ names }"

puts "\n#delete_at"
puts "names = #{names}\nnames.delete_at(2) returns #{names.delete_at(2)} and names =#{ names }"

puts "\n#delete_if"
puts "\nnames = #{names}\nnames.delete_if { |x| x == 'jane'} returns #{names.delete_if {|name| name == 'jane'}} and names = #{ names }"

puts "\n#drop"
names = [ "john", "jane", "jim", "joan" ]
puts "names = #{names}\nnew_names = names.drop(2) returns #{new_names = names.drop(2) } and new_names = #{new_names} and names = #{names} "

puts "\n#drop_while"
numbers = [ 1, 2, 3, 4, 5 ]
puts "numbers = #{numbers}\nnumbers.drop_while {|n| n<4} returns #{numbers.drop_while {|n| n<4}}, useful for conditional dropping"

puts "\n#fill"
numbers = [ 1, 2, 3, 4, 5 ]
puts "numbers = #{numbers}\nnumbers.fill(5) returns #{numbers.fill(5)}, useful for manipulating contents, numbers = #{numbers}"
puts "numbers = #{numbers}\nnumbers.fill(-3) {|i| i*i} returns #{numbers.fill(-3) {|i|i*i}}"

puts "\n#first"
numbers = [ 1, 2, 3, 4, 5 ]
puts "numbers = #{numbers}\nnumbers.first(3) returns #{numbers.first(3)}"

puts "\n#flatten"
numbers = [ 1, 2, 3, 4, 5, numbers ]
puts "numbers = #{numbers}\nnumbers.flatten returns #{numbers.flatten}"

puts "\n#index"
numbers = [ 1, 2, 3, 4, 5 ]
puts "numbers = #{numbers}\nnumbers.index(3) returns #{numbers.index(3)}"

puts "\n#insert"
numbers = [ 1, 2, 3, 4, 5 ]
puts "numbers = #{numbers}\nnumbers.insert(3,45) returns #{numbers.insert(3,45)}"

puts "\n#join"
numbers = [ 1, 2, 3, 4, 5 ]
puts "numbers = #{numbers}\nnumbers.join returns #{numbers.join}"
puts "numbers = #{numbers}\nnumbers.join('*') returns #{numbers.join('*')}"

puts "\n#keep_if"
numbers = [ 1, 2, 3, 4, 5 ]
puts "numbers = #{numbers}\nnumbers.keep_if {|n| n%2 == 0} returns #{numbers.keep_if {|n| n%2 == 0}}"

puts "\n#last"
numbers = [ 1, 2, 3, 4, 5 ]
puts "numbers = #{numbers}\nnumbers.last(2) returns #{numbers.last(2)}"

puts "\n#permutation"
numbers = [ 1, 2, 3, ]
puts "numbers = #{numbers}\nnumbers.permutation.to_a returns #{numbers.permutation.to_a}, useful for something?"

puts "\n#pop"
numbers = [ 1, 2, 3, 4, 5 ]
puts "numbers = #{numbers}\nnumbers.pop returns #{numbers.pop}, numbers = #{numbers} useful for RPN"

puts "\n#push"
numbers = [ 1, 2, 3, 4 ]
puts "numbers = #{numbers}\nnumbers.push(5) returns #{numbers.push(5)}, numbers = #{numbers} useful for RPN"

puts "\n#rassoc"
names = [ [1, "john"], [2, "jane"], [3, "jim"], [4, "joan"] ]
puts "names = #{names}\nnames.rassoc('john') returns #{names.rassoc('john')}, names = #{names}"
puts "useful for evaluating the 2nd element in an array nested in an array"

puts "\n#replace"
numbers = [ 1, 2, 3, 4 ]
other_numbers = [ 5,6,7,8 ]
puts "numbers = #{numbers}\nnumbers.replace(other_numbers) returns #{numbers.replace(other_numbers)}, numbers = #{numbers}"

puts "\n#rindex"
numbers = [ 1, 2, 3, 3, 3, 3, 4 ]
puts "numbers = #{numbers}\nnumbers.rindex(3) returns #{numbers.rindex(3)}"

puts "\n#rotate"
numbers = [ 1, 2, 3, 3, 3, 3, 4 ]
puts "numbers = #{numbers}\nnumbers.rotate(3) returns #{numbers.rotate(3)}, numbers = #{numbers}"
puts "clockward rotation of a series of elements into a new array"

puts "\n#sample"
numbers = [ 1, 2, 3, 3, 3, 3, 4 ]
puts "numbers = #{numbers}\nnumbers.sample(3) returns #{numbers.sample(3)}, numbers = #{numbers}"
puts "it returns a random sample of the array"

puts "\n#shift"
numbers = [ 1, 2, 3, 3, 3, 3, 4 ]
puts "numbers = #{numbers}\nnumbers.shift(3) returns #{numbers.shift(3)}, numbers = #{numbers}"
puts "not totally sure what the point of this is"

puts "\n#unshift"
numbers = [ 1, 2, 3, 3, 3, 3, 4 ]
puts "numbers = #{numbers}\nnumbers.unshift(3) returns #{numbers.unshift(3)}, numbers = #{numbers}"


puts "\n#slice"
numbers = [ 1, 2, 3, 3, 3, 3, 4 ]
puts "numbers = #{numbers}\nnumbers[3] returns #{numbers[3]}, numbers = #{numbers}"
puts "numbers = #{numbers}\nnumbers[3..5] returns #{numbers[3..5]}, numbers = #{numbers}"
puts "selects a range based on index"
puts "numbers = #{numbers}\nnumbers[0,2] returns #{numbers[0,2]}, numbers = #{numbers}"
puts "selects a range based on starting point and qty of elements"
puts "numbers = #{numbers}\nnumbers.slice(3) returns #{numbers.slice(3)}, numbers = #{numbers}"
puts "numbers = #{numbers}\nnumbers.slice!(3) returns #{numbers.slice!(3)}, numbers = #{numbers}"

puts "\n#sort"
numbers = [ 5,6,2,3,7,8,1,0 ]
puts "numbers = #{numbers}\nnumbers.sort returns #{numbers.sort}, numbers = #{numbers}"
puts "numbers = #{numbers}\nnumbers.sort! returns #{numbers.sort!}, numbers = #{numbers}"

puts "\n#take"
numbers = [ 1, 2, 3, 3, 3, 3, 4 ]
puts "numbers = #{numbers}\nnumbers.take(3) returns #{numbers.take(3)}, numbers = #{numbers}"
puts "kind of like slice"


puts "\n#take_while"
numbers = [ 1, 2, 3, 3, 3, 3, 4, 5, 6, 7 ]
puts "numbers = #{numbers}\nnumbers.take_while {|n| n < 4 } returns #{numbers.take_while{|n| n < 4 }} numbers = #{numbers}"

puts "\n#uniq"
numbers = [ 1, 2, 3, 3, 3, 3, 4, 5, 6, 7 ]
puts "numbers = #{numbers}\nnumbers.uniq returns #{numbers.uniq} numbers = #{numbers}"

puts "\n#|"
numbers = [ 1,2,3,4,4,4 ]
other_numbers = [ 4,4,4,5,6,7 ]
puts "numbers = #{numbers}, other_numbers = #{other_numbers}\nnumbers|other_numbers returns #{numbers|other_numbers}, numbers = #{numbers}"

