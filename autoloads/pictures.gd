# autoload to handle providing pictures to the game
# contains an array of Picture class instances

extends Node

var tutorial_picture:Picture = Picture.new(preload("res://assets/pictures/tape_measure.webp"), 292)

var picture_arr:Array[Picture] = [
	Picture.new(preload("res://assets/pictures/still_life.webp"), 237),
	Picture.new(preload("res://assets/pictures/table.webp"), 46),
	Picture.new(preload("res://assets/pictures/shelf.webp"), 271),
	Picture.new(preload("res://assets/pictures/orange_cat.webp"), 128),
	Picture.new(preload("res://assets/pictures/tabby_cat.webp"), 376),
	Picture.new(preload("res://assets/pictures/nerd.webp"), 208),
	Picture.new(preload("res://assets/pictures/helmet.webp"), 216),
	Picture.new(preload("res://assets/pictures/shoes.webp"), 240),
	Picture.new(preload("res://assets/pictures/vase.webp"), 375)
]

var final_picture:Picture = Picture.new(preload("res://assets/pictures/coins.webp"), 352)

# function to return a random picture
func get_picture()->Picture:
	var choice = picture_arr.pick_random()
	picture_arr.erase(choice)
	return choice
