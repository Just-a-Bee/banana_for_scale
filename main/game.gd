# Script for the main game scene
# 

extends Control

const BANANA_START_POS = Vector2(48,96)
const TINY_FACTOR = 9
var do_tiny_banana:bool = false
var do_bad_banana:bool = false

var current_picture:Picture = null
var banana_packed = preload("res://banana/banana.tscn")
var bad_banana_packed = preload("res://isaiahs-banana/jumping nana.tscn")

@onready var picture_rect = $GamePanel/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/PicturePanel/MarginContainer/PictureRect
var banana:Banana

@onready var event_array:Array = [

	"intro",
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
	"going_under",
	Pictures.final_picture,
	"end"
]

func _ready():
	banana = banana_packed.instantiate()
	add_child(banana)
	banana.move(BANANA_START_POS)
	next_event()
	$Music.playing = true

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
	
	var string = str(time["hour"]) + ":" + minute_string + am_pm
	$GamePanel/VBoxContainer/TopBar/HBoxContainer/Time.text = string

# Function to start the next game event
# this loads the next picture, but may do some sort of other event before it
# such as setting bad banana to true, or playing dialogue
func next_event():
	if event_array.size() == 0:
		return
	var event = event_array.pop_front()
	if event is Picture:
		current_picture = event
		picture_rect.texture = current_picture.texture
		spawn_banana()
	elif event == "intro": # play intro dialogue
		$DialoguePlayer.play("intro")
		next_event()
	elif event == "going_under": # play going under dialogue
		$DialoguePlayer.play("going_under")
		next_event()
	elif event == "bad_banana": # set bad 
		do_bad_banana = true
		next_event()
	elif event == "start_tiny": # set tiny
		do_tiny_banana = true
		next_event()
	elif event == "end_tiny": # unset tiny
		do_tiny_banana = false
		next_event()
	elif event == "end": # end the game
		$GamePanel/VBoxContainer/MarginContainer/VBoxContainer/BottomBar/Button.disabled = true
		await get_tree().create_timer(1.8).timeout
		get_tree().change_scene_to_file("res://ui/end_screen.tscn")


func play_dialogue():
	$Dialogue.play()
	$Music.volume_db = -20
	$GamePanel/VBoxContainer/MarginContainer/VBoxContainer/BottomBar/Button.disabled = true
	await $Dialogue.finished
	$GamePanel/VBoxContainer/MarginContainer/VBoxContainer/BottomBar/Button.disabled = false
	$Music.volume_db = -7
	

# when button is released, score round
func _on_button_button_up():
	score_banana()
	$AnimationPlayer.play("show_score")
	await $AnimationPlayer.animation_finished
	next_event()

# function to spawn a new banana, checks banana spawn variables
func spawn_banana():
	# if there already is one, free it
	if banana:
		banana.queue_free()
	# if we should do a bad banana, spawn that
	if do_bad_banana:
		do_bad_banana = false
		banana = bad_banana_packed.instantiate()
	# else spawn a normal banana
	else:
		banana = banana_packed.instantiate()
	# if it should be tiny, make it tiny
	if do_tiny_banana:
		banana.is_tiny = true
	# add it as a child
	add_child(banana)
	banana.move(BANANA_START_POS)

func score_banana():
	var banana_size = banana.get_banana_size().x
	if do_tiny_banana:
		banana_size = banana_size * TINY_FACTOR
	var score = current_picture.score(banana_size)
	var score_string = ""
	if score == Score.SCORES.BAD:
		# figure out if it was too big or too small
		if (banana_size > current_picture.banana_size):
			score_string = "TOO BIG"
		else:
			score_string = "TOO SMALL"
		$Bad.play()
	if score == Score.SCORES.GOOD:
		score_string = "GOOD"
		$Good.play()
	if score == Score.SCORES.PERFECT:
		score_string = "PERFECT"
		$Perfect.play()
	$AnimationPlayer/ScoreText.text = score_string
