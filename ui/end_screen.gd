extends Control

const GOOD_SCORE = 14
const MID_SCORE = 10

@onready var score_counts = [
	$PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Count,
	$PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Count,
	$PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer3/Count]

func _ready():
	score_animate()

func score_animate():
	$DialoguePlayer.play("Exit")
	await $DialoguePlayer.animation_finished
	$Noise.play()
	for i in score_counts:
		var score_array = Score.score_array
		score_array.reverse()
		var count = 0
		while count < score_array[score_counts.find(i)]:
			count += 1
			i.text = str(count)
			await get_tree().create_timer(.2).timeout
		await get_tree().create_timer(.4).timeout
	var shown_score = 0
	while shown_score < Score.total_score:
		shown_score += 1
		$PanelContainer/MarginContainer/VBoxContainer/TotalScore.text = "Score: " + str(shown_score)
		await get_tree().create_timer(.1).timeout
	if Score.total_score >= GOOD_SCORE:
		$DialoguePlayer.play("Good")
	elif Score.total_score >= MID_SCORE:
		$DialoguePlayer.play("Mid")
	else:
		$DialoguePlayer.play("Bad")


func _on_play_again_button_up():
	get_tree().change_scene_to_file("res://main/game.tscn")
