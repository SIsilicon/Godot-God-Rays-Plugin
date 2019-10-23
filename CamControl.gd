extends Spatial

const UP = Vector3(0, 1, 0)
const CAMERA_SPEED = 2.0
const ZOOM_SPEED = 0.2

onready var distance := translation.length()

func _unhandled_input(event : InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_DOWN:
			distance += ZOOM_SPEED
		elif event.button_index == BUTTON_WHEEL_UP:
			distance -= ZOOM_SPEED
		distance = max(distance, 0.5)

func _physics_process(delta : float) -> void:
	var speed := delta * CAMERA_SPEED * distance
	
	var xform := get_transform()
	var upangle := acos(-xform.basis[2].dot(UP))
	
	if Input.is_key_pressed(KEY_A):
		translation -= xform.basis[0] * speed * sin(upangle)
	if Input.is_key_pressed(KEY_D):
		translation += xform.basis[0] * speed * sin(upangle)
	if Input.is_key_pressed(KEY_S):
		translation -= xform.basis[1] * speed
	if Input.is_key_pressed(KEY_W):
		translation += xform.basis[1] * speed
	translation = translation.normalized() * distance
	
	look_at($"../".translation, UP)