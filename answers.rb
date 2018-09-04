# BACKEND - Programming

# 1. Give a regular expression that detects hexadecimal numbers in a text.
# For example, ‘0x0f4’, ‘0acdadecf822eeff32aca5830e438cb54aa722e3’, ‘8BADF00D’ should be detected.
# >
# General case
/(0x)?[0-9a-f]+/i
# Ruby
/(0x)?[\h]+/i

# 2.Here is the pseudo code of a function that is defined recursively:
# -  f(0) = 1;
# -  f(1) = 3;
# -  f(n)= 3 * f(n-1) - f(n-2);
# Provide an implementation for ‘f’. Bonus points for a non recursive implementation.
# >
def recur(n)
	return if n < 0
	return 1 if n == 0
	return 3 if n == 1
	return 3 * recur(n - 1) - recur(n - 2)
end

def non_recur(n)
	return if n < 0
	return 1 if n == 0
	return 3 if n == 1
	val1 = 1
	val2 = 3
	while n >= 2
		val = 3 * val2 - val1
		val1 = val2
		val2 = val
		n -= 1
	end
	return val
end

# BACKEND - MySQL

# 1. Write a CREATE TABLE query for a table storing information on users. It will store:
#   - id,
#   - firstname,
#   - lastname,
#   - gender,
#   - email,
#   - created_at
# >
CREATE TABLE IF NOT EXISTS users (
	id INT(6) AUTO_INCREMENT PRIMARY KEY,
	firstname VARCHAR(30) NOT NULL,
	lastname VARCHAR(30) NOT NULL,
	gender CHAR(20),
	email VARCHAR(50) NOT NULL,
	created_at DATE NOT NULL
);

# 2. Write a query on the previous table that lists the 10 most recently added users.
# >
SELECT * FROM users ORDER BY id DESC LIMIT 10;
# GENERAL - Creativity
# Si vous êtes Français, vous pouvez répondre en Français.

# 1. Describe the color blue to someone who is blind
# >
Play note C on the flute to that person

# 3. Describe the data model you’d use for a Battleship game. What are the key objects? How will your code use them?
# >
player: :id, :name, :email
game: :id, :player1_id, :player2_id, :player1_score, :player2_score
board: :id, :game_id, :player_id, :size
coordinate: :id, :letter (a -> h), :number (1 -> 8), :hit (true or false), :board_id
ship: :id, :board_id, :coordinates (example: intact: ["a1", "b1", "c1"], hit: []), :sunk (true or false, dafault: false)

=> usage: "At the start of the game, each players is given a number of ships with coordinates that are consecutive (either by number or letter -> ['a1', 'b1', 'c1'] or ['e1', 'e2', 'e3']). Tables with cells are generated to represent the board with coordinates depending on the size and each cell clicked is then submitted through a form to represent 'shot' made. The 'shot's coordinate then is compared to the opponent's ships' coordinates and if it hits a ship, the ship's coordinate will be moved to the 'hit' array instead of 'intact' array. Once a ship has the 'intact' array empty, it will be changed to sunk: true. Once a players have all his ships on the board sunk, the other player will score 1 point for the game"

# 4.
