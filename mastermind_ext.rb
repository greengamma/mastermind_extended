# 'Computer' class to generate the random colors by the computer
class Codemaker
  attr_reader :codemaker_colors

  def initialize(user_choice)
    @user_choice = user_choice
    @color_selection = ['yellow', 'blue', 'green', 'red', 'orange', 'purple']
    @codemaker_colors = []
    if @user_choice == '2' # comp is the codemaker and generates random colors
      @codemaker_colors = [
                    @color_selection.sample,
                    @color_selection.sample,
                    @color_selection.sample,
                    @color_selection.sample
                    ]
    else # user is the codemaker and specifies the code
      puts "Input 4 of the following colors to generate your code: #{@color_selection}"
      puts "Select color 1: "
      color1 = gets.chomp
      puts "Select color 2: "
      color2 = gets.chomp
      puts "Select color 3: "
      color3 = gets.chomp
      puts "Select color 4: "
      color4 = gets.chomp
      @codemaker_colors.push(color1, color2, color3, color4)
    end
  end
end

# 'Player' class to handle the inputs of the player
class Codebreaker
  attr_reader :codebreaker_colors

  def initialize
    @color_selection = ['yellow', 'blue', 'green', 'red', 'orange', 'purple']
    @codebreaker_colors = []
  end

  def get_user_colors(counter) # if user is the codebreaker
    @codebreaker_colors = []
    if counter == 0
      puts "Please enter 4 colors of your choice in consecutive order. \n"
      puts "The available colors are: #{@color_selection}"
    else
      puts "--- ROUND #{counter+1} ---"
      puts "Try again with these colors: #{@color_selection}"
    end
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

  def comp_generated_colors(counter) # if comp is the codebreaker
    @codebreaker_colors = []
    if counter == 0
      puts "Computer trying..."
    else
      puts "Computer trying again..."
      puts "--- ROUND #{counter+1} ---"
    end
    @codebreaker_colors = [
      @color_selection.sample,
      @color_selection.sample,
      @color_selection.sample,
      @color_selection.sample
      ]
  end

  def display_chosen_colors
    puts "Colors selected: #{@codebreaker_colors}"
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

# initialize classes
codemaker = Codemaker.new(user_choice)
codebreaker = Codebreaker.new
board = Board.new(codemaker, codebreaker)
# run loop a maximum of 12 times and check for game over
counter = 0
game_over = false

until game_over
  if counter == 12
    if user_choice == '2'
      puts "You lost!\n"
      puts "The computer chose the following colors: #{codemaker.codemaker_colors}!"
      break
    elsif user_choice == '1'
      puts "The computer lost!\n"
      puts "You chose the following colors: #{codemaker.codemaker_colors}!"
      break
    end
  elsif user_choice == '2' # user is the codebreaker
    codebreaker.get_user_colors(counter)
    puts "\n"
    puts codebreaker.display_chosen_colors
    puts "\n"
    game_over, compare_result = board.compare_codemaker_codebreaker
    puts "Result: #{compare_result}"
    puts "\n"
    if game_over == true
      puts "You won! The computer chose the following colors: #{codemaker.codemaker_colors}!"
    end
  elsif user_choice == '1' # comp is the codebreaker
    codebreaker.comp_generated_colors(counter)
    puts "\n"
    puts codebreaker.display_chosen_colors
    puts "\n"
    game_over, compare_result = board.compare_codemaker_codebreaker
    puts "Result: #{compare_result}"
    puts "\n"
    if game_over == true
      puts "The computer won! You chose the following colors: #{codemaker.codemaker_colors}!"
    end
  end
  counter += 1
end

# After game over
  # USER is Codebreaker - end







# If user, then computer needs to be codebreaker => needs class for generating the algorithm
