# autoload to handle providing pictures to the game
# contains an array of Picture class instances

extends Node

var tutorial_picture:Picture = Picture.new(preload("res://assets/pictures/tape_measure.jpg"), 292)

var picture_arr:Array[Picture] = [
	Picture.new(preload("res://assets/pictures/still_life.jpg"), 237),
	Picture.new(preload("res://assets/pictures/table.jpg"), 46),
	Picture.new(preload("res://assets/pictures/shelf.jpg"), 271),
	Picture.new(preload("res://assets/pictures/biggabo.jpg"), 592),
	Picture.new(preload("res://assets/pictures/vase.jpg"), 375)
]

var final_picture:Picture = Picture.new(preload("res://assets/pictures/coins.jpg"), 1)

# function to return a random picture
func get_picture()->Picture:
	var choice = picture_arr.pick_random()
	picture_arr.erase(choice)
	return choice
