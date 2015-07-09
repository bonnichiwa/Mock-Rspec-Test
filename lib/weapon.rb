class Weapon < Item

  attr_reader :damage
  attr_accessor :range 

  def initialize(name, weight, damage, range)
    super(name, weight)
    @damage = damage 
    @range = 1
  end

  def hit(robot)
    robot.wound(@damage)
  end
end