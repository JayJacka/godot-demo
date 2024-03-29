extends Node3D




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
const RAY_LENGTH = 1000.0

func _input(event):
	if event is InputEventMouseMotion:
		var camera3d = $Camera3D
		var from = camera3d.project_ray_origin(event.position)
		var to = from + camera3d.project_ray_normal(event.position) * RAY_LENGTH
		var space_state = get_world_3d().direct_space_state
		var query = PhysicsRayQueryParameters3D.create(from, to)
		query.collide_with_areas = true
		var result = space_state.intersect_ray(query)
		if (!result.is_empty()):
			print(result['position'])
			var collider = result['collider']
			if collider is StaticBody3D:
				var children = collider.get_children()
				var mesh: MeshInstance3D
				var collision: CollisionShape3D
				for child in children:
					if child is MeshInstance3D:
						mesh = child
					elif child is CollisionShape3D:
						collision = child
				
		
