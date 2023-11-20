extends StaticBody3D

var collisionShape: CollisionShape3D
var meshInstance: MeshInstance3D

func initialize(start_position: Vector3, _scale: Vector3):
	meshInstance = get_node("MeshInstance3D")
	collisionShape = get_node("CollisionShape3D")
	position = start_position
	meshInstance.scale = _scale
	collisionShape.scale = _scale
