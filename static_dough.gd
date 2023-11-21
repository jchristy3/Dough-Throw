extends StaticBody3D

var collisionShape: CollisionShape3D
var meshInstance: MeshInstance3D
var growing = false
var at_max_scale = false
var scaleSpeed = 1
var maxScale = 5
var absolute_max_scale = 10
var bumpScaleSpeed = 20

func initialize(start_position: Vector3, _scale: Vector3):
	meshInstance = get_node("MeshInstance3D")
	collisionShape = get_node("CollisionShape3D")
	position = start_position
	meshInstance.scale = _scale
	collisionShape.scale = _scale
	
func _physics_process(delta):
	if !at_max_scale:
		grow(delta)
	
func grow(delta):
	collisionShape.scale = Vector3(collisionShape.scale.x + scaleSpeed * delta, collisionShape.scale.y + scaleSpeed * delta, collisionShape.scale.z + scaleSpeed * delta)
	collisionShape.scale = collisionShape.scale.clamp(scale, Vector3(maxScale, maxScale, maxScale))
	meshInstance.scale = Vector3(meshInstance.scale.x + scaleSpeed * delta, meshInstance.scale.y + scaleSpeed * delta, meshInstance.scale.z + scaleSpeed * delta)
	meshInstance.scale = meshInstance.scale.clamp(scale, Vector3(maxScale, maxScale, maxScale))
	if meshInstance.scale == Vector3(maxScale, maxScale, maxScale):
		at_max_scale = true
		
func bump_size(delta):
	maxScale += 1
	collisionShape.scale = Vector3(collisionShape.scale.x + bumpScaleSpeed * delta, collisionShape.scale.y + bumpScaleSpeed* delta, collisionShape.scale.z + bumpScaleSpeed * delta)
	collisionShape.scale = collisionShape.scale.clamp(scale, Vector3(maxScale, maxScale, maxScale))
	meshInstance.scale = Vector3(meshInstance.scale.x + bumpScaleSpeed * delta, meshInstance.scale.y + bumpScaleSpeed * delta, meshInstance.scale.z + bumpScaleSpeed * delta)
	meshInstance.scale = meshInstance.scale.clamp(scale, Vector3(maxScale, maxScale, maxScale))
	if meshInstance.scale == Vector3(absolute_max_scale, absolute_max_scale, absolute_max_scale):
		at_max_scale = true
	
func is_done_growing():
	return at_max_scale || maxScale == absolute_max_scale
