# Script for the main game scene
# 

extends Control

var current_picture:Picture = null

@onready var picture_rect = $GamePanel/VBoxContainer/HBoxContainer/PicturePanel/MarginContainer/PictureRect
@onready var banana = $Banana

@onready var picture_array:Array[Picture] = [
	Pictures.tutorial_picture,
	Pictures.get_picture(),
	Pictures.get_picture()
]

func _ready():
	next_picture()




# Function to display the next picture for banana scaling
func next_picture():
	current_picture = picture_array.pop_front()
	picture_rect.texture = current_picture.texture

func _on_button_button_up():
	score_banana()
	next_picture()

func score_banana():
	print(banana.get_banana_size())
	var error = (banana.get_banana_size() - current_picture.banana_size).length()
	print(error)
	
