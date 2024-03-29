extends StaticBody3D

var boxMesh
var boxCollision

const ROOMSIZE = 2.5

# Called when the node enters the scene tree for the first time.
func _ready():
	boxMesh = get_node("BoxMesh")
	boxCollision = get_node("BoxCollision")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (-((ROOMSIZE/2)+0.133*ROOMSIZE) <= global_position.x and global_position.x <= ROOMSIZE) and (-((ROOMSIZE/2)+0.133*ROOMSIZE) <= global_position.z and global_position.z <= ROOMSIZE):
		if boxCollision is CollisionShape3D:
			boxCollision.disabled = true
		if boxMesh is MeshInstance3D:
			boxMesh.visible = false
	else:
		if boxCollision is CollisionShape3D:
			boxCollision.disabled = false
		if boxMesh is MeshInstance3D:
			boxMesh.visible = true
