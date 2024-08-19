# autoload to handle providing pictures to the game
# contains an array of Picture class instances

extends Node

var tutorial_picture:Picture = Picture.new(preload("res://assets/pictures/tape_measure.jpg"), Vector2(1,1), .1)

var picture_arr:Array[Picture] = [
	Picture.new(preload("res://assets/pictures/still_life.jpg"), Vector2(237,224), .1),
	Picture.new(preload("res://assets/pictures/table.jpg"), Vector2(46,51), .1)
]

# function to return a random picture
func get_picture()->Picture:
	var choice = picture_arr.pick_random()
	picture_arr.erase(choice)
	return choice
