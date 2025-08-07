class_name FactoryBelt
extends Building

func _init() -> void:
	super ()

static func get_resource_location() -> String:
	return "res://defs/factory/buildings/belt/belt_resource.tres"

func should_place(tilemap_position: Vector2i) -> bool:
	return false
	
func on_placed() -> void:
	pass
	
func on_tick() -> void:
	pass
