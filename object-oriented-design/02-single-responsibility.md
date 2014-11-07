##  Single Responsibility

* When everything in a class is related to its central purpose, is can be said to be highly cohesive.
* If the description of a class requires 'and', 'or', it probably has complicated dependencies.  
* Think about RDD, responsibility-driven-design, "a class has responsibilities that fulfill its purpose"
  
#### Single Responsibility Evaluation

Consider the before and after `Gear`

```ruby
#before
class Gear
  attr_reader :chainring, :cog
  def initialize(chainring, cog)
    @chainring = chainring
    @cog       = cog
  end

  def ratio
    chainring / cog.to_f
  end
end

puts Gear.new(52, 11).ratio        # -> 4.72727272727273
puts Gear.new(30, 27).ratio        # -> 1.11111111111111

# after
# gear_inches is a more detailed calculation of mechancal advantage
# http://en.wikipedia.org/wiki/Gear_inches

class Gear
  attr_reader :chainring, :cog, :rim, :tire
  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog       = cog
    @rim       = rim
    @tire      = tire
  end

  def ratio
    chainring / cog.to_f
  end

  def gear_inches
      # tire goes around rim twice for diameter
    ratio * (rim + (tire * 2))
  end
end

puts Gear.new(52, 11, 26, 1.5).gear_inches
# -> 137.090909090909

puts Gear.new(52, 11, 24, 1.25).gear_inches
# -> 125.272727272727
```

The #after definition of `Gear` introduces new arguments and now any previous references of `Gear.new` will break.

```ruby
puts Gear.new(52, 11).ratio # didn't this used to work?
# ArgumentError: wrong number of arguments (2 for 4)
#	 from (irb):20:in `initialize'
#	 from (irb):20:in `new'
#	 from (irb):20
```

"Applications that are easy to change consist of classes that are easy to reuse. Reusable classes are pluggable units of well-defined behavior that have few entanglements."

If `Gear` was being used in an application that wouldn't change, we wouldn't need to worry about this.  Classes with multiple responsibilities are hard to reuse.  In this case, does `Gear` have a single responsibility?

#### Evaluating Single Responsibility via Casual Interrogation

*"Mr/Mrs Gear, what is your ratio?"* - seems ok, information that `Gear` knows about itself.

*"Mr/Mrs Gear, what are your gear_inches?"* - less clear, answer requires knowledge of `Rim` and `Tire`.

*"Mr/Mrs Gear, what is your tire size?"* - unacceptable, how can `Gear` be aware of `Tire`.

A Class should be able to describe its purpose in one clear sentence. If a Class needs to use the word 'and' to describe itself, it probably does more than one thing.  If it needs 'or' it probably does multiple unrelated things.  The idea of 'cohesion' is that everything a Class does should support its purpose or singular responsibility.  It doesn't mean the class can do only one thing, but that the things it does suppor a similar purpose.  A Class that does this is said to be highly cohesive.

Consider `Gear`...

If the purpose is to calculate the ration between sprockets, it is in troubled waters.  If the purpose is to calculate the effect the `Gear` has on the bike, then `gear_inches()` starts to look more supportive.  `Tire` is still a dependency issue.

It can be difficult to know exactly how an application will behave while it is being built, therefore, there is some friction between implementing features in this moment and understanding the Object hierarchy so as to know how to design.

When faced with a design tradeoff between 'improve now' vs 'improve later', consider *"What is the future cost of doing nothing today?"*.  If the future cost is the same as the current cost, don't make a premature decision.



#### Write Code That Embraces Change, Depend on Behavior, not Data.
  
#### Hide instance variables
  
Always wrap instance variables in accessor methods instead of referring to them directly.

Consider:

```ruby
class Gear
  def initialize(chainring, cog)
    @chainring = chainring
    @cog       = cog
  end

  def ratio
    @chainring / @cog.to_f      # <-- road to ruin
  end
end
```
  
Above, `@cog` relies on the actual data that the instance variable points to and is the only place in the code that understands what `@cog` is (not sure I totally grok that).  Use an accessor method, make cog a message that grabs information and can be isolated in case it needs to be tinkered with.
  
```ruby
class Gear
  attr_reader :chainring, :cog  # <-------
  def initialize(chainring, cog)
    @chainring = chainring
    @cog       = cog
  end

  def ratio
    chainring / cog.to_f        # <-------
  end
  
  # if necessary
  # def cog
  #   # apply unique logic in only one isolated place
  # end
end
```

#### Hide Data Structures

Consider:

```ruby
class ObscuringReferences
  attr_reader :data
  def initialize(data)
    @data = data
  end

  def diameters
    # 0 is rim, 1 is tire
    data.collect {|cell|
      cell[0] + (cell[1] * 2)}
  end
  # ... many other methods that index into the array
end
```

Above `@data` is a 2d array with rim and tire information.  `data` wraps `@data`, when `diameters` calls `data`, the method must know the index position of `rims` and `tire`.  In this case, `diameters` relies on the structure of `data` and must be made aware of any changes to said structure, this is a major issue because any change to the `@data` at initialization has impact on the Class.  Ruby is specifically built to be good at seperating structure from meaning.

Consider:

```ruby
@data = [[622, 20], [622, 23], [559, 30], [559, 40]]

class RevealingReferences
  attr_reader :wheels
  def initialize(data)
    @wheels = wheelify(data)
  end

  def diameters
    wheels.collect {|wheel|
      wheel.rim + (wheel.tire * 2)}
  end
  # ... now everyone can send rim/tire to wheel

  Wheel = Struct.new(:rim, :tire)
  def wheelify(data)
    data.collect {|cell|
      Wheel.new(cell[0], cell[1])}
  end
end
```

![http://cl.ly/image/0O1Y2p2u3V40/Image%202014-11-06%20at%2011.30.05%20AM.png](http://cl.ly/image/0O1Y2p2u3V40/Image%202014-11-06%20at%2011.30.05%20AM.png)

Now, `ref = RevealingReferences.new(@data)` and `ref.wheels` will return an object that can be iterated on and responds to the messages `.rim()` and `.tire()` and the process of extracting the meaning from the data has ben abstracted and is not coupled to the calculation of `.diameters()`.


#### Enforce single responsibility everywhere.

A method should do one thing.  Having, just one responsibility makes them easy to change and easy to reuse.  Casually interrogate them, if the answers arent's one liners and simple, the methods probably aren't responsible for just one thing. 

Consider that `.diameters()` actually iterates and calculates

```ruby
# bad 
def diameters
  wheels.collect {|wheel| wheel.rim + (wheel.tire * 2)}
end

# better
# calculate diameter of ONE wheel

def diameters
  wheels.collect {|wheel| diameter(wheel)}
end


def diameter(wheel)
  wheel.rim + (wheel.tire * 2)
end
```

Methods that single responsibility will:

- Expose previously hidden qualities.
- Avoid the need for comments.
- Encourage reuse.
- Be easy to move to another class.


#### Isolate Extra Responsibilities in Classes.

It is possible that `Gear` really needs `Wheel`.  Until the decision is made to build a standalone `Wheel` class, consider just abstracting out the `Wheel` logic but keeping its definition inside `Gear`.

```ruby
class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog       = cog
    @wheel     = Wheel.new(rim, tire)
  end

  def ratio
    chainring / cog.to_f
  end

  def gear_inches
    ratio * wheel.diameter
  end

  Wheel = Struct.new(:rim, :tire) do
    def diameter
      rim + (tire * 2)
    end
  end
end
```

#### Someone Introduces 'Change'

Someone says "hey, I need to know the circumference of the Wheel to calculate speed." At which point, creating `Wheel` makes sense.

```ruby
class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(chainring, cog, wheel=nil)
    @chainring = chainring
    @cog       = cog
    @wheel     = wheel
  end

  def ratio
    chainring / cog.to_f
  end

  def gear_inches 
    ratio * wheel.diameter
  end
end

class Wheel
  attr_reader :rim, :tire

  def initialize(rim, tire)
    @rim       = rim
    @tire      = tire
  end

  def diameter
    rim + (tire * 2)
  end

  def circumference
    diameter * Math::PI
  end
end

@wheel = Wheel.new(26, 1.5)
puts @wheel.circumference
# -> 91.106186954104

puts Gear.new(52, 11, @wheel).gear_inches
# -> 137.090909090909

puts Gear.new(52, 11).ratio
# -> 4.72727272727273
```