# Script for the main game scene
# 

extends Control

var current_picture:Picture = null

@onready var picture_rect = $GamePanel/VBoxContainer/HBoxContainer/PicturePanel/MarginContainer/PictureRect


func _ready():
	next_picture()

# Function to display the next picture for banana scaling
func next_picture():
	current_picture = Pictures.get_picture()
	picture_rect.texture = current_picture.texture

func _on_button_button_up():
	
	next_picture()
