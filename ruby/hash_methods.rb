names = {  person1: "jake" , person2: "joan", person3: "jim"}
puts "\n#[]"
puts "names= #{names}, names[person1] returns #{names[:person1]}"
puts "names= #{names}, names[person1]='JOHN' returns #{names[:person1]='JOHN'}, names = #{names}"

puts "\n#assoc"
names_array = [ "davison", "smith", "simpson" ]
names = {  person1: "jake" , person2: "joan", person3: names_array}
puts "names= #{names}\nnames.assoc(:person3) returns #{names.assoc(:person3)}"

puts "\n#clear"
puts "names= #{names}\nnames.clear returns #{names.clear}, names = #{names}"

puts "\n#delete"
names = {  person1: "jake" , person2: "joan", person3: "jim"}
puts "names= #{names}\nnames.delete(:person3) returns #{names.delete(:person3)}, names = #{names}"

puts "\n#delete_if"
names = {  person1: "jake" , person2: "joan", person3: "jim"}
puts "names= #{names}\nnames.delete_if {|k| k == :person1 } returns #{names.delete_if{|k| k == :person1}}, names = #{names}"
puts "names= #{names}\nnames.delete_if {|k,v| v == 'joan' } returns #{names.delete_if{|k,v| v == 'joan'}}, names = #{names}"

puts "\n#reject"
names = {  person1: "jake" , person2: "joan", person3: "jim"}
puts "names= #{names}\nnames.reject {|k| k == :person1 } returns #{names.reject{|k| k == :person1}}, names = #{names}"
puts "names= #{names}\nnames.reject {|k,v| v == 'joan' } returns #{names.reject{|k,v| v == 'joan'}}, names = #{names}"
puts "names= #{names}\nnames.reject! {|k| k == :person1 } returns #{names.reject!{|k| k == :person1}}, names = #{names}"
puts "names= #{names}\nnames.reject! {|k,v| v == 'joan' } returns #{names.reject!{|k,v| v == 'joan'}}, names = #{names}"

puts "\n#keep_if"
names = {person1: "jake" , person2: "joan", person3: "jim"}
puts "names= #{names}, names.keep_if {|k,v| k == :person1 } returns #{ names.keep_if {|k,v| k == :person1 } }"
puts "names= #{names}"
names = {person1: "jake" , person2: "joan", person3: "jim"}
puts "names= #{names}, names.keep_if {|k,v| v == 'jim'} returns #{ names.keep_if {|k,v| v == "jim" } }"
puts "names= #{names}"

puts "\n#each"
names = {  person1: "jake" , person2: "joan", person3: "jim"}
output = {}
puts "names= #{names}, output = #{output}\nnames.each {|k| output[k]='random_value'} returns #{ names.each {|k| output[k]='random_value'} }, output=#{output}"
puts "note that the k:v pair is treated as a pair even if only k is called upon"
output = {}
puts "names= #{names}, output = #{output}\nnames.each {|k,v| output[k]=v.upcase} returns #{ names.each {|k,v| output[k]=v.upcase} }, output=#{output}"

puts "\n#each_key"
names = {person1: "jake" , person2: "joan", person3: "jim"}
output = [] 
puts "names= #{names}, output = #{output}\nnames.each_key {|k| output << k.to_s.upcase.to_sym } returns #{ names.each_key {|k| output << k.to_s.upcase.to_sym} }, output=#{output}"
puts "interestingly, a key once inserted cannot be changed, it can be deleted or removed"

puts "\n#each_pair"
names = {person1: "jake" , person2: "joan", person3: "jim"}
output = {} 
puts "names= #{names}, output = #{output}\nnames.each_pair {|k, v| output[k.to_s.upcase.to_sym]=v.split('').shuffle!.join } returns #{ names.each_pair {|k,v| output[k.to_s.upcase.to_sym] = v.split('').shuffle!.join } }, output=#{output}"

puts "\n#each_value"
names = {person1: "jake" , person2: "joan", person3: "jim"}
puts "names= #{names}\nnames.each_value {|v| v=v.split('').shuffle.join!.upcase } returns #{ names.each_value {|v| v=v.split('').shuffle!.join.upcase! } }, names=#{names}"
puts "this seems useless, anything manipulated must be sent to another hash"

