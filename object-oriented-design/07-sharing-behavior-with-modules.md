## Sharing Role Behavior with Modules

Some problems require sharing behavior among otherwise unrelated objects.  The common behavior is not really part of the Class of an object but really a role that an object plays.  The roles aren't as clear as super/sub class relationships but are present none the less.

#### Finding Roles


Consider the [Preparer Duck Type][Preparer Duck Type], the existence of the `Preparer` role indicates there is a parallel `Preparable` role.

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

#### Ruby Modules

Ruby allows for code mix-ins called *modules*, which provide a way to allow objects of different classes to play a common role using a single set of code.

The total set of messages to which an Object can respond includes:

- Those it implements.
- Those implemented in all Objects above it in the hierarchy.
- Those implemented in any module that has been added to it.
- Those implemented in all modules added to any Object above in the hierarchy.

#### Using a Module to Schedule a `Trip`

Consider the Bicycle Touring Corp (BTC) needs to schedule a `Trip`, which occur at specific points in time and involve bicycles, mechanics and motor-vehicles.  BTC needs a way to arrange these different objects so as to create viewable schedule.

Requirements dictate Bicycles has a minimum on one day between trips, vehicles a minimum of three days and mechanics four days.

Starting this, we can assume `Schedule` exists and already implements `.scheduled?(target, starting, ending)`, `.add(targer, starting, ending)` and `.remove(target, starting, ending)`.

`Schedule` is ok as is, it can tell us if an incoming target has been scheduled.  It cannot tell us if an incoming target *CAN BE* scheduled, which involves examining the lead time requirements.

Consider a decently naive design accomplishing the above.  `Schedule` ends up checking the Class to know what the lead days are are end up having to know too much about the details of each target object being evaluated.

![http://cl.ly/image/3F411l1j1H2G/Image%202014-11-08%20at%204.38.21%20PM.png](http://cl.ly/image/3F411l1j1H2G/Image%202014-11-08%20at%204.38.21%20PM.png) 

#### Discovering the Schedulable Duck Type

At a certain point, the design needs to shift to something more like:

![http://cl.ly/image/0n0R1L3X3h1S/Image%202014-11-08%20at%204.44.20%20PM.png](http://cl.ly/image/0n0R1L3X3h1S/Image%202014-11-08%20at%204.44.20%20PM.png)

The Instigating object knows its own lead days and `Schedule` sends the message to `target`, `.lead_days`.  `Schedule` expects its target to behave like something that understands `.lead_days`, ie, something that is 'schedulable'.

##### Naive Implementation of `Schedule`

Consider a first pass implementation:

```ruby
class Schedule
  def scheduled?(schedulable, start_date, end_date)
    puts "This #{schedulable.class} " +
         "is not scheduled\n" +
         "  between #{start_date} and #{end_date}"
    false
  end
end

# which could be used in the below definition of Bicycle
# Bicycle then delegates .scheduled? to the schedule object

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
# This Bicycle is not scheduled
#   between 2015-09-03 and 2015-09-10
#  => true
```
The above example is ok as the `Schedule` object isolates logic but there are ways to make this more extensible.  Consider pulling out any logic that is unique to the behaviors that `Schedule` is repsonsible for. 

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

# which can be used anywhere in an application

class Bicycle
  include Schedulable

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

v = Vehicle.new
v.schedulable?(starting, ending)
# This Vehicle is not scheduled
#   between 2015-09-01 and 2015-09-10
#  => true

m = Mechanic.new
m.schedulable?(starting, ending)
# This Mechanic is not scheduled
#   between 2015-08-31 and 2015-09-10
#  => true
```

Once the Module pattern gets used, the design begins to look more like:

![http://cl.ly/image/3d0s210W2I1n/Image%202014-11-09%20at%201.11.56%20PM.png](http://cl.ly/image/3d0s210W2I1n/Image%202014-11-09%20at%201.11.56%20PM.png)

#### Writing Inheritable Code

Inheritable code has to be written in an intentionend aware fashion.

#### 2 Important Inheritance Antipatterns

1. An object that uses a variable with a name like type or category to determine what message to send to self contains two highly related but slightly different types.

  Every time a new type is introduced, the code must change, this is brittle and a cascading mess.  User class inheritance with a super/sub class setup.  Put any common code in the abstract superclass.

1. When a sending object checks the class of a receiving object to determine what message to send, an overlooked duck type likely exists.

  The code has to change every time a new class of receiver is created or used.
  
> I'm a little unclear on this section of the book.  I probably need hands on coding examples.

#### Insist on the Abstraction

All of the code in an abstract superclass should apply to every class that inherits it. Superclasses should not contain code that applies to some, but not all, subclasses. This restriction also applies to modules: the code in a module must apply to all who use it.

#### Honor the Contract

Subclasses agree to a contract; they promise to be substitutable for their superclasses.  The subclass must in all ways perform as the superclass.  

Liskov Substitution Principle (LSP)

- Let q(x) be a property provable about objects
- x of type T. Then q(y) should be true for objects y of type S where S is a subtype of T.

#### Use the Template Method Pattern

The abstract code defines the algorithms and the concrete inheritors of that abstraction contribute specializations by overriding these template methods.  The template methods represent the parts of the algorithm that vary and creating them forces you to make explicit decisions about what varies and what does not.

#### Preemptively Decouple Classes

Avoid writing code that requires its inheritors to send super; instead use hook messages to allow subclasses to participate while absolving them of responsibility for knowing the abstract algorithm.

#### Create Shallow Hierarchies

![http://cl.ly/image/0T2b1p41091j/Image%202014-11-09%20at%201.27.33%20PM.png](http://cl.ly/image/0T2b1p41091j/Image%202014-11-09%20at%201.27.33%20PM.png)

[Preparer Duck Type]:05-duck-typing.md#the-preparer-duck-type
