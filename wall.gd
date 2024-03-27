extends StaticBody3D

var boxCollision
var boxMesh

const ROOMSIZE = 14

# Called when the node enters the scene tree for the first time.
func _ready():
	boxCollision = get_node("BoxCollision")
	boxMesh = get_node("BoxMesh")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (-((ROOMSIZE/2)+1) <= global_position.x and global_position.x <= ROOMSIZE) and (-((ROOMSIZE/2)+1) <= global_position.z and global_position.z <= ROOMSIZE):
		print(name)
		if boxCollision is CollisionShape3D:
			boxCollision.disabled = true
		if boxMesh is MeshInstance3D:
			boxMesh.visible = false
	else:
		if boxCollision is CollisionShape3D:
			boxCollision.disabled = false
		if boxMesh is MeshInstance3D:
			boxMesh.visible = true
