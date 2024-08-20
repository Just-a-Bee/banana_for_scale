# Script for the rescalable banana
# Can be clicked and dragged, and has four scaling handles on the corners

extends Control
class_name Banana

var texture_array = [
	preload("res://assets/bananas/banana.png"),
	preload("res://assets/bananas/banana2.png"),
	preload("res://assets/bananas/banana4.png")
						]

# array of scale handle nodes
@onready var handles = [$TopLeft, $TopRight, $BottomLeft, $BottomRight]

# minimum size of the banana
const MINIMUM_SIZE = Vector2(20,20)

# bool for if banana is currently being dragged
var dragging:bool = false

# scale handle vars
var draghandle = null
var min_handle_pos:Vector2
var max_handle_pos:Vector2
var prev_mouse_pos = Vector2.ZERO

# on ready connect signals
func _ready():
	if $Button is TextureButton:
		$Button.texture_normal = texture_array.pick_random()
	for i in handles:
		i.button_down.connect(_on_handle_clicked.bind(i))
		i.button_up.connect(_on_handle_released)

# when a handle is clicked it becomes the target handle for dragging
func _on_handle_clicked(handle):
	draghandle = handle
	var handle_pos = draghandle.position
	
	# calculate the minimum and maximum position of the handle
	if draghandle.position.x < draghandle.share_y.position.x:
		max_handle_pos.x = draghandle.share_y.position.x - MINIMUM_SIZE.x
		min_handle_pos.x = 0
	else:
		min_handle_pos.x = draghandle.share_y.position.x + MINIMUM_SIZE.x
		max_handle_pos.x = get_viewport().size.x
	
	if draghandle.position.y < draghandle.share_x.position.y:
		max_handle_pos.y = draghandle.share_x.position.y - MINIMUM_SIZE.y
		min_handle_pos.y = 0
	else:
		min_handle_pos.y = draghandle.share_x.position.y + MINIMUM_SIZE.y
		max_handle_pos.y = get_viewport().size.y
	
	print(min_handle_pos)
	print(max_handle_pos)
	

# when a handle is released, stop dragging it
func _on_handle_released():
	draghandle = null

# input function handles results of mouse movement
func _input(_event):
	var mouse_distance = get_local_mouse_position() - prev_mouse_pos
	# move scale handle if dragging one
	if draghandle:
		move_handle(draghandle, draghandle.position + mouse_distance)
		adjust_scale()
	# move banana if being dragged
	elif dragging:
		move(mouse_distance)
	prev_mouse_pos = get_local_mouse_position()

# move scale handle to given position, limiting to minimum and maximum values
func move_handle(handle, pos):
	pos.x = max(min_handle_pos.x, pos.x)
	pos.x = min(max_handle_pos.x, pos.x)
	pos.y = max(min_handle_pos.y, pos.y)
	pos.y = min(max_handle_pos.y, pos.y)
	
	var line_direction = (draghandle.position - draghandle.opposite.position).normalized()
	var vector_to_object = pos - draghandle.position
	var distance = line_direction.dot(vector_to_object)
	pos = draghandle.position + distance * line_direction
	
	handle.move(pos)
	

# Function to adjust the transform of banana to match scale handles
func adjust_scale():
	$Button.position = $TopLeft.position + Vector2(8,8)
	$Button.size = $BottomRight.position - $TopLeft.position

func get_banana_size():
	return $Button.size

func _on_button_button_down():
	dragging = true
func _on_button_button_up():
	dragging = false

func move(pos:Vector2)->void:
	$Button.position += pos
	for i in handles:
		i.position += pos
