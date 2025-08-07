class_name BuildingManager
extends Node2D

var resources: Dictionary[String, BuildingResource] = {}
var building_classes: Dictionary[String, GDScript] = {}
var sections: Dictionary[String, Array] = {}

#@onready var building_menu: BuildingMenu = $"../CanvasLayer/HUD/BuildingMenu"
func _ready() -> void:
	self.register_building("prod", FactoryMine)
	self.register_building("misc", FactoryBelt)


func register_building(section_id: String, building_class: GDScript) -> void:
	# Create temporary instance to get resource location
	var temp_instance: Building = building_class.new()
	if not temp_instance is Building:
		push_error("Class must extend Building")
		return
	
	var resource_path = building_class.get_resource_location()
	var resource: BuildingResource = load(resource_path)
	
	# Store the class for later instantiation
	self.building_classes[resource.ID] = building_class
	self.resources[resource.ID] = resource
	
	# Add to section
	var section_array = self.sections.get_or_add(section_id, [])
	section_array.append(resource.ID)
	

func get_building(building_id: String) -> Building:
	if not self.building_classes.has(building_id):
		push_error("Building ID not found: " + building_id)
		return null
	
	var building_class: GDScript = self.building_classes[building_id]
	var resource: BuildingResource = self.resources[building_id]
	
	var building_instance: Building = building_class.new()
	building_instance.load_from_resource(resource)
	return building_instance
