# class definition for the pictures that appear in the game
# each has a texture, a desired banana size, and a tolerance for the player to be wrong by

class_name Picture


var perfect_tolerance:float = 5
var ok_tolerance:float = 10

var texture:Texture2D = preload("res://icon.svg")
var banana_size:float = 1

# constructor function sets each variable
func _init(t:Texture2D, s:float):
	texture = t
	banana_size = s
	perfect_tolerance = .1*banana_size
	ok_tolerance = .3 * banana_size + 5

func score(size:float):
	var error = abs(size - banana_size)
	if error < perfect_tolerance:
		Score.increment(Score.SCORES.PERFECT)
		return Score.SCORES.PERFECT
	elif error < ok_tolerance:
		Score.increment(Score.SCORES.GOOD)
		return Score.SCORES.GOOD
	else:
		Score.increment(Score.SCORES.BAD)
		return Score.SCORES.BAD
	
