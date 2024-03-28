extends Node3D

var rotating = false
var rotatingButton = false
var prevMousePos
var nextMousePos
var windowWidth
var rotatingX = false
var rotatingZ = false

var rotationSpeed = Vector2(0, 0)
const decayRate = 0.9

var boxCollision
var boxMesh

func _ready():
	pass
	
func _process(delta):
	windowWidth = get_viewport().size[0]
	if Input.is_action_just_pressed("Rotate"):
		rotating = true
		prevMousePos = get_viewport().get_mouse_position()
		rotationSpeed = Vector2(0, 0)

	if Input.is_action_just_released("Rotate"):
		rotating = false
		
	if Input.is_action_just_pressed("RotateRight"):
		rotatingButton = true
		rotationSpeed = Vector2(delta, 0)
	
	if Input.is_action_just_pressed("RotateLeft"):
		rotatingButton = true
		rotationSpeed = Vector2(-delta, 0)
	
	if Input.is_action_just_released("RotateRight") || Input.is_action_just_released("RotateLeft"):
		rotatingButton = false

	if rotating:
		nextMousePos = get_viewport().get_mouse_position()

		rotationSpeed.x = (nextMousePos.x - prevMousePos.x) * 0.07 * delta
		rotationSpeed.y = (nextMousePos.y - prevMousePos.y) * 0.07 * delta

		rotate_y(rotationSpeed.x)
		if nextMousePos.x > windowWidth / 2:
			rotate_z(-rotationSpeed.y)
			rotatingX = false
			rotatingZ = true
		else:
			rotate_x(rotationSpeed.y)
			rotatingX = true
			rotatingZ = false

		prevMousePos = nextMousePos
	
	elif rotatingButton:
		rotate_y(rotationSpeed.x)

	else:
		rotationSpeed *= decayRate
		rotate_y(rotationSpeed.x)
		if rotatingZ:
			rotate_z(-rotationSpeed.y)
		elif rotatingX:
			rotate_x(rotationSpeed.y)


