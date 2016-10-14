# $hatched_hours = 0

class LayingHen
  attr_reader :age
  @@hatched_hours = 0
  def initialize
             @age = 0
            @eggs = []
  end

  # Ages the hen one month, and lays 4 eggs if the hen is older than 3 months
  def age!
    @age += 1
    if (@age > 3) && (@age < 10)
      4.times { @eggs << Egg.new(@@hatched_hours) }
    end
    @age
  end

  # Returns +true+ if the hen has laid any eggs, +false+ otherwise
  def any_eggs?
   @eggs.length != 0 ? true : false
  end

  # Returns an Egg if there are any
  # Raises a NoEggsError otherwise
  def pick_an_egg!
    raise NoEggsError, "The hen has not layed any eggs" unless self.any_eggs?

    # egg-picking logic goes here
    @eggs.pop 
  end

  # Returns +true+ if the hen can't laid eggs anymore because of its age, +false+ otherwise.
  # The max age for a hen to lay eggs is 10 
  def old?
    @age >= 10 ? true : false 
  end

  def increase_hatched_hour(hours)
    @@hatched_hours += hours
  end
end

class Egg #< LayingHen
  # Initializes a new Egg with hatched hours +hatched_hours+
  def initialize(hatched_hours)#increase_hatched_hour)
    @@hatched_hours = hatched_hours
  end

  # Return +true+ if hatched hours is greater than 3, +false+ otherwise
  def rotten?
    @@hatched_hours >= 3 ? true : false
  end
end


hen = LayingHen.new
basket = []
rotten_eggs = 0

hen.age! until hen.any_eggs?

puts "Hen is #{hen.age} months old, its starting to laid eggs."
puts ""

until hen.old? #+true+ if the hen can't laid eggs anymore because of its age, +false+ otherwise.

  # The time we take to pick up the eggs
  hours = rand(5)
  hen.increase_hatched_hour(hours)

  while hen.any_eggs? # +true+ if the hen has laid any eggs, +false+ otherwise
    egg = hen.pick_an_egg! # +true+ if the hen has laid any eggs, +false+ otherwise

    if egg.rotten? # +true+ if hatched hours is greater than 3, +false+ otherwise
      rotten_eggs += 1
    else
      basket << egg
    end
  end

  puts "Month #{hen.age!} Report"
  puts "We took #{hours} hour(s) to pick the eggs"
  puts "Eggs in the basket: #{basket.size}"
  puts "Rotten eggs: #{rotten_eggs}"
  puts ""

  # Age the hen another month
  hen.age!
end

puts "The hen is old, she can't laid more eggs!"
puts "The hen laid #{basket.size + rotten_eggs} eggs"
if rotten_eggs == 0
  puts "CONGRATULATIONS NO ROTTEN EGGS" 
else
  puts "We pick to late #{rotten_eggs} eggs so they become rotten"
end