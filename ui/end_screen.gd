extends Control

@onready var score_counts = [
	$PanelContainer/VBoxContainer/HBoxContainer/VBoxContainer/Count,
	$PanelContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Count,
	$PanelContainer/VBoxContainer/HBoxContainer/VBoxContainer3/Count]

func _ready():
	score_animate()

func score_animate():
	await get_tree().create_timer(2).timeout
	for i in score_counts:
		var score_array = Score.score_array
		score_array.reverse()
		var count = 0
		while count < score_array[score_counts.find(i)]:
			count += 1
			i.text = str(count)
			await get_tree().create_timer(.2).timeout
		await get_tree().create_timer(1).timeout
	var shown_score = 0
	while shown_score < Score.total_score:
		shown_score += 1
		$PanelContainer/VBoxContainer/TotalScore.text = "Score: " + str(shown_score)
		await get_tree().create_timer(.1).timeout
