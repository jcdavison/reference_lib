## Combining Objects With Composition

Consider `Bicycle` an abstract super class in a typical inheritance hierarchy.  `spares` relates to entities that could be described as parts.  Composition is the process of building larger functional Objects by combining smaller, more specialized objects.  In this case, `Bike` and `Parts` have details that lend themselves to composition.  It is common for the larger object to utilize a `has a` relationship with the more specialized object, in this case `Part`.  

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

Let's consider creating a `Parts` object and delegating `.spares` to it. 

![http://cl.ly/image/0e3n1Y3c0W30/Image%202014-11-10%20at%208.59.04%20AM.png](http://cl.ly/image/0e3n1Y3c0W30/Image%202014-11-10%20at%208.59.04%20AM.png)

Notice that since `Bicycle` 'has a' `Part`, the design can be expressed via:

![http://cl.ly/image/3x3U1a3I1H1i/Image%202014-11-10%20at%208.59.35%20AM.png](http://cl.ly/image/3x3U1a3I1H1i/Image%202014-11-10%20at%208.59.35%20AM.png)

`Bike` would then become simpler and be responsible for knowing its `.size`, knowing that is has a `parts` object and knowing that it responds to `.spares`.  Parts encapsulates all the behaviors required to interact with spares.

```ruby
class Bicycle
  attr_reader :size, :parts

  def initialize(args={})
    @size       = args[:size]
    @parts      = args[:parts]
  end

  def spares
    parts.spares
  end
end

class Parts
  attr_reader :chain, :tire_size

  def initialize(args={})
    @chain      = args[:chain]     || default_chain
    @tire_size  = args[:tire_size] || default_tire_size
    post_initialize(args)
  end

  def spares
    { tire_size: tire_size,
      chain:     chain}.merge(local_spares)
  end

  def default_tire_size
    raise NotImplementedError
  end

  # subclasses may override
  def post_initialize(args)
    nil
  end

  def local_spares
    {}
  end

  def default_chain
    '10-speed'
  end
end

class RoadBikeParts < Parts
  attr_reader :tape_color

  def post_initialize(args)
    @tape_color = args[:tape_color]
  end

  def local_spares
    {tape_color: tape_color}
  end

  def default_tire_size
    '23'
  end
end

class MountainBikeParts < Parts
  attr_reader :front_shock, :rear_shock

  def post_initialize(args)
    @front_shock = args[:front_shock]
    @rear_shock =  args[:rear_shock]
  end

  def local_spares
    {rear_shock:  rear_shock}
  end

  def default_tire_size
    '2.1'
  end
end
```

The design to reflect the relationship between the abstract class `Part` and the concrete classes `MountainBikeParts`and `RoadBikeParts` looks like:

![http://cl.ly/image/012i0O273K1e/Image%202014-11-10%20at%209.08.36%20AM.png](http://cl.ly/image/012i0O273K1e/Image%202014-11-10%20at%209.08.36%20AM.png)

No matter is a `Bike` gets instantiated with a `MountainBikeParts` or `RoadBikeParts`, it can call the message `.spares`, which is implented at the abstract class level.


```ruby
road_bike =
  Bicycle.new(
    size:  'L',
    parts: RoadBikeParts.new(tape_color: 'red'))

road_bike.size    # -> 'L'

road_bike.spares
# -> {:tire_size=>"23",
#     :chain=>"10-speed",
#     :tape_color=>"red"}

mountain_bike =
  Bicycle.new(
    size:  'L',
    parts: MountainBikeParts.new(rear_shock: 'Fox'))

mountain_bike.size   # -> 'L'

mountain_bike.spares
# -> {:tire_size=>"2.1",
#     :chain=>"10-speed",
#     :rear_shock=>"Fox"}
```

The above design actually indicates that `Parts` is really a collection of `Part` objects and the emergence of the `Part` class begins.

![http://cl.ly/image/1b280S0Q1Z1Q/Image%202014-11-10%20at%209.13.08%20AM.png](http://cl.ly/image/1b280S0Q1Z1Q/Image%202014-11-10%20at%209.13.08%20AM.png)

The above of which should be highlighted that there is a composition like relationship between `Bike`, `Parts` and `Part`.

![http://cl.ly/image/3a452S0t2p39/Image%202014-11-10%20at%209.14.24%20AM.png](http://cl.ly/image/3a452S0t2p39/Image%202014-11-10%20at%209.14.24%20AM.png)

```ruby
class Bicycle
  attr_reader :size, :parts

  def initialize(args={})
    @size       = args[:size]
    @parts      = args[:parts]
  end

  def spares
    parts.spares
  end
end

class Parts
  attr_reader :parts

  def initialize(parts)
    @parts = parts
  end

  def spares
    parts.select {|part| part.needs_spare}
  end
end

class Part
  attr_reader :name, :description, :needs_spare

  def initialize(args)
    @name         = args[:name]
    @description  = args[:description]
    @needs_spare  = args.fetch(:needs_spare, true)
  end
end
```

The above definitions can be used as follows:

```ruby
chain =
  Part.new(name: 'chain', description: '10-speed')

road_tire =
  Part.new(name: 'tire_size',  description: '23')

tape =
  Part.new(name: 'tape_color', description: 'red')

mountain_tire =
  Part.new(name: 'tire_size',  description: '2.1')

rear_shock =
  Part.new(name: 'rear_shock', description: 'Fox')

front_shock =
  Part.new(
    name: 'front_shock',
    description: 'Manitou',
    needs_spare: false)
    
road_bike_parts =
  Parts.new([chain, road_tire, tape])

road_bike =
  Bicycle.new(
    size:  'L',
    parts: Parts.new([chain,
                      road_tire,
                      tape]))

road_bike.size    # -> 'L'

road_bike.spares

mountain_bike =
  Bicycle.new(
    size:  'L',
    parts: Parts.new([chain,
                      mountain_tire,
                      front_shock,
                      rear_shock]))

mountain_bike.size    # -> 'L'

mountain_bike.spares
```

`Parts` is now an Array like collection that provides specialized behavior.  In order to give `Parts` more Array like methods `.size`, `.each` etc, we could make it inherit from Array.  There is a serious gotcha though, calling Array methods on a `Parts` object will return an Array, not a `Parts` and that will cause problems in production.  There is not obvious workaround, make tradeoffs in decisions and be aware of the impact of choices.

```ruby
class Parts < Array
  def spares
    select {|part| part.needs_spare}
  end
  # .... other code
end
```

#### Creating Objects with Factories

Consider that to create `Bicycle` with `Parts` and `Part`, somewhere, something needs to know about all the other things.  A factory is an object used specifically to create other objects.

```ruby
module PartsFactory
  def self.build(config,
      part_class  = Part,
      parts_class = Parts)
      parts_class.new(
        config.collect {|part_config|
         part_class.new(
           name:         part_config[0],
           description:  part_config[1],
           needs_spare:  part_config.fetch(2, true))})
   end
 end
```

This factory object is extremely terse and makes very intentioned statements about what it expects and how it handles them.

```ruby
road_config =
  [['chain',        '10-speed'],
   ['tire_size',    '23'],
   ['tape_color',   'red']]

mountain_config =
  [['chain',        '10-speed'],
   ['tire_size',    '2.1'],
   ['front_shock',  'Manitou', false],
   ['rear_shock',   'Fox']]

road_parts = PartsFactory.build(road_config)


mountain_parts = PartsFactory.build(mountain_config)
```

Given the fact that `PartsFactory` knows how to instantiate `Part`, `Part` doesn't have any true native behavior and can itself be abstracted into a Ruby open structure.

```ruby
require 'ostruct'
module PartsFactory
  def self.build(config, parts_class = Parts)
    parts_class.new(
      config.collect {|part_config|
        create_part(part_config)})
  end

  def self.create_part(part_config)
    OpenStruct.new(
      name:        part_config[0],
      description: part_config[1],
      needs_spare: part_config.fetch(2, true))
  end
end

mountain_parts = PartsFactory.build(mountain_config)
```

Consider refactoring `Bicycle`

```ruby
class Bicycle
  attr_reader :size, :parts

  def initialize(args={})
    @size       = args[:size]
    @parts      = args[:parts]
  end

  def spares
    parts.spares
  end
end

require 'forwardable'
class Parts
  extend Forwardable
  def_delegators :@parts, :size, :each
  include Enumerable

  def initialize(parts)
    @parts = parts
  end

  def spares
    select {|part| part.needs_spare}
  end
end

require 'ostruct'
module PartsFactory
  def self.build(config, parts_class = Parts)
    parts_class.new(
      config.collect {|part_config|
        create_part(part_config)})
  end

  def self.create_part(part_config)
    OpenStruct.new(
      name:        part_config[0],
      description: part_config[1],
      needs_spare: part_config.fetch(2, true))
  end
end

road_config =
  [['chain',        '10-speed'],
   ['tire_size',    '23'],
   ['tape_color',   'red']]

mountain_config =
  [['chain',        '10-speed'],
   ['tire_size',    '2.1'],
   ['front_shock',  'Manitou', false],
   ['rear_shock',   'Fox']]

road_bike =
  Bicycle.new(
    size: 'L',
    parts: PartsFactory.build(road_config))

road_bike.spares

mountain_bike =
  Bicycle.new(
    size: 'L',
    parts: PartsFactory.build(mountain_config))

mountain_bike.spares
```

This more flexible format allows for much easier addition/removal of `Bikes`, consider creating a 'recumbent bike'...

```ruby
recumbent_config =
  [['chain',        '9-speed'],
   ['tire_size',    '28'],
   ['flag',         'tall and orange']]

recumbent_bike =
  Bicycle.new(
    size: 'L',
    parts: PartsFactory.build(recumbent_config))

recumbent_bike.spares
```

#### Aggregation

Consider that composition manages the relationship between smaller more specialized objects require for use in a container.  In the context of a `Meal` 'having an' `Appetizer`, once the `Meal` has concluded, the `Appetizer` object has no further existence.  In the case of a `University` consider the lifecyle of a `Department`.  A `Department` probably needs `Professors` but if a `Department` ceases to exist, `Professors` still have a purpose and will persist.  This distinction is called `Aggregration`, the composition of Objects that may have a purpose after their parent has fulfilled its obligations.