extends VBoxContainer

var MAX_SIZE = 140

func _ready():
	Score.score_changed.connect(update_graph)

func update_graph():
	var bar_max = 3
	for i in Score.score_array:
		if i > bar_max:
			bar_max = i
	var bars = get_children()
	bars.reverse()
	for i in bars.size():
		bars[i].get_node("Count").text = str(Score.score_array[i])
		var bar_size = Vector2(float(Score.score_array[i])/bar_max*MAX_SIZE, 40)
		var tween = get_tree().create_tween()
		tween.tween_property(bars[i].get_node("Bar"), "custom_minimum_size", bar_size, .1)
