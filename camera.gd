extends Camera3D

# Parameters for zooming
var zoomSpeed = 150
var minZoomDistance = 50.0
var maxZoomDistance = 300.0
var multiplier = 50

# Zoom speed and decay rate
var zoomVelocity = 0.0
const zoomDecayRate = 0.85

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ZoomInButton") || Input.is_action_just_released("ZoomInScroll"):
		zoomVelocity += zoomSpeed * delta
		
	elif Input.is_action_pressed("ZoomOutButton") || Input.is_action_just_released("ZoomOutScroll"):
		zoomVelocity -= zoomSpeed * delta

	# Apply inertia
	zoomVelocity *= zoomDecayRate
	
	# Perform zooming
	zoom(zoomVelocity * delta * multiplier)

# Function to handle zooming
func zoom(delta):
	# Calculate new zoom level
	var newZoom = get_global_transform().origin.length() - delta
	
	# Clamp zoom level within min and max distances
	#newZoom = clamp(newZoom, minZoomDistance, maxZoomDistance)
	if (newZoom < minZoomDistance):
		newZoom *= (1 + (minZoomDistance - newZoom)/minZoomDistance)
	if (newZoom > maxZoomDistance):
		newZoom *= (1 - 0.2*(newZoom - maxZoomDistance)/maxZoomDistance)
	# Update camera position
	var cameraPosition = get_global_transform().origin.normalized() * newZoom
	set_global_transform(Transform3D(get_global_transform().basis, cameraPosition))
