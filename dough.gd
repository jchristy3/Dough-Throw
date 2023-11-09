extends CharacterBody3D

var grav_vel: Vector3
var throw_speed = 40
var gravity: float = 3
var hasHit = false
var scaleSpeed = 1
var maxScale = 5

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	
	if !hasHit:
		if collision:
			hasHit = true
		else:
			_fall(delta)
	else:
		stick(collision)
		grow(delta)

func initialize(player_position, target_position, camera_dir):
	var start_position: Vector3 = Vector3(player_position.x, player_position.y, player_position.z)
	look_at_from_position(start_position, target_position, Vector3.UP)
	var vel_dir: Vector3 = camera_dir.normalized()
	velocity = velocity.move_toward(vel_dir * throw_speed * vel_dir.length(), 100)
	
func _fall(delta):
	grav_vel = Vector3.ZERO if is_on_floor() else grav_vel.move_toward(Vector3(0, velocity.y - gravity, 0), gravity * delta)
	velocity = velocity - abs(grav_vel)
	
func stick(collision):
	print(collision.get_collider().velocity)

func grow(delta):
	scale = Vector3(scale.x + scaleSpeed * delta, scale.y + scaleSpeed * delta, scale.z + scaleSpeed * delta)
	scale = scale.clamp(scale, Vector3(maxScale, maxScale, maxScale))
	
