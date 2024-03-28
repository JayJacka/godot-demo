extends StaticBody3D

var boxMesh

const ROOMSIZE = 2.5

# Called when the node enters the scene tree for the first time.
func _ready():
	boxMesh = get_node("BoxMesh")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (-((ROOMSIZE/2)+0.133*ROOMSIZE) <= global_position.x and global_position.x <= ROOMSIZE) and (-((ROOMSIZE/2)+0.133*ROOMSIZE) <= global_position.z and global_position.z <= ROOMSIZE):
		if boxMesh is MeshInstance3D:
			boxMesh.visible = false
	else:
		if boxMesh is MeshInstance3D:
			boxMesh.visible = true
