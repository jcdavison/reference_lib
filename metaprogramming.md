## META PROGRAMMING IN RUBY

things to understand ? Class Intance Variables, Class Macros, Around Aliases

### The Object Model

  - module path names work just like a file structure

  ```ruby
  module M
    class C
      X = "constant"
    end
  end

  M::C::X

  module M
    Y = "constant"
    class C
      ::M::Y
      # to move up the tree
    end
  end

  module M
    class C
      Module M2
        Module.nesting # [M::C::M2, M::C, M]
      end
    end
  end
  ```

  * DEF: receiver, the object that a method gets called on.
  * DEF: ancestors chain, the heierarchy of classes from a class to Object.


  - note; private methods are called with the implicit receiver self


### CALLING METHODS DYNAMICALLY, aka, Dynamic Dispatch

  - consider a yaml file, with  admin: john title: house hunting
  - and the keys are in a conf file that will be parsed and then initialized, but you can't plan on knowing in advance what keys will be present,
  - consider using .send to dynamically insert methods...

  ```ruby
    yamlconfdata.each do |k,v|
      SomeObject.send("#{k}", v)
    end
  ```
  - the send method is very useful for dynamically inserting the method to be called
  - send can also be used to call an object's private methods, so play nice

  ```ruby 
    class MyClass
      define_method :method_name do |arg|
        arg * 1
      end
    end
  ```

  - dynamically defining methods can be extremely usefull for iterating on objects and turning attributes into methods.

##### method_missing()
  
  - Object has method_missing() defined on it, useful for catching the bubble up on methods that don't exist.
  - if you override it at the class or superclass level, you can use it to make 'ghost methods' and do stuff dynamically.
  - basically, you create a catch all, to an object "if someone sends a message that you don't understand, do this"
  - consider something like a csv, with methods .rows_with_attribute called, sometimes that attribute might change, but if the Object has something like .rows_with(:attribute), a method_missing catch could regex the .rows_with_attributes and convert it into a correctly behaving rows_with(:arg) call. very useful, I think this is how rails must do find_or_create_by_attribute stuff 
  - method_missing is useful for implementing the behavior of an OpenStruct type object.

  * consider 

  ```ruby

    class MyOpenStruct def initialize
        @attributes = {}
    end
    def method_missing(name, *args) attribute = name.to_s
    if attribute =~ /=$/
          @attributes[attribute.chop] = args[0]
    ￼else
          @attributes[attribute]
    end end
    end
  ```

  - method_missing basically converts anything that attempts to set '=' an attribute into a key in the hash.
  - this can also be really useful for gems that hit 3rd party api's, think that if an attribute suddently become avail, you don't have to wait for the gem to be updated to get access to it. 

  - consider that if you use ghost methods, you might want to deal with .responds_to? basically check for the presence of ghost attribute || Super
  - note that in the case that a ghost method conflicts with a defined method elsewhere in the ancestors, the defined method takes priority.
  - because of the lookup process, ghost methods def run slower.
  - note, _send_ or __id__ are reserved ruby methods, not to be used publicly or overwritten.

  ```ruby
    class Computer
      def respond_to?(method)
        @data_source.respond_to?("get_#{method}_info") || super end
      end
    end
  ```

### BLOCKS AND CALLABLE OBJECTS, maybe reread about the notion of a clean room.

  ```ruby
    def a_method(a, b)
      a + yield(a,b)
    end

    a_method(1,2) {|a,b| (a + b) * 3}
  ```

  - the block gets passed straight into the method and then gets run with yield.
  - note, that using begin end, if you add ensure, that code gets run no matter if an exception rises.

  - blocks bind to the scope where they are created

  ```ruby

  def greet
    x =  "Goodbye"
    yield("cruel")
  end

  x = "Hello"
  greet {|y| "#{x}, #{y} world" } # => "Hello cruel world"

  ```

  - all scopes have access to local_variables()
  - a scope gate is a fixed barrier between closures
  - it could be useful to create a new class with a block and then the scope bindings will allow for 'flattening the scope'

  ```ruby
    my_var = "Success"
    MyClass = Class.new do
      puts "#{my_var} in the class definition!"
        define_method :my_method do
          puts "#{my_var} in the method!"
        end 
    end
    MyClass.new.my_method # => Success in the class def, Success in the method.
    ```

    - the proper name for above is 'nested lexical scope' but effectively, using a method binds the local vars to the block
    - scope sharing can be attained by defining methods in the same flat scope as the variable.

  ```ruby 
    def define_methods
      shared = 0
      Kernel.send :define_method, :counter do 
        shared
      end
      Kernel.send :define_method, :inc do |x| 
        shared += x
      end
    end
    define_methods
    counter       # => 0
    inc(4)
    counter       # => 4
  ```

  -  Object.instance_eval {} is a useful tool to pass scope through the gate consider

  ```ruby
    var = 1
    object.instance_eval { @v = var }
    object.instance_eval { @v } # => 1
  ```

#### Deferred evaluation is the process of defining a proc, a objectified block, and calling it later.

  ```ruby
    inc = Proc.new {|x| x + 1}
    inc.call(2) # => 3
  ```

  - the kernal methods lambda and proc basicaly are factories for Procs
  - & converts blocks to procs and backwards as well, useful for passing a block to another method

### CLASS DEFINITIONS
  - a method that applies to one and only one actual object, read not a class, is a singleton.
  - consider

  ```ruby
    str = "just a regular string"
    def str.title? 
      self.upcase == self 
    end
    # .title? is a singleton cause it can only be called on str
  ```

##### SOME HARD TRUTHS
  
  - Classes are just objects, class names are just constants, call a method on a class is the same as call a method on an object.
  - effectivley, class methods are singleton methods, the EigenClass is the ghost class created to encapulate the hierarch of where a singleton methods comes from.

##### THE GREAT UNIFIED THEORY

  - class, eigenclasses, modules, instance methods, class methods and singleton methods combine to form 7 rules

##### 7 RULES OF THE RUBY OBJECT MODEL
  
  1. There is only one kind of object, be it a regular object or a model.
  2. There is only one kind of module, be it regular module, class, eigenclass or proxy class.
  3. There is only one kind of method, and it lives in a module, most often a class.
  4. Every object, classes included, has it own real class, be it a regular class or an eigenclass.
  5. Every class has exactly one superclass, with the exception of BasicObject, which has none, this means that ther is a single ancestors chain from any class up to BasicObject.
  6. The superclass of the EigenClass of an object is the object's class. The superclass of the eigenclass of a class is the eigenclass of the class's superclass.
  7. When you call a method, Ruby goes 'right' in the receiver's real class and then up the ancestors chain, that is all there is to know about the way ruby finds methods.

##### EXTENDING MODULES AS CLASS METHODS

  ```ruby
    module MyModule
      def my_method; 'hello'; end
    end
    class MyClass 
      class << self
        include MyModule
      end
    end

    MyClass.my_method # => 'hello'
  ```

##### EXTENDING MODULES ONTO OBJECTS

  ```ruby
    module MyModule
      def my_method; 'hello'; end
    end
    obj = Object.new
    class << obj
      include MyModule
    end

    obj.my_method # => 'hello'
    # extend works as a method and class macro

    obj.extend MyModule

    class MyClass
      extend MyModule
    end
  ```

##### ALIAS

  ```ruby
    class MyClass
      def method1; "hey" end
      alias :m :method1
    end

    obj = MyClass.new
    obj.m # => 'hey'
    obj.method1 # => 'hey'
  ```
