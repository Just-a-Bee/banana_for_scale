# autoload to handle providing pictures to the game
# contains an array of Picture class instances

extends Node

var tutorial_picture:Picture = Picture.new(preload("res://assets/pictures/tape_measure.jpg"), 292)

var picture_arr:Array[Picture] = [
	Picture.new(preload("res://assets/pictures/still_life.jpg"), 237),
	Picture.new(preload("res://assets/pictures/table.jpg"), 46),
	Picture.new(preload("res://assets/pictures/shelf.jpg"), 271),
	Picture.new(preload("res://assets/pictures/orange_cat.jpg"), 128),
	Picture.new(preload("res://assets/pictures/tabby_cat.jpg"), 376),
	Picture.new(preload("res://assets/pictures/nerd.jpg"), 208),
	Picture.new(preload("res://assets/pictures/helmet.jpg"), 216),
	Picture.new(preload("res://assets/pictures/shoes.jpg"), 240),
	Picture.new(preload("res://assets/pictures/vase.jpg"), 375)
]

var final_picture:Picture = Picture.new(preload("res://assets/pictures/coins.jpg"), 1)

# function to return a random picture
func get_picture()->Picture:
	var choice = picture_arr.pick_random()
	picture_arr.erase(choice)
	return choice
