## SUMMARY OF PRACTICAL OO DESIGN
http://www.poodr.com/
code repo https://github.com/skmetz/poodr

## SINGLE PURPOSE FUNCTIONALITY

#### Core questions to help think about classes

  * What are classes?
  * How many should you have?
  * What behavior should they implement?
  * How much to they know about other classes?
  * How much of themselves should they expose?

#### Organize code to allow for easy changes; define easy as,

  * Changes doen't have unexpected side effects.
  * Small changes in requirements have equally small code changes.
  * Exisiting code is easy to reuse.
  * The easiest way to make a change is to add code that in itself if easy to change.
  
#### Write TRUE code ( transparent, reasonable, usable, exemplary )

  * Transparent, the consequences of change should be ovious in the code that is changing and in distant code that relies on it.
  * Reasonable, the cost of any change shold be proportional to the benefits of the change it achieves.
  * Usable, exisiting code should be usable in new and expected contexts.
  * Exemplary, code itself should encourage those who change it to perpetuate these qualities.  

##### THE FIRST STEP IN WRITING TRUE CODE IS TO ENSURE THAT EACH CLASS HAS A SINGLE, WELL DEFINED RESPONSIBILITY.

####  Single Responsibility Principle

  * When everything in a class is related to its central purpose, is can be said to be highly cohesive.
  * If the description of a class requires 'and', 'or', it probably has complicated dependencies.  
  * Think about RDD, responsibility-driven-design, "a class has responsibilities that fulfill its purpose"

#### Write Code That Embraces Change

##### Depend on behavior, not data.
  
  * Hide instance variables, always wrap instance variables in accessor methods instead of referring to them directly.
  * Note that by using the virtual attr wrapper, chainring now gets referenced as behavior, not data
  * And this behavior can easily be modified without changing 10 different refefences to @chainring
  * Enforce single repsonsibility everywhere, a method does one thing and doesn't have to know anything 
  * Beyond singular given inputs and on action to perform and give outputs

#### Methods with single responsibilities 

  * Expose previously hidden qualities.
  * Avoid the need for comments.
  * Encourage reuse.
  * Are easy to move to another class.

## MANAGING DEPENANCIES

#### SOME GOTCHAS

  * If objects have single responsibility, they must collaborate to do anything.
  * Collaboration requires some kind of awareness or knowingness about others
  * Knowingness creates a dependency, improperly managed, this can strangle an app.


#### DEF: Dependency, consider Gear and Wheel

  * An object depend on another if, when one object changes, the other might be forces to change in turn.

#### Recognizing Dependencies, an object has a dependency when it knows,

  * The name of another class, Gear expects a class named wheel to exist.
  * The name of a message that it intends to send to someone other than self, ie, Gear expects Wheel to respond to diameter.
  * The arguments that a message requires, Gear knows that Wheel.new requires :rim and :tire
  * The order of those arguments, Gear knows the first and second arguments.

#### CBO, Coupling Between Object

  * dependencies couple Gear to Wheel, and alternatively, coupling creates a dependency.  V 

  * you know you are in trouble if, you make a change to Wheel and you find it necessary to change Gear, if you want to reuse Gear and Wheel ends up coming along, and when you test Gear, you inadvertantly test Wheel.

#### DEFENSES AGAINST COUPLING

