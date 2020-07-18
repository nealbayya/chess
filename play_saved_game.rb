require_relative 'lib/engine'

path = "./saved/" 
puts "Enter file name: "
file_name = gets.chomp
file_path = path + file_name
game_data = File.open(file_path).read
savedGame = ChessEngine.load(game_data)

savedGame.play

