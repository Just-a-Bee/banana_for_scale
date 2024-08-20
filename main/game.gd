# Script for the main game scene
# 

extends Control

const BANANA_START_POS = Vector2(48,96)

var current_picture:Picture = null
var banana_packed = preload("res://banana/banana.tscn")
var bad_banana_packed = preload("res://isaiahs-banana/jumping nana.tscn")

@onready var picture_rect = $GamePanel/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/PicturePanel/MarginContainer/PictureRect
var banana:Banana

@onready var event_array:Array = [
	preload("res://assets/audio/voice/tutorial.ogg"),
	Pictures.tutorial_picture,
	Pictures.get_picture(),
	Pictures.get_picture(),
	Pictures.get_picture(),
	"bad_banana",
	Pictures.get_picture(),
	Pictures.get_picture(),
	Pictures.get_picture(),
	Pictures.get_picture(),
	"bad_banana",
	Pictures.get_picture(),
	Pictures.get_picture(),
	preload("res://assets/audio/voice/going_under.ogg"),
	Pictures.final_picture,
	"end"
]

func _ready():
	banana = banana_packed.instantiate()
	add_child(banana)
	banana.move(BANANA_START_POS)
	next_event()

# update time in the corner
func _process(_delta):
	var time = Time.get_time_dict_from_system()
	
	var minute_string = str(time["minute"])
	if time["minute"] < 10:
		minute_string = "0" + minute_string
	
	var am_pm = " AM"
	if time["hour"] > 12:
		time["hour"] = time["hour"] - 12
		am_pm = " PM"
	
	var str = str(time["hour"]) + ":" + minute_string + am_pm
	$GamePanel/VBoxContainer/TopBar/HBoxContainer/Time.text = str

# Function to display the next picture for banana scaling
func next_event():
	if event_array.size() == 0:
		return
	var event = event_array.pop_front()
	if event is AudioStream:
		$Dialogue.stream = event
		$Dialogue.play()
		next_event()
	elif event is Picture:
		current_picture = event
		picture_rect.texture = current_picture.texture
		
	elif event == "bad_banana":
		spawn_banana(true)
		next_event()
	elif event == "end":
		get_tree().change_scene_to_file("res://ui/end_screen.tscn")
	
func _on_button_button_up():
	score_banana()
	$AnimationPlayer.play("show_score")
	await $AnimationPlayer.animation_finished
	spawn_banana()
	next_event()


func spawn_banana(bad = false):
	if banana:
		banana.queue_free()
	if bad:
		banana = bad_banana_packed.instantiate()
	else:
		banana = banana_packed.instantiate()
	add_child(banana)
	banana.move(BANANA_START_POS)

func score_banana():
	var score = current_picture.score(banana.get_banana_size().x)
	var score_string = ""
	if score == Score.SCORES.BAD:
		score_string = "BAD"
	if score == Score.SCORES.GOOD:
		score_string = "GOOD"
	if score == Score.SCORES.PERFECT:
		score_string = "PERFECT"
	$AnimationPlayer/ScoreText.text = score_string
