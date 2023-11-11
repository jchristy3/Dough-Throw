extends RigidBody3D

var grav_vel: Vector3
var throw_speed = 2000
var gravity: float = 3
var hasHit = false
var scaleSpeed = 1
var maxScale = 5
var force: Vector3 = Vector3(0,0,0);

func _physics_process(delta):
	get_colliding_bodies()
	
func initialize(player_position, target_position, camera_dir):
	var start_position: Vector3 = Vector3(player_position.x, player_position.y, player_position.z)
	look_at_from_position(start_position, target_position, Vector3.UP)
	force = camera_dir.normalized() * throw_speed
	apply_force(force)
	
func stick(collision):
#	var joint: PinJoint3D = $PinJoint3D
#	#joint.node_a = NodePath("Dough")
#	joint.node_b = NodePath(collision.get_collider_rid())
	var collision_object = collision.get_collider()
	print(collision_object)
	
func grow(delta):
	scale = Vector3(scale.x + scaleSpeed * delta, scale.y + scaleSpeed * delta, scale.z + scaleSpeed * delta)
	scale = scale.clamp(scale, Vector3(maxScale, maxScale, maxScale))
	
