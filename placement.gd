extends Node3D




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
const RAY_LENGTH = 1000.0

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		var camera3d = $Camera3D
		var from = camera3d.project_ray_origin(event.position)
		var to = from + camera3d.project_ray_normal(event.position) * RAY_LENGTH
		var space_state = get_world_3d().direct_space_state
		var query = PhysicsRayQueryParameters3D.create(from, to)
		query.collide_with_areas = true
		var result = space_state.intersect_ray(query)
		if (!result.is_empty()):
			print(result['position'])
			createItem(result['position'], result['collider'], result['normal'])
			
	elif event is InputEventMouseMotion:
		var camera3d = $Camera3D
		var from = camera3d.project_ray_origin(event.position)
		var to = from + camera3d.project_ray_normal(event.position) * RAY_LENGTH
		var space_state = get_world_3d().direct_space_state
		var query = PhysicsRayQueryParameters3D.create(from, to)
		query.collide_with_areas = true
		var result = space_state.intersect_ray(query)
		if (!result.is_empty()):
			createPlaceholder(result['position'], result['collider'], result['normal'])
		else:
			clearPlaceholder()
				
var ITEM_SIZE = Vector3(0.5, 0.5, 0.5)		

const black_mat = preload("res://black.tres")
const trans_mat = preload("res://translucent.tres")

func clearPlaceholder():
	for child in get_children():
		for grand_child in child.get_children():
			for grand_grand_child in grand_child.get_children():
				if grand_grand_child.name.begins_with("placeholder"):
					grand_grand_child.queue_free()

func createPlaceholder(target_position, collider, normal):
	clearPlaceholder()
	var item = StaticBody3D.new()
	var mesh = MeshInstance3D.new()
	mesh.set_name("item mesh")
	mesh.mesh = BoxMesh.new()
	mesh.mesh.set_size(ITEM_SIZE)
	mesh.mesh.surface_set_material(0, trans_mat)
	var collision = CollisionShape3D.new()
	collision.set_name("item coll")
	item.add_child(mesh)
	item.add_child(collision)
	collider.add_child(item)
	var added_item = collider.get_child(-1)
	added_item.set_name("placeholder")
	added_item.global_position = Vector3(target_position.x + (ITEM_SIZE.x * normal.x * 0.5), target_position.y + (ITEM_SIZE.y * normal.y * 0.5), target_position.z + (ITEM_SIZE.z * normal.z * 0.5))

func createItem(target_position, collider, normal):
	var item = StaticBody3D.new()
	item.set_name("node")
	var mesh = MeshInstance3D.new()
	mesh.set_name("item mesh")
	mesh.mesh = BoxMesh.new()
	mesh.mesh.set_size(ITEM_SIZE)
	mesh.mesh.surface_set_material(0, black_mat)
	var collision = CollisionShape3D.new()
	collision.set_name("item coll")
	item.add_child(mesh)
	item.add_child(collision)
	collider.add_child(item)
	var added_item = collider.get_child(-1)
	added_item.global_position = Vector3(target_position.x + (ITEM_SIZE.x * normal.x * 0.5), target_position.y + (ITEM_SIZE.y * normal.y * 0.5), target_position.z + (ITEM_SIZE.z * normal.z * 0.5))
		
