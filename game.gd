# Script for the main game scene
# 

extends Control

const BANANA_START_POS = Vector2(48,96)

var current_picture:Picture = null
var banana_packed = preload("res://banana.tscn")

@onready var picture_rect = $GamePanel/MarginContainer/VBoxContainer/HBoxContainer/PicturePanel/MarginContainer/PictureRect
@onready var banana = $Banana

@onready var picture_array:Array[Picture] = [
	Pictures.final_picture,
	Pictures.tutorial_picture,
	Pictures.get_picture(),
	Pictures.get_picture(),
	Pictures.get_picture(),
	Pictures.get_picture(),
	Pictures.get_picture(),
	
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
	banana.queue_free()
	banana = banana_packed.instantiate()
	banana.position = BANANA_START_POS
	add_child(banana)

func score_banana():
	print(banana.get_banana_size())
	current_picture.score(banana.get_banana_size().x)
	
