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
