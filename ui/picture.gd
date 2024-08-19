# class definition for the pictures that appear in the game
# each has a texture, a desired banana size, and a tolerance for the player to be wrong by

class_name Picture


const PERFECT_TOLERANCE:float = 5
const OK_TOLERANCE:float = 10

var texture:Texture2D = preload("res://icon.svg")
var banana_size:float = 1

# constructor function sets each variable
func _init(t:Texture2D, s:float):
	texture = t
	banana_size = s

func score(size:float):
	var error = abs(size - banana_size)
	if error < PERFECT_TOLERANCE:
		Score.increment(Score.SCORES.PERFECT)
	elif error < OK_TOLERANCE:
		Score.increment(Score.SCORES.GOOD)
	else:
		Score.increment(Score.SCORES.BAD)
	
