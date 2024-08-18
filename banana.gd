# Script for the rescalable banana
# Can be clicked and dragged, and has four scaling handles on the corners

extends Control

@onready var handles = [$TopLeft, $TopRight, $BottomLeft, $BottomRight]

const MINIMUM_SIZE = Vector2(20,20)

var dragging:bool = false

var draghandle = null
var prev_mouse_pos = Vector2.ZERO

func _ready():
	for i in handles:
		i.button_down.connect(_on_handle_clicked.bind(i))
		i.button_up.connect(_on_handle_released.bind(i))

func _on_handle_clicked(button):
	draghandle = button

func _on_handle_released(button):
	draghandle = null

func _input(event):
	if draghandle:
		move_handle(draghandle, draghandle.position + get_local_mouse_position() - prev_mouse_pos)
		adjust_scale()
	if dragging:
		$Button.position += get_local_mouse_position() - prev_mouse_pos
		for i in handles:
			i.position += get_local_mouse_position() - prev_mouse_pos
	prev_mouse_pos = get_local_mouse_position()

func move_handle(handle, pos):
	handle.move(pos)
	

# Function to adjust the transform of banana to match scale handles
func adjust_scale():
	$Button.position = $TopLeft.position + Vector2(8,8)
	$Button.size = $BottomRight.position - $TopLeft.position


func _on_button_button_down():
	dragging = true
func _on_button_button_up():
	dragging = false
