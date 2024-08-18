# autoload to handle providing pictures to the game
# contains an array of Picture class instances

extends Node

var picture_arr:Array[Picture] = [
	Picture.new(preload("res://assets/pictures/still_life.jpg"), 1, .1),
	Picture.new(preload("res://assets/pictures/table.jpg"), 1, .1)
]

# function to return a random picture
func get_picture()->Picture:
	var choice = picture_arr.pick_random()
	picture_arr.erase(choice)
	return choice