##### INJECT DEPENDENCIES

  - consider, there is a problem that iff Wheel stops responding to or changes, gear_inches will break and
  - gear_inches will only collaborate with Wheel, when in fact, it shouldn't care where it get diameter from
  - also, having to instantiate Gear with rim and tire, to be passed to Wheel is no good.

  ```ruby
  #BAD
  class Gear
    attr_reader :chainring, :cog, :rim, :tire

    def initialize chainring, cog, rim, tire
      @chainring = chainring
      @cog = cog
      @rim = rim
      @tire = tire
    end

    def gear_inches
      ratio * Wheel.new(rim, tire).diameter
    end
  end

  Gear.new(52,11,25,1.5).gear_inches
  ```

  - instead, dependency inject anything that responds to diameter

  ```ruby
  #good
  class Gear
    attr_reader :chainring, :cog, :wheel

    def initialize chainring, cog, wheel
      @chainring = chainring
      @cog = cog
      @wheel = wheel
    end

    def gear_inches
      ratio * wheel.diameter
    end
  end

  Gear.new(52,11, Wheel.new(26, 1.5)).gear_inches
  #inject the dependancy at formation, and then its just a message that returns data
  ```

  - if the above isn't possible, think about Isolating instance creation so that it isn't tied to a class's unique methods.

  - the below uses the inititalize method

  ```ruby
  class Gear
    attr_reader :chainring, :cog, :rim, :tire
    def initialize(chainring, cog, rim, tire)
      @chainring = chainring
      @cog       = cog
      @wheel     = Wheel.new(rim, tire)
    end

    def gear_inches
      ratio * wheel.diameter
    end
  end
  ```
  
  - or use Ruby ||= inside a method

  ```ruby
  class Gear
    attr_reader :chainring, :cog, :rim, :tire
    def initialize(chainring, cog, rim, tire)
      @chainring = chainring
      @cog       = cog
    end

    def gear_inches
      ratio * wheel.diameter
    end

    def wheel
      @wheel ||= Wheel.new :rim, :tire
    end
  end
  ```

  - Isolate vulnerable external messages, consider that in the above, gear_inches is simple, but if it was complex, it would be bad to have diameter occuring as an External Message. Isolate it a Gear method 


  ```ruby
  class Gear

    def gear_inches
      # code...
      diameter
      # code...
    end

    def diameter
      wheel.diameter
    end
  end
  ```

  - defend against argument order dependencies by using an args or opts hash

  ```ruby
  class Gear

    attr_reader :xxx, :yyy, :zzz

    def initialize args
      @chainring = args[:chainring]
      @cog = args[:cog]
      @wheel = args[:wheel]
    end
  end
  ```

  - in the case of external framwork where methods can't be changed, wrap the args for dependency defense

  ```ruby
  module SomeFramework
    class Gear
      attr_reader :x, :y, :z

      def initialize(x, y, z)
        @x = x
        @y = y
        @z = z
      end
    end
  end

  module GearWrapper
    def self.gear args
      SomeFramework::Gear.new(args[:x], args[:y], args[:z])
    end
  end
  # GearWrapper is what is known as a factory, sole purpose is to create instance of other class
  GearWrapper.gear args
  ```
## INTERFACE

#### RANDOM HEURISTIC 'Depend on things that change less often than you do.'

#### SOLILOQUY ON DESIGN

  - object-oriented app is more than just classes, it is made of up classed but defined by messages, classes control what in in the source code, messages are the living, animated application. Design must therefore be concerened with the messages that pass between objects, it deals with what object know (their responsibilities) and who they know (their dependencies), but also how they talk to one another. The coversation that occurs between objects relates to their interfaces.

#### CHARACTERISTICS OF PUBLIC INTERFACE METHODS...

  - Reveal its primary responsibility.
  - Are expected to be invoked by others.
  - Will not change on a whim.
  - Are safe for others to depend on.
  - Are thoroughly documented in the tests.

#### CHARACTERISTICS OF PRIVATE INTERFACE METHODS...

  - Handle implementation details.
  - Are not expected to be sent by other objects.
  - Can change for any reason whatsoever.
  - Are usafe for others to depend on.
  - May not even be referenced in tests.

#### ON DESIGN

  - when given a large, complex system to model, it could be common to start building Classes based on the big Nouns, but frequently, those nouns are Domain Objects and not really the ultimate classes to be used.
  - think about using UML, uniform modeling language, diagrams, to model and understand the objects and messages.
  - An important shift in thinking is from "I know I need this class, what should it do" to "I need to send this message, who should respond to it?"
  - You don't send messages because you have objects, you have objects because you need to send messages. 

#### CREATE EXPLICIT INTERFACES, METHODS IN THE PUBLIC INTERFACE SHOULD

  - Be explicityly indentified as such.
  - Be more about what than how.
  - Have names that, insofar as you be anticipated, will not change.
  - Take a hash as an options parameter.
  - private methods are the least stable and provide the most resctricted visibility, private methods should never be called from other objects.
  - protected keywords indicates unstable methods, slightly less visiblity restrictions.
  - public indicates it is a stable method and may be called in many places.

