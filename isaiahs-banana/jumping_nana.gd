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

func _on_handle_released():
	super._on_handle_released()
	run_rand_timer()

func _on_button_button_up():
	super._on_button_button_up()
	run_rand_timer()

func run_rand_timer():
	var time = randf_range(.8,2)
	$Button/JumpingNanaParent/JumpTimer.start(time)

func jump():
	$Button/JumpingNanaParent/AnimationPlayer.play("banana")
	
	var jump_distance = Vector2(1,0) * $Button.size * .4
	var tweeners = []
	var tween_nodes = [$Button, $TopLeft, $TopRight, $BottomRight, $BottomLeft]
	
	for i in tween_nodes.size():
		tweeners.append(get_tree().create_tween())
		tweeners[i].tween_property(tween_nodes[i], "position", tween_nodes[i].position-jump_distance,.6).set_trans(Tween.TRANS_CUBIC)
	
	await tweeners[0].finished
	run_rand_timer()

func _on_jump_timer_timeout() -> void:
	jump()