puts "\n#flatten"
names = {person1: "jake" , person2: "joan", person3: "jim"}
puts "names= #{names}\nnames.flatten returns #{ names.flatten }, names=#{names}"

puts "\n#has_key?"
names = {person1: "jake" , person2: "joan", person3: "jim"}
puts "names.has_key?(:person1) returns #{ names.has_key?(:person1) }"

puts "\n#has_value?"
names = {person1: "jake" , person2: "joan", person3: "jim"}
puts "names.has_value?('jake') returns #{ names.has_value?('jake') }"

puts "\n#has_value?"
names = {person1: "jake" , person2: "joan", person3: "jim"}
puts "names.has_value?('jake') returns #{ names.has_value?('jake') }"

puts "\n#invert"
names = {person1: "jake" , person2: "joan", person3: "jim"}
puts "names= #{names}, names.invert returns #{ names.invert }"

puts "\n#key"
names = {person1: "jake" , person2: "joan", person3: "jim"}
puts "names=#{names} names.key('jake') returns #{ names.key('jake') }"

puts "\n#key/key?/keys/length/member?"
names = {person1: "jake" , person2: "joan", person3: "jim"}
puts "names=#{names}\nnames.key('jake') returns #{ names.key('jake') }"
puts "names.key?('person1') returns #{ names.key?('person1') }"
puts "names.keys returns #{ names.keys }"
puts "names.length returns #{ names.length }"
puts "names.member?(:person1) returns #{ names.member?(:person1) }"
puts "names.member?('jake') returns #{ names.member?('jake') }"

puts "\n#merge"
numbers = { a: 1, b: 2, c:3 }
new_numbers = { c:1, d:2 }
puts "numbers= #{numbers}, new_numbers= #{new_numbers}\nnumbers.merge(new_numbers) returns #{ numbers.merge(new_numbers) }"
puts "numbers.merge(new_numbers) {|k, oldval, newval| oldval + newval} returns #{ numbers.merge(new_numbers) {|k, oldval, newval| oldval + newval} }" 

puts "\n#rassoc"
names = {person1: "jake" , person2: "joan", person3: "jim", person4: "jake" }
puts "names=#{names} names.rassoc('jake') returns #{ names.rassoc('jake') }"

puts "\n#replace"
numbers = { a: 1, b: 2, c:3 }
new_numbers = { c:1, d:2 }
puts "numbers= #{numbers}, new_numbers= #{new_numbers}\nnumbers.replace(new_numbers) returns #{ numbers.replace(new_numbers) }\nnumbers= #{numbers}"

puts "\n#select"
names = {  person1: "jake" , person2: "joan", person3: "jim"}
puts "names= #{names}\nnames.select {|k| k == :person1 } returns #{names.select{|k| k == :person1}}, names = #{names}"
puts "names= #{names}\nnames.select {|k,v| v == 'joan' } returns #{names.select{|k,v| v == 'joan'}}, names = #{names}"
puts "names= #{names}\nnames.select! {|k| k == :person1 } returns #{names.select!{|k| k == :person1}}, names = #{names}"
puts "names= #{names}\nnames.select! {|k,v| v == 'joan' } returns #{names.select!{|k,v| v == 'joan'}}, names = #{names}"

puts "\n#shift"
names = {  person1: "jake" , person2: "joan", person3: "jim"}
puts "names= #{names}\nnames.shift returns #{ names.shift }, names=#{names}"

puts "\n#size"
names = {  person1: "jake" , person2: "joan", person3: "jim"}
puts "names= #{names}\nnames.size returns #{ names.size }"

puts "\n#to_a"
names = {  person1: "jake" , person2: "joan", person3: "jim"}
puts "names= #{names}\nnames.to_a returns #{ names.to_a }, names= #{names}"


puts "\n#has_value/value?"
names = {  person1: "jake" , person2: "joan", person3: "jim"}
puts "names= #{names}\nnames.has_value?('jake') returns #{ names.has_value?('jake') }"
puts "names.value?('jake') returns #{ names.value?('jake') }"

puts "\n#values"
names = {  person1: "jake" , person2: "joan", person3: "jim"}
puts "names= #{names}\nnames.values returns #{ names.values }"

puts "\n#values_at"
names = {  person1: "jake" , person2: "joan", person3: "jim"}
puts "names= #{names}\nnames.values_at(:person1,:person2) returns #{ names.values_at(:person1,:person2) }"
