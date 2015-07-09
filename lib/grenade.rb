class Grenade < Weapon

  attr_accessor :range

  def initialize
    super("Grenade", 40, 15, 2)
    @range = 2
  end

end
