# class definition for the pictures that appear in the game
# each has a texture, a desired banana size, and a tolerance for the player to be wrong by

class_name Picture

var texture:Texture2D = preload("res://icon.svg")
var banana_size:float = 1
var tolerance:float = 1

# constructor function sets each variable
func _init(t:Texture2D, s:float, tol:float):
	texture = t
	banana_size = s
	tolerance = tol
	
