## DUCK TYPING


#### Overlooking Ducks

Noticing methods that could be 'ducks' requires paying attention to the nature of what a method does.  A `duck` refers to a message, method or behavior that works the same way across multiple classes.  Regardless of what it is named, it does the same thing at multiple locations.

A Ruby Object is liek a partygoer at a masquerade ball that changes masks to suit the theme of the moment.  

Ducks are 'Behavioral Chameleons'.  A 'duck type' is also an 'across-class type'.

Consider `Trip` and `Mechanic`.  We know that `Trip` needs to be able to prepare things.  Even though `mechanic` could point to anything (inside trip), `Trip` sill has to manage the methods being called on `mechanic`.

```ruby
class Trip
  attr_reader :bicycles, :customers, :vehicle

  # this 'mechanic' argument could be of any class
  def prepare(mechanic)
    mechanic.prepare_bicycles(bicycles)
  end

  # ...
end

class Mechanic
  def prepare_bicycles(bicycles)
    bicycles.each {|bicycle| prepare_bicycle(bicycle)}
  end

  def prepare_bicycle(bicycle)
    #...
  end
end
```

![http://cl.ly/image/270B0i0t0p2u/Image%202014-11-08%20at%2012.07.04%20PM.png](http://cl.ly/image/270B0i0t0p2u/Image%202014-11-08%20at%2012.07.04%20PM.png)

Any Object that attempts to call `.prepare` on `Trip` doesn't necessarily have a dependency on `Mechanic` but there is still coupling.   If the requirements change even slightly, this coupling could be exposed in a less friendly manner.  Consider adding new Classes that each have a step that requires some kind of preparation before a trip can commence.

```ruby
class Trip
  attr_reader :bicycles, :customers, :vehicle

  def prepare(preparers)
    preparers.each {|preparer|
      case preparer
      when Mechanic
        preparer.prepare_bicycles(bicycles)
      when TripCoordinator
        preparer.buy_food(customers)
      when Driver
        preparer.gas_up(vehicle)
        preparer.fill_water_tank(vehicle)
      end
    }
  end
end

# when you introduce TripCoordinator and Driver
class TripCoordinator
  def buy_food(customers)
    # ...
  end
end

class Driver
  def gas_up(vehicle)
    #...
  end

  def fill_water_tank(vehicle)
    #...
  end
end
```

The above code is particularly problematic because calling `.prepare` on `Trip` has coupling to multiple different Classes and those classes' methods.  Consider the new sequence diagram that the above example generates.

![http://cl.ly/image/341n2Q303E3k/Image%202014-11-08%20at%2012.11.32%20PM.png](http://cl.ly/image/341n2Q303E3k/Image%202014-11-08%20at%2012.11.32%20PM.png)

The sequence diagram indicates a significant amount of context on behalf of `Trip` and may actually feel more complicated than the underlying code, this is a major red flag.  Consider that `Trip's` `.prepare` method has a single purpose, to make sure `Trip` is ready to rumble.  

We might actually consider introducing a new Class to handle preparation for `Trip`, i.e., `Preparer`.

![http://cl.ly/image/1n2E1y3t1B19/Image%202014-11-08%20at%2012.15.12%20PM.png](http://cl.ly/image/1n2E1y3t1B19/Image%202014-11-08%20at%2012.15.12%20PM.png)

Once we create `Preparer`, we have reduced the context of `Trip`.  To tee things up, realize that `Preparer` is about to become an abstract class, it doesn't actually exist, it just expresses some concrete, shared behavior.

![http://cl.ly/image/3Q3u0D0T1c09/Image%202014-11-08%20at%2012.16.33%20PM.png](http://cl.ly/image/3Q3u0D0T1c09/Image%202014-11-08%20at%2012.16.33%20PM.png)

##### The Preparer Duck Type

```ruby
class Trip
  attr_reader :bicycles, :customers, :vehicle

  def prepare(preparers)
    preparers.each {|preparer|
      preparer.prepare_trip(self)}
  end
end

# when every preparer is a Duck
# that responds to 'prepare_trip'
class Mechanic
  def prepare_trip(trip)
    trip.bicycles.each {|bicycle|
      prepare_bicycle(bicycle)}
  end

  # ...
end

class TripCoordinator
  def prepare_trip(trip)
    buy_food(trip.customers)
  end

  # ...
end

class Driver
  def prepare_trip(trip)
    vehicle = trip.vehicle
    gas_up(vehicle)
    fill_water_tank(vehicle)
  end
  # ...
end
```

Now, we can call `.prepare` on an instance of `Trip`, pass `self` to the `Class` that corresponds to the type of Object being passed, and we effectively push management of what it means to be *prepared* to each of the different classes.  This allows us to introduce new classes that may need to be *prepared*.  As long as any new class responds to `.prepare_trip`, we can use it inconjunction with `Trip` and we don't have an excessive amount of coupling between `Trip` and any other class.

Accompanying this conversation, there is the 'cost of concretion' and the 'cost of abstraction', both of which can influence design patterns.


#### Polymorphism

In OOP, polymorphism refers to the ability of many different objects to respond to the same message.  In the above duck typing example, `.prepare_trip` would be render `Driver`, `TripCoordinator`, etc.., as polymorphic because they all respond to `.prepare_trip`.  Duck typing is one way to achieve polymorphism, Inheritance and behavior sharing (via Ruby Modules) are also available.

#### Recognizing Hidden Ducks

Common patterns that indicate a duck might exist:

- Case statements that switch based on Class.

  ```ruby
  class Trip
  attr_reader :bicycles, :customers, :vehicle

  def prepare(preparers)
    preparers.each {|preparer|
      case preparer
      when Mechanic
        preparer.prepare_bicycles(bicycles)
      when TripCoordinator
        preparer.buy_food(customers)
      when Driver
        preparer.gas_up(vehicle)
        preparer.fill_water_tank(vehicle)
      end
    }
    end
  end
  ```
  
  Consider the question, "What is it that prepare wants from each of its arguments?"
  
  
- usage of `.kind_of?` `.is_a?` `.responds_to?`

  ```ruby
  if preparer.kind_of?(Mechanic)
    preparer.prepare_bicycles(bicycle)
  elsif preparer.kind_of?(TripCoordinator)
    preparer.buy_food(customers)
  elsif preparer.kind_of?(Driver)
    preparer.gas_up(vehicle)
    preparer.fill_water_tank(vehicle)
  end

  if preparer.responds_to?(:prepare_bicycles)
    preparer.prepare_bicycles(bicycle)
  elsif preparer.responds_to?(:buy_food)
    preparer.buy_food(customers)
  elsif preparer.responds_to?(:gas_up)
    preparer.gas_up(vehicle)
    preparer.fill_water_tank(vehicle)
  end
  ```



