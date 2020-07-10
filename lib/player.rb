class Player
  attr_accessor :name, :white, :move_history
  def initialize(name, white)
    @name = name 
    @white = white 
    @move_history = []
  end

  def get_input(move_num, repeated=false)
    puts "Move #{move_num}: Player #{name} - Color #{@white ? 'white' : 'black'}" unless repeated
    input_move = gets.chomp.strip.downcase
    move_history.push(input_move)
  end 

  def report_invalid_move()
    invalid_move = move_history.pop
    puts "#{invalid_move} is not a valid move."
  end

  def report_check()
    puts "You are in check."
  end

  def report_custom_message(message)
    puts message
  end
end
