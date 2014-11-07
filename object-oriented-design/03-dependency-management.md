## MANAGING DEPENDENCIES

#### The Catch-22s of Objects

* If an Object has a single responsibility, it must collaborate to do anything.
* Collaboration requires some kind of awareness or knowingness about others.
* Knowingness creates a dependency, improperly managed, this can **STRANGLE** an app.


#### A Dependency occurs when:

One Object changes and a different Object is forced to change in turn.

**How many dependencies in the below code?**

```ruby
class Gear
  attr_reader :chainring, :cog, :rim, :tire
  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog       = cog
    @rim       = rim
    @tire      = tire
  end

  def gear_inches
    ratio * Wheel.new(rim, tire).diameter
  end

  def ratio
    chainring / cog.to_f
  end
# ...
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
# ...
end

Gear.new(52, 11, 26, 1.5).gear_inches
```

1. *The name of another class* - `Gear` expects a class named wheel to exist.
1. *The name of a message that it intends to send to someone other than self* - `Gear` expects `Wheel` to respond to `.diameter`
1. *The arguments that a message requires* - `Gear` knows that `Wheel.new` requires `:rim` and `:tire`
1. *The order of those arguments* - `Gear` knows the first and second arguments.

#### CBO, Coupling Between Object

When multiple objects are so tightly coupled that they behave as a unit, it becomes impossible to use just one.

You know you are in trouble if, you make a change to `Wheel` and you find it necessary to change `Gear`, if you want to reuse `Gear` and `Wheel` ends up coming along, and when you test `Gear`, you in somehow test `Wheel`.

## DEFENSES AGAINST COUPLING

#### Inject Dependencies

There is a problem that if `Wheel` stops responding to or changes, `.gear_inches()` will break. `.gear_inches()` will only collaborate with `Wheel`, when in fact, it shouldn't care where it gets diameter from. Having to instantiate `Gear` with `rim` and `tire`, to be passed to `Wheel` is also no good.

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

Dependency inject anything that responds to `.diameter`.

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

#### Isolate Instance Creation


If Dependency Injection isn't an option, isolate instance variables in separate methods so that `Gear` doesn't require `Wheel` to instantiate.

```ruby
#bad
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

Use `||=` inside a method to 'lazily' instantiate  `Wheel` only when `Gear` calls `.wheel()`.

```ruby
#better
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

#### Isolate vulnerable external messages.

Consider that in the above, `.gear_inches` is simple, but if it was complex, it would be bad to have `.diameter` occurring as an external message. Isolate it in a `Gear` wrapper method.


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

#### Remove argument order dependencies 

Use an args or opts hash.

Consider:

```ruby
class Gear
  attr_reader :chainring, :cog, :wheel
  
  def initialize(chainring, cog, wheel)
    @chainring = chainring
    @cog       = cog
    @wheel     = wheel
  end
  ...
end

Gear.new(52, 11, Wheel.new(26, 1.5)).gear_inches
```

Lots of projects change argument details, having to manually manage the order is a problem.

```ruby
class Gear
  attr_reader :xxx, :yyy, :zzz

  def initialize args
    @chainring = args[:chainring]
    @cog = args[:cog]
    @wheel = args[:wheel]
  end
end
Gear.new(:chainring => 52, :cog => 11, :wheel => Wheel.new(26, 1.5)).gear_inches
```

#### Explicitly Define Default Values

```ruby
  def initialize(args)
    @chainring = args[:chainring] || 40
    @cog       = args[:cog]       || 18
    @wheel     = args[:wheel]
  end
  
  # specifying defaults using fetch
  def initialize(args)
    @chainring = args.fetch(:chainring, 40)
    @cog       = args.fetch(:cog, 18)
    @wheel     = args[:wheel]
  end


  # specifying defaults by merging a defaults hash
  def initialize(args)
    args = defaults.merge(args)
    @chainring = args[:chainring]
  end

  def defaults
    {:chainring => 40, :cog => 18}
  end
```


#### Isolate Multiparameter Initialization

  In the case of an external framework where methods or argument order can't be changed, wrap the `args` for dependency defense

  ```ruby
  module SomeFramework
    class Gear
      attr_reader :chainring, :cog, :wheel
      def initialize(chainring, cog, wheel)
        @chainring = chainring
        @cog       = cog
        @wheel     = wheel
      end
    # ...
    end
  end

  # wrap the interface to protect yourself from changes
  module GearWrapper
    def self.gear(args)
      SomeFramework::Gear.new(args[:chainring],
                              args[:cog],
                              args[:wheel])
    end
  end

  # Now you can create a new Gear using an arguments hash.
  GearWrapper.gear(
    :chainring => 52,
    :cog       => 11,
    :wheel     => Wheel.new(26, 1.5)).gear_inches
  ```
  
  A complete example of the above.
  
```ruby
module SomeFramework
  class Gear
    attr_reader :chainring, :cog, :wheel
    def initialize(chainring, cog, wheel)
      @chainring = chainring
      @cog       = cog
      @wheel     = wheel
    end

    def gear_inches
      ratio * wheel.diameter
    end

    def ratio
      chainring / cog.to_f
    end
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
end

module GearWrapper
  def self.gear(args)
    SomeFramework::Gear.new(args[:chainring],
                            args[:cog],
                            args[:wheel])
  end
end

GearWrapper.gear(
  :chainring => 52,
  :cog       => 11,
  :wheel     => Wheel.new(26, 1.5)).gear_inches
```

#### Dependency Direction Reversal

In most of the examples this far `Gear` has depended on `Wheel`.  What if instead, `Wheel` depended on `Gear`?  Direction of Dependence might seem unimportant, but consider the stability of and Object.  It is generally safer to depend on Objects that change less or never.
  
There are three simple truths about code.

1. Some classes are more likely than others to have changes in requirements.
1. Concrete classes are more likely to change than abstract classes.
1. Changing a class that has many dependents will result in widespread consequences.

![http://cl.ly/image/2o0h0s46071x/Image%202014-11-06%20at%201.24.56%20PM.png](http://cl.ly/image/2o0h0s46071x/Image%202014-11-06%20at%201.24.56%20PM.png)

The programmer needs to develop an awareness of what is likely to change and the direction of dependencies in an application.
  
```ruby
class Gear
  attr_reader :chainring, :cog
  def initialize(chainring, cog)
    @chainring = chainring
    @cog       = cog
  end

  def gear_inches(diameter)
    ratio * diameter
  end

  def ratio
    chainring / cog.to_f
  end
#  ...
end

class Wheel
  attr_reader :rim, :tire, :gear
  def initialize(rim, tire, chainring, cog)
    @rim       = rim
    @tire      = tire
    @gear      = Gear.new(chainring, cog)
  end

  def diameter
    rim + (tire * 2)
  end

  def gear_inches
    gear.gear_inches(diameter)
  end
#  ...
end

Wheel.new(26, 1.5, 52, 11).gear_inches
```