extends CharacterBody3D

var grav_vel: Vector3
var throw_speed = 40
var gravity: float = 3

func _physics_process(delta):
	move_and_slide()
#	var collision = move_and_collide(velocity * delta)
#
#	if collision:
#		_stick()
#	else:
#		_fall(delta)

func initialize(player_position, target_position):
	var start_position: Vector3 = Vector3(player_position.x, player_position.y, player_position.z + 2)
	look_at_from_position(player_position, target_position, Vector3.UP)
	velocity = Vector3.FORWARD * throw_speed
	velocity = velocity.rotated(Vector3.UP, rotation.y)
	
func _fall(delta):
	grav_vel = Vector3.ZERO if is_on_floor() else grav_vel.move_toward(Vector3(0, velocity.y - gravity, 0), gravity * delta)
	velocity = velocity + grav_vel
	
func _stick():
	pass
