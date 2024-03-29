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
		for child in get_children():
			for grand_child in child.get_children():
				if grand_child is CollisionShape3D:
					grand_child.disabled = true
				elif grand_child is MeshInstance3D:
					grand_child.visible = false
	else:
		if boxCollision is CollisionShape3D:
			boxCollision.disabled = false
		if boxMesh is MeshInstance3D:
			boxMesh.visible = true
		for child in get_children():
			for grand_child in child.get_children():
				if grand_child is CollisionShape3D:
					grand_child.disabled = false
				elif grand_child is MeshInstance3D:
					grand_child.visible = true
