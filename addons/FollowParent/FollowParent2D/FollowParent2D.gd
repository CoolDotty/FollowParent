@tool
@icon("res://addons/FollowParent/FollowParent2D/icon.svg")
extends Node2D
class_name FollowParent2D

@export_category("FollowParent2D")
@export var lerp_speed: float = 20.0
@export_range(0, 128, 0.1, "suffix:px") var position_snap: float = 1.0
@export_range(0, 360, 0.1, "degrees") var rotational_snap: float = 1.0
@export_range(0, 1, 0.01) var scale_snap: float = 0.01


func _ready():
	top_level = true


func _process(delta):
	var parent = get_parent()
	if not is_instance_valid(parent):
		return
		
	global_position = global_position.lerp(parent.global_position, delta * lerp_speed)
	if global_position.distance_to(parent.global_position) < position_snap:
		global_position = parent.global_position
	
	global_rotation = lerp(global_rotation, parent.global_rotation, delta * lerp_speed)
	if abs(parent.global_rotation - global_rotation) < rotational_snap:
		global_rotation = parent.global_rotation
	
	global_scale = global_scale.lerp(parent.global_scale, delta * lerp_speed)
	if global_scale.distance_to(parent.global_scale) < position_snap:
		global_scale = parent.global_scale
