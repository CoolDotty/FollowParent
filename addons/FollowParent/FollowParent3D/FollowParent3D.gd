@tool
@icon("res://addons/FollowParent/FollowParent3D/icon.svg")
extends Node3D
class_name FollowParent3D

@export_category("FollowParent3D")
@export var lerp_speed: float = 20.0
@export_range(0, 128, 0.1, "suffix:px") var position_snap: float = 0.0
@export_range(0, 360, 0.1, "degrees") var rotational_snap: float = 0.0


func _ready():
	top_level = true


func _process(delta):
	var parent = get_parent()
	if not is_instance_valid(parent):
		return
	
	global_position = global_position.lerp(parent.global_position, delta * lerp_speed)
	if global_position.distance_to(parent.global_position) < position_snap:
		global_position = parent.global_position
	
	global_rotation = global_rotation.lerp(parent.global_rotation, delta * lerp_speed)
	if global_rotation.distance_to(parent.global_rotation) < position_snap:
		global_rotation = parent.global_rotation
		
	# No scale tweening cause that's hard AF for some reason
	# https://godotengine.org/qa/104034/how-to-get-global-scale-of-a-spatial-node
