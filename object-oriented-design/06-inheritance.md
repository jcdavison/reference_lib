## Acquiring Behavior Through Inheritance


Inheritance is a mechanism for automatic message delegation.

#### Recognizing When to Use Inheritance

Consider the Mechanics from the Bicycle Tour Company (BTC).  Mechanics are responsible for keeping bikes running and bikes take an assortment of spare parts on each trip and the spares depend on whatever bike is in question.

#### Concrete Classes

Consider the already known to be useful Class `Bike`.  Bikes have size, handlebar tape color, tire and chain type, `Mechanics` need to account for all spares.

```ruby
class Bicycle
  attr_reader :size, :tape_color

  def initialize(args)
    @size       = args[:size]
    @tape_color = args[:tape_color]
  end

  # every bike has the same defaults for
  # tire and chain size
  def spares
    { chain:        '10-speed',
      tire_size:    '23',
      tape_color:   tape_color}
  end

  # Many other methods...
end

bike = Bicycle.new(
        size:       'M',
        tape_color: 'red' )

bike.size     # -> 'M'
bike.spares
# -> {:tire_size   => "23",
#     :chain       => "10-speed",
#     :tape_color  => "red"}
```

As built, `Bicycle` reflects a road bike.  BTC requires mountain bikes to also be managed.  Uniquley, speaking, a road bike requires handlebar tap and a mountain bike requires suspension.  There may be a temptation to add methods to `Bicycle` that allow for differentiating between each type of bike. Don't do it.


#### Naive Implementation of `Bicycle` to manage both road and mountain.

```ruby
class Bicycle
  attr_reader :style, :size, :tape_color,
              :front_shock, :rear_shock

  def initialize(args)
    @style       = args[:style]
    @size        = args[:size]
    @tape_color  = args[:tape_color]
    @front_shock = args[:front_shock]
    @rear_shock  = args[:rear_shock]
  end

  # checking 'style' starts down a slippery slope
  def spares
    if style == :road
      { chain:        '10-speed',
        tire_size:    '23',       # milimeters
        tape_color:   tape_color }
    else
      { chain:        '10-speed',
        tire_size:    '2.1',      # inches
        rear_shock:   rear_shock }
    end
  end
end

bike = Bicycle.new(
        style:        :mountain,
        size:         'S',
        front_shock:  'Manitou',
        rear_shock:   'Fox')

bike.spares
# -> {:tire_size   => "2.1",
#     :chain       => "10-speed",
#     :rear_shock  => 'Fox'}
```

In above naive implementation, `.spares` is using `style` to control for attributes and this is a ref flag.

#### Finding Embedded Types

The `if` statement in the `spares` method switches on the variable `style`, which would have been just as easily called `type` or `category`.  This single class contains several different, but related, types.  Inheritance is built to solve the problem of managing highly related types that share core common behavior but differ anlong some other dimension.

NOTE - Ruby primarily deals with 'single inheritance', inheriting from multiple parents causes all kinds of uglies.

Message forwarding via Classical inheritance takes palce between Classes.  Duck types share code via Ruby modules.

#### Modeling Inheritance

Since `MountainBike` will be a descendant of `Bicyle`, we would call `Bicycle` the superclass of `MountainBike`.

