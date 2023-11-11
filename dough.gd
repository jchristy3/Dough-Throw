extends RigidBody3D

var grav_vel: Vector3
var throw_speed = 2000
var gravity: float = 3
var hasHit = false
var scaleSpeed = 1
var maxScale = 5
var force: Vector3 = Vector3(0,0,0);
var lastPrinted = ""
var stuck = false
var growing = false

@onready var joint: PinJoint3D = $PinJoint3D

func _physics_process(delta):
	if !stuck:
		stick()
	
	if growing:
		grow(delta)
	
func initialize(player_position, target_position, camera_direction):
	var start_position: Vector3 = Vector3(player_position.x, player_position.y, player_position.z)
	start_position += camera_direction.normalized()
	look_at_from_position(start_position, target_position, Vector3.UP)
	force = camera_direction.normalized() * throw_speed
	apply_force(force)
	
func stick():
	var bodies = get_colliding_bodies()
	
	for i in bodies:
		if i.get_name() == "Player" || i.get_name() == "Dough":
			joint.node_b = NodePath(i.get_name())
	
func grow(delta):
	scale = Vector3(scale.x + scaleSpeed * delta, scale.y + scaleSpeed * delta, scale.z + scaleSpeed * delta)
	scale = scale.clamp(scale, Vector3(maxScale, maxScale, maxScale))
	
