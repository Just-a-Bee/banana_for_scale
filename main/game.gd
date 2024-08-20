# Script for the main game scene
# 

extends Control

const BANANA_START_POS = Vector2(48,96)

var current_picture:Picture = null
var banana_packed = preload("res://banana/banana.tscn")

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
	preload("res://assets/audio/voice/going_under.ogg"),
	Pictures.final_picture,
]

func _ready():
	banana = banana_packed.instantiate()
	add_child(banana)
	banana.move(BANANA_START_POS)
	next_event()

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
		pass
	
func _on_button_button_up():
	score_banana()
	next_event()
	spawn_banana()


func spawn_banana():
	if banana:
		banana.queue_free()
	banana = banana_packed.instantiate()
	add_child(banana)
	banana.move(BANANA_START_POS)

func score_banana():
	print(banana.get_banana_size())
	current_picture.score(banana.get_banana_size().x)
	
