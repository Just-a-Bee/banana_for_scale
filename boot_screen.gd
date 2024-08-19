# Script for intro boot screen
# Plays an animation by displaying a bunch of text

extends Control

@onready var title = $PanelContainer/VBoxContainer/Title
@onready var left_column = $PanelContainer/VBoxContainer/HBoxContainer/LeftColumn
@onready var right_column = $PanelContainer/VBoxContainer/HBoxContainer/RightColumn

func _ready():
	show_text()

# function to show all of the text for the animation
func show_text():
	while title.visible_ratio < 1:
		title.visible_characters += 1
		await get_tree().create_timer(.05).timeout
	
	await get_tree().create_timer(.5).timeout
	
	
	while left_column.visible_ratio < 1:
		left_column.visible_characters += 1
		await get_tree().create_timer(.01).timeout
		
		if left_column.text[left_column.visible_characters-1] == "\n":
			await get_tree().create_timer(.2).timeout
			var right_line_finished = false
			while not right_line_finished:
				right_column.visible_characters += 1
				await get_tree().create_timer(.01).timeout
				if right_column.text[right_column.visible_characters] == "\n":
					right_line_finished = true
	get_tree().change_scene_to_file("res://game.tscn")
