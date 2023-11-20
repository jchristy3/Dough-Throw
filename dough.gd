extends RigidBody3D

signal create_stuck_dough(position: Vector3, body: Node3D, _scale: Vector3)

var grav_vel: Vector3
var throw_speed = 2000
var gravity: float = 3
var hasHit = false
var scaleSpeed = 1
var maxScale = 5
var force: Vector3 = Vector3(0,0,0);
var stuck = false
var growing = false
var at_max_scale = false
var bodies: Array[Node3D] = []
var jumpScaleSpeed = 20
var absoluteMaxScale = 10

@onready var joint: HingeJoint3D = $PinJoint3D
@onready var collisionShape: CollisionShape3D = $CollisionShape3D
@onready var meshInstance: MeshInstance3D = $MeshInstance3D

func _physics_process(delta):
	if !stuck:
		bodies = get_colliding_bodies()
		if bodies.size() > 0:
			stick(bodies, delta)
	
	if !at_max_scale:
		grow(delta)
	else:
		convert_dough(bodies)
	
func initialize(player_position, target_position, camera_direction):
	var start_position: Vector3 = Vector3(player_position.x, player_position.y, player_position.z)
	start_position += camera_direction.normalized() * 3
	look_at_from_position(start_position, target_position, Vector3.UP)
	force = camera_direction.normalized() * throw_speed
	apply_force(force)
	
func stick(bodies, delta):
	growing = true
	sleeping = true
	freeze = true
	stuck = true
	
	for b in bodies:
		var bName = b.get_name()
		if b.is_in_group("Dough_Thrown"):
			if b.get_maxScale() < absoluteMaxScale:
				b.increase_size(delta)
				queue_free()
		elif bName == "Floor" || bName == "Enemy" || bName.contains("Pillar"):
			joint.node_a = get_path()
			joint.node_b = NodePath(b.get_path())
	
func grow(delta):
	collisionShape.scale = Vector3(collisionShape.scale.x + scaleSpeed * delta, collisionShape.scale.y + scaleSpeed * delta, collisionShape.scale.z + scaleSpeed * delta)
	collisionShape.scale = collisionShape.scale.clamp(scale, Vector3(maxScale, maxScale, maxScale))
	meshInstance.scale = Vector3(meshInstance.scale.x + scaleSpeed * delta, meshInstance.scale.y + scaleSpeed * delta, meshInstance.scale.z + scaleSpeed * delta)
	meshInstance.scale = meshInstance.scale.clamp(scale, Vector3(maxScale, maxScale, maxScale))
	if meshInstance.scale == Vector3(maxScale, maxScale, maxScale):
		at_max_scale = true
		
func convert_dough(bodies: Array[Node3D]):
	if bodies.size() > 0:
		create_stuck_dough.emit(position, bodies[0], meshInstance.scale)
		queue_free()
		
func increase_size(delta):
	maxScale += 1
	collisionShape.scale = Vector3(collisionShape.scale.x + jumpScaleSpeed * delta, collisionShape.scale.y + jumpScaleSpeed * delta, collisionShape.scale.z + jumpScaleSpeed * delta)
	collisionShape.scale = collisionShape.scale.clamp(scale, Vector3(maxScale, maxScale, maxScale))
	meshInstance.scale = Vector3(meshInstance.scale.x + jumpScaleSpeed * delta, meshInstance.scale.y + jumpScaleSpeed * delta, meshInstance.scale.z + jumpScaleSpeed * delta)
	meshInstance.scale = meshInstance.scale.clamp(scale, Vector3(maxScale, maxScale, maxScale))
	
func get_maxScale():
	return maxScale
		

	
