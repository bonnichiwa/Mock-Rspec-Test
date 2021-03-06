class Robot

  # attr_reader :items, :health
  attr_accessor :position, :items, :health, :capacity, :equipped_weapon
  
  @@all_robots = []

  ATTACK_POWER = 5
  
  def initialize
    @position = [0,0]
    @items = []
    @health = 100
    @equipped_weapon = nil
    @@all_robots << self
  end

  def self.get_robots
    @@all_robots
  end

  def move_left
    @position[0] -= 1
  end

  def move_right
    @position[0] += 1
  end

  def move_up
    @position[1] += 1
  end

  def move_down
    @position[1] -= 1
  end

  def pick_up(object)
    can_pick_up = items_weight + object.weight <= 250

    if can_pick_up
      if object.class == BoxOfBolts && health <= 80
        object.feed(self)
      else
        @items << object
      end
      @equipped_weapon = object if object.is_a?(Weapon)
    end

    can_pick_up
  end

  def items_weight
    @items.inject(0) {|x, y| x += y.weight}
  end

  def wound(damage)
    #@health -= damage
    #@health = [@health, 0].max

    if damage > @health
      @health = 0
    else 
      @health -= damage
    end
  end

  def heal(power)
    #@health += power
    #@health = [@health, 100].min

    if @health >= 100
      return @health
    else
      @health += power
    end
  end

  def heal!(power)
    
    if @health <= 0
      raise StandardError, "Sorry, robots cannot be revived"
    else
      heal(power)
    end
  end

  def attack(enemy)

    if (@position[1] - enemy.position[1]).abs <= 1
      if @equipped_weapon 
        @equipped_weapon.hit(enemy)
      else
        enemy.wound(ATTACK_POWER)
      end
    elsif @equipped_weapon.name == "Grenade"
      if (@position[1] - enemy.position[1]).abs <= 2
        enemy.wound(@equipped_weapon.damage)
        @equipped_weapon = nil
      end
    end
  end

  def attack!(enemy)
    if enemy.class != Robot
      raise StandardError, "Sorry, you cannot attack this thing, it's not a robot!"
    else
      attack(enemy)
    end
  end
end





