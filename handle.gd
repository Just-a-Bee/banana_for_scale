extends Button
class_name Handle

@export var share_x:Handle
@export var share_y:Handle

func move(new_position):
	position = new_position
	share_x.position.x = position.x
	share_y.position.y = position.y
