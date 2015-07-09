class BoxOfBolts < Item

  def initialize
    super("box of bolts", 25)
  end

  def feed(robot)
    robot.heal(20)
  end
end
