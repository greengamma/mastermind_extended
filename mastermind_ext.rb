# 'Computer' class to generate the random colors by the computer
class CodemakerComp
  attr_reader :codemaker_colors

  def initialize
    @color_selection = ['yellow', 'blue', 'green', 'red', 'orange', 'purple']
    @codemaker_colors = [
                  @color_selection.sample,
                  @color_selection.sample,
                  @color_selection.sample,
                  @color_selection.sample
                  ]
  end
end

# 'Player' class to handle the inputs of the player
class CodebreakerUser
  attr_reader :codebreaker_colors
  def initialize
    @codebreaker_colors = []
  end

  def get_user_colors(counter)
    @codebreaker_colors = []
    if counter == 0
      puts "Please enter 4 colors of your choice in consecutive order. \n"
      puts "The available colors are: 'yellow', 'blue', 'green', 'red', 'orange', 'purple'"
      puts "Select color 1: "
      color1 = gets.chomp
      puts "Select color 2: "
      color2 = gets.chomp
      puts "Select color 3: "
      color3 = gets.chomp
      puts "Select color 4: "
      color4 = gets.chomp
      @codebreaker_colors.push(color1, color2, color3, color4)
    else
      puts "--- ROUND #{counter+1} ---"
      puts "Try again with these colors: 'yellow', 'blue', 'green', 'red', 'orange', 'purple'"
      puts "Select color 1: "
      color1 = gets.chomp
      puts "Select color 2: "
      color2 = gets.chomp
      puts "Select color 3: "
      color3 = gets.chomp
      puts "Select color 4: "
      color4 = gets.chomp
      @codebreaker_colors.push(color1, color2, color3, color4)
    end
  end

  def display_user_colors
    puts "You selected: #{@codebreaker_colors}"
  end
end

# 'Board' class to show the game board and provide checks
class Board
  def initialize(codemaker, codebreaker)
    @codemaker = codemaker
    @codebreaker = codebreaker
  end

  def compare_codemaker_codebreaker
    compare_result = @codebreaker.codebreaker_colors.zip(@codemaker.codemaker_colors).map do |a, b|
      if a == b
        "black"
      elsif @codemaker.codemaker_colors.include?(a)
        "white"
      else
        "__"
      end
    end
    return compare_result.all?('black'), compare_result
  end
end

# Prompt to decide who wants to be the codemaker
puts "Do you want to be the codeMAKER (1) or the codeBREAKER (2)? Select (1 or 2): "
user_choice = gets.chomp

if user_choice == 1

  # USER is Codebreaker - start
  # initialize classes
  codemaker = CodemakerComp.new
  codebreaker = CodebreakerUser.new
  board = Board.new(codemaker, codebreaker)

  # run loop a maximum of 12 times and check for game over
  counter = 0
  game_over = false

  until game_over
    if counter == 12
      puts "You lost!\n"
      puts "The computer chose the following colors: #{codemaker.codemaker_colors}!"
      break
    else
      codebreaker.get_user_colors(counter)
      puts "\n"
      puts codebreaker.display_user_colors
      puts "\n"
      game_over, compare_result = board.compare_codemaker_codebreaker
      p compare_result
      puts "\n"
    end

    counter += 1
  end

  # After game over
  puts "You won! The computer chose the following colors: #{codemaker.codemaker_colors}!"
  # USER is Codebreaker - end
else
  nil
end







# If user, then computer needs to be codebreaker => needs class for generating the algorithm