![http://cl.ly/image/3i0s1U3H1p2J/Image%202014-11-08%20at%202.33.25%20PM.png](http://cl.ly/image/3i0s1U3H1p2J/Image%202014-11-08%20at%202.33.25%20PM.png)

#### Naive Implementation of `MountainBike`

```ruby
class MountainBike < Bicycle
  attr_reader :front_shock, :rear_shock

  def initialize(args)
    @front_shock = args[:front_shock]
    @rear_shock  = args[:rear_shock]
    super(args)
  end

  def spares
    super.merge(rear_shock: rear_shock)
  end
end
```

`MountainBike` overrides both `.initialize` and `.spares`.  This implementation has too much of the road bike behavior that was built into `Bicycle`.  `MountainBike` needs to be a specialization of `Bicycle`, it should be everything that `Bicycle` is and more.

#### 2 Rules of Modeling

1. Objects being modeled must truly have a generalization-specialization relationship.
1. You must use the correct coding technique.

The above example, the relationship is correct but the code present in each Class is a mess.  Think about creating an asbtract Superclass.

#### Abstract SuperClass

![http://cl.ly/image/442w2H382W2W/Image%202014-11-08%20at%202.40.12%20PM.png](http://cl.ly/image/442w2H382W2W/Image%202014-11-08%20at%202.40.12%20PM.png)

`Bicycle` becomes the abstract Superclass from which `RoadBike` and `MountainBike` inherit their core behaviors.  The sole purpose of an abstract class is to be subclassed.  It is almost always impractical to create an abstract superclass that has only one child.

To abstract out the Superclass from `Bicycle`, create an empty set of classes.

```ruby
class Bicycle
  # This class is now empty.
  # All code has been moved to RoadBike.
end

class RoadBike < Bicycle
  # Now a subclass of Bicycle.
  # Contains all code from the old Bicycle class.
end

class MountainBike < Bicycle
  # Still a subclass of Bicycle (which is now empty).
  # Code has not changed.
end
```

Push all behavior to the subclass and then promote common behaviors to the abstract super class.

```ruby
class Bicycle
  attr_reader :size     # <- promoted from RoadBike

  def initialize(args={})
    @size = args[:size] # <- promoted from RoadBike
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color

  def initialize(args)
    @tape_color = args[:tape_color]
    super(args)  # <- RoadBike now MUST send 'super'
  end
  # ...
end

class MountainBike < Bicycle
  attr_reader :front_shock, :rear_shock

  def initialize(args)
    @front_shock = args[:front_shock]
    @rear_shock =  args[:rear_shock]
    super(args)
  end

  def spares
    super.merge({rear_shock:  rear_shock})
  end
end

# now both subclasses will respond to .size()

road_bike = RoadBike.new(
              size:       'M',
              tape_color: 'red' )

road_bike.size  # -> "M"

mountain_bike = MountainBike.new(
                  size:         'S',
                  front_shock:  'Manitou',
                  rear_shock:   'Fox')

mountain_bike.size # -> 'S'
```

#### Template Method Pattern

Altering `initialize` in a superclass by which it calls subclass specific messages to set defaults.  If a subclass implements said messages, it can then override the superclass and provide a greater level of specialization.

```ruby
class Bicycle
  attr_reader :size, :chain, :tire_size

  def initialize(args={})
    @size       = args[:size]
    @chain      = args[:chain]     || default_chain
    @tire_size  = args[:tire_size] || default_tire_size
  end

  def default_chain       # <- common default
    '10-speed'
  end
  
  def default_tire_size
    raise NotImplementedError
  end
end

class RoadBike < Bicycle
  # ...
  def default_tire_size   # <- subclass default
    '23'
  end
end

class MountainBike < Bicycle
  # ...
  def default_tire_size   # <- subclass default
    '2.1'
  end
end

class RecumbentBike < Bicycle
  def default_chain
    '9-speed'
  end
end
```

Above, `Bicycle` calls `.default_tire_size` and in the case that an application is using an instantiation of a child Object, the child's implementation of `default_tire_size` will get called first.  `RecumbentBike` will raise the `NotImplementedError` until implements `default_tire_size`.

It is important to document template method patterns by using `NotImplementedError` wrapper methods in the abstract Superclass.


#### Somewhat Naive Implementation of SubClass Specialization

Consider that we now want to implement the original spares method.  A useful pattern is to define `.spares` in the superclass and merge unique values from the subclass into it.


```ruby
class Bicycle
  attr_reader :size, :chain, :tire_size

  def initialize(args={})
    @size       = args[:size]
    @chain      = args[:chain]      || default_chain
    @tire_size  = args[:tire_size]  || default_tire_size
  end

  def spares
    { tire_size:  tire_size,
      chain:      chain}
  end

  def default_chain
    '10-speed'
  end

  def default_tire_size
    raise NotImplememtedError
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color

  def initialize(args)
    @tape_color = args[:tape_color]
    # notice that super(args) allows for the super class to finish off initialization.
    super(args)
  end

  def spares
    # notice that super.merge adds specialization information to Bike
    super.merge({ tape_color: tape_color})
  end

  def default_tire_size
    '23'
  end
end

class MountainBike < Bicycle
  attr_reader :front_shock, :rear_shock

  def initialize(args)
    @front_shock = args[:front_shock]
    @rear_shock =  args[:rear_shock]
    # notice that super(args) allows for the super class to finish off initialization.
    super(args)
  end

  def spares
    # notice that super.merge adds specialization information to Bike
    super.merge({rear_shock: rear_shock})
  end

  def default_tire_size
    '2.1'
  end
end
```

The above is `somewhat` naive because there are dependencies built into how the subclasses must be initialized, which means the subclass must know how to interact with the superclass.  The subclass above must know where/when to send `super` and forces future coders on the codebase to also manage this dependency.

#### Decoupling Using Hook Messages

Use a hook to provide a subclass the opportunity to contribute to the specialization of the superclass without putting the subclass in control of the intialization process.

```ruby
class Bicycle
  attr_reader :size, :chain, :tire_size

  def initialize(args={})
    @size       = args[:size]
    @chain      = args[:chain]     || default_chain
    @tire_size  = args[:tire_size] || default_tire_size
    post_initialize(args)
  end

  def post_initialize(args)
    nil
  end

  def spares
    { tire_size:  tire_size,
      chain:      chain}
  end

  def default_chain
    '10-speed'
  end

  def default_tire_size
    raise NotImplementedError
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color

  def post_initialize(args)
    @tape_color = args[:tape_color]
  end

  def spares
    super.merge({tape_color: tape_color})
  end

  def default_tire_size
    '23'
  end
end

road_bike = RoadBike.new(
              size:       'M',
              tire_size:  25,
              tape_color: 'red' )

road_bike.spares
```



