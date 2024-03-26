extends StaticBody3D

var rotating = false
var prevMousePos
var nextMousePos
var windowWidth
var rotatingX = false
var rotatingZ = false

# Rotation speed and decay rate
var rotationSpeed = Vector2(0, 0)
const decayRate = 0.9

func _process(delta):
	windowWidth = get_viewport().size[0]
	if Input.is_action_just_pressed("Rotate"):
		rotating = true
		prevMousePos = get_viewport().get_mouse_position()
		rotationSpeed = Vector2(0, 0)

	if Input.is_action_just_released("Rotate"):
		rotating = false

	if rotating:
		nextMousePos = get_viewport().get_mouse_position()

		# Update rotation speed
		rotationSpeed.x = (nextMousePos.x - prevMousePos.x) * 0.1 * delta
		rotationSpeed.y = (nextMousePos.y - prevMousePos.y) * 0.1 * delta

		# Apply rotation
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

	else:
		# Apply inertia scrolling when not rotating
		rotationSpeed *= decayRate
		rotate_y(rotationSpeed.x)
		if rotatingZ:
			rotate_z(-rotationSpeed.y)
		elif rotatingX:
			rotate_x(rotationSpeed.y)