## DUCK TYPING
#### public interfaces that are not tied to any specific class.

  - consider the bicycles, customers, vehicles problem,

  ```ruby
    class Trip
      attr_reader :bicycles, :customers, :vehicle

      def prepare prepares
        preparers.each do |preparer|
          case preparer
          when Mechanic
            preparer.prepare_bicycles bicycles
          when TripCoordinator
            preparer.buy_food customers
          when Driver
            preparer.gas_up vehicle
            preparer.fill_water_tank vehicle
          end
        end
      end
    end
  ```
  - the above is nasty, lots of dependencies, very brittle code
  - a Duck type is public method, on different classes, with the same name, and different implementation

  ```ruby
    class Trip
      attr_reader :bicycles, :customers, :vehicle

      def prepare preparers
        preparers.each {|preparer| preparer.prepare_trip self}
      end
    end

    class Mechanic
      def prepare_trip trip
        trip.bicycles.each {|bicycle| bicycle.prepare_bicycle bicycle}
      end
    end

    class TripCoordinator
      def prepare_trip trip
        buy_food trip.customers
      end
    end

    class Driver
      def prepare_trip trip
        vehicle = trip.vehicle
        gas_up vehicle
        fill_water_tank vehicle
      end
    end
  ```

  - the above, prepare_trip is a duck type that can be called in many places and thus removes the dependencies

#### Recognizing hidden ducks, any kind of logic that is routing based on classes

  - Case statements that switch on class
  - use of kind_of? or is_a?
  - responds_to?

## INHERITANCE

#### Anitpatterns related to inheritance, conditional messaging to self based on self.

  - It is not desireable to use conditional statements that check self to determine the output of a method.
  - ie, if self.style == :condition1 return something, is
  - more concretely stated, the presence of an if statement that checks an attribute that holds the category of self to determine what message to send to self.
  - look for keywords of type or category to notice that class like comparisons are being made.
  - think about the nature of many different but related subtypes.

#### Inheritance is; 

  - the idea that two objects have a relationship such that the sub object receiving a message it doesn't understand, autmatically delegates that message up the relationship hierarchy.
  - single inheritance is the idea that an object is only allowed one superclass.
  - subclasses become a specialization of their superclasses.
  - a specialization should be everything its parent is and more. so a subclass should no omit or avoid behaviors contained in its parent.
  - there is almost no reason to create an abstract superclass that has only one subclass.
  - in general, there should be no need to create instances of an abstract superclass.


#### two rules of inheritence

  1 objects that are being modeled must truly have a generalization-specialization relationship
  2 the correct coding techniques must be used.

#### when abstracting a new superclass

  -  push all the behavior into the subclasses first and then pull back into the super class, the behaviors that are abstract and common in nature. ensure the superclass retains no concrete behavior.
  - the danger with leftover concrete behavior in the super is that this behavior may not apply to all subclasses, which by nature, all behavior in a super, must apply to a sub, violation of Rule 1 above.

### Template Method Pattern

  - Technique to define a basic structure in the superclass and send messages to acquire subclass specific contributions.
  - Each subclass supplies its own default for tire_size but uses the super for default chain, or it can initialize it.
  - Note that the Bicycle, does not provide a default tire size, it uses the error to let anyone implementing other sub class to have a clear error message that informs that the sub class needs and implementation of default_tire_size

  ```ruby
  class Bicycle
    attr_reader :size, :chain, :tire_size

    def initialize args={}
      @size = args[:size]
      @chain = args[:chain]  || default_chain
      @tire_size = args[:tire_size]  || default_tire_size
    end

    def default_chain
      '10-speed'
    end

    def default_tire_size
      raise NotImplementedError, "this #{self.class} cannont respond to:" 
    end
  end

  class RoadBike < Bicycle
    def default_tire_size
      '23'
    end
  end

  class MountainBike < Bicycle
    def default_tire_size
      '2.1'
    end
  end
  ```

