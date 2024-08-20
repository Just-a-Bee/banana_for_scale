# Script for intro boot screen
# Plays an animation by displaying a bunch of text

extends Control

@onready var title = $Boot/VBoxContainer/Title
@onready var left_column = $Boot/VBoxContainer/HBoxContainer/LeftColumn
@onready var right_column = $Boot/VBoxContainer/HBoxContainer/RightColumn

func _ready():
	show_text()
	$Loading/Loadingnana/AnimationPlayer.play("load")
	
# function to show all of the text for the animation
func show_text():
	while title.visible_ratio < 1:
		title.visible_characters += 1
		await get_tree().create_timer(.05).timeout
	
	await get_tree().create_timer(.25).timeout
	
	
	while left_column.visible_ratio < 1:
		left_column.visible_characters += 1
		await get_tree().create_timer(.005).timeout
		
		if left_column.text[left_column.visible_characters-1] == "\n":
			await get_tree().create_timer(.1).timeout
			var right_line_finished = false
			while not right_line_finished:
				right_column.visible_characters += 1
				await get_tree().create_timer(.005).timeout
				if right_column.text[right_column.visible_characters] == "\n":
					right_line_finished = true
	$Boot.hide()
	$Loading.show()
	
	for i in 2:
		$Loading/RichTextLabel.visible_characters = 16
		await get_tree().create_timer(.3).timeout
		$Loading/RichTextLabel.visible_characters = 17
		await get_tree().create_timer(.3).timeout
		$Loading/RichTextLabel.visible_characters = 18
		await get_tree().create_timer(.3).timeout
	get_tree().change_scene_to_file("res://main/game.tscn")
