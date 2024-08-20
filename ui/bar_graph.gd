extends VBoxContainer

var BAR_MAX = 160

func _ready():
	Score.score_changed.connect(update_graph)

func update_graph():
	var total = 0
	var max = 3
	for i in Score.score_array:
		total += i
		if i > max:
			max = i
	var bars = get_children()
	bars.reverse()
	for i in bars.size():
		bars[i].get_node("Count").text = str(Score.score_array[i])
		var bar_size = Vector2(float(Score.score_array[i])/max*BAR_MAX, 40)
		var tween = get_tree().create_tween()
		tween.tween_property(bars[i].get_node("Bar"), "custom_minimum_size", bar_size, .1)
