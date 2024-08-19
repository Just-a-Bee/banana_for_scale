extends Banana
@onready var base_scale = $Button/JumpingNanaParent.scale
@onready var base_size = $Button.size
@onready var size_ratio = base_scale/base_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func adjust_scale():
	super.adjust_scale()
	$Button/JumpingNanaParent.scale = $Button.size*size_ratio


func _on_handle_released(button):
	super._on_handle_released(button)
	run_rand_timer()

func _on_button_button_up():
	super._on_button_button_up()
	run_rand_timer()

func run_rand_timer():
	var time = randf_range(.8,2)
	$Button/JumpingNanaParent/JumpTimer.start(time)

func jump():
	$Button/JumpingNanaParent/AnimationPlayer.play("banana")
	#button.position
	var tween = get_tree().create_tween()
	tween.tween_property($Button, "position", $Button.position-Vector2(40,0),.6)
	await tween.finished
	run_rand_timer()

func _on_jump_timer_timeout() -> void:
	jump()