#### consider how to implement :spares on the above Super/Sub setup.

  - a goal is to reduce the coupling between the super/sub, in the case of implementing :spares, there is wide variablity in what the sub class might want as spares, the super needs to be able to inititalize without concern for what the subs might want or do. a post initialization hook is useful to do this.
  - now instances of RoadBike can override the Bicylce post_initialize method and set attributes
  - it can be very useful to have at least three subclasses to study to realize what the actual abstaract behaiors should be.

  ```ruby
  class Bicycle
    def initialize args={}
      @size = args[:size]
      @chain = args[:chain]  || default_chain
      @tire_size = args[:tire_size]  || default_tire_size

      post_initialize args
    end

    def post_initialize args
      nil
    end

    def spares
      { tire_size: tire_size, chain: chain}.merge local_spares
    end
    # local_sapres and post_initialize are both considered 'hooks' to be overridden
    def local_spares
      {}
    end
  end

  class RoadBike < Bicycle
    def post_initialize args
      @tape_color = args[:tape_color]
    end

    def local_spares
      {tape_color: tape_color}
    end
  end

  class MountainBike < Bicycle
    attr_reader :front_shock, :rear_shock

    def post_initialzie args
      @front_shock = args[:front_shock]
      @rear_shock = args[:rear_shock]
    end

    def local_spares
      {rear_shock: rear_shock}
    end
  end
  ```

## ON MODULES
  
  - Modules provide an alternative to inheritance related to sharing a 'role'.

##### The total set of messages which an object can respond to;

  * Those it directly implementes.
  * Those implemented in all objects above it in the hierarchy.
  * Those implemented in any module that has been added to it.
  * Those implemented in all modules added to any object above it in the hierarchy.

  - consider the use of schedule, a behavior that many objects may want.

  ```ruby 
    class Bicycle
      attr_reader :schedule, :size, :chain, :tire_size

      # Inject the Schedule and provide a default
      def initialize(args={})
        @schedule = args[:schedule] || Schedule.new
        # ...
      end

      # Return true if this bicycle is available
      # during this (now Bicycle specific) interval.
      def schedulable?(start_date, end_date)
        !scheduled?(start_date - lead_days, end_date)
      end

      # Return the schedule's answer
      def scheduled?(start_date, end_date)
        schedule.scheduled?(self, start_date, end_date)
      end

      # Return the number of lead_days before a bicycle
      # can be scheduled.
      def lead_days
        1
      end

      # ...
    end

    require 'date'
    starting = Date.parse("2015/09/04")
    ending   = Date.parse("2015/09/10")

    b = Bicycle.new
    b.schedulable?(starting, ending)
  ```

  * abstract out the messages that enable Scheduling.

  ```ruby
    module Schedulable
      attr_writer :schedule

      def schedule
        @schedule ||= ::Schedule.new
      end

      def schedulable?(start_date, end_date)
        !scheduled?(start_date - lead_days, end_date)
      end

      def scheduled?(start_date, end_date)
        schedule.scheduled?(self, start_date, end_date)
      end

      # includers may override
      def lead_days
        0
      end

    end
  ```

  * then Bicycle, and any other class becomes more like..

  ```ruby
    class Bicycle
      include Schedulable

      def lead_days
        1
      end

      # ...
    end

    class Vehicle
      include Schedulable

      def lead_days
        3
      end

      # ...
    end

    class Mechanic
      include Schedulable

      def lead_days
        4
      end

      # ...
    end
  ```

##### OBVIOUS ANTIPATTERNS WITH MODULES

  * An object that uses a variable with a name like type or category to determine what message to send to self contains two highly related but slightly different types.
  * When a sending object check the class of the receiving object to determine what message to send, this is overlooking a duck type.

#### LSP Liskov Substitution Principle

  * Let q(x) be a property provable about objects x of type T, then q(y) should be true for objects y of type S thwhere S is a subtype of T.
  * English, in order for a type system to have sanity, subtypes must be substitutable for their super types.
  
#### Some best practices...

  * Use the Template Method Pattern.
  * Preemptively decouple classes, avoid requiring inheritors to use super, use hook messages.
  * Create shallow hierarchies.

## Combining Objects with Composition



