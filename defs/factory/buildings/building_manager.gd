class_name BuildingManager
extends Node2D

var resources: Dictionary[String, BuildingResource] = {}
var building_classes: Dictionary[String, GDScript] = {}
var sections: Dictionary[FactoryEnums.BUILDING_SECTIONS, Array] = {}

func _ready() -> void:
	GameFactory.building_manager = self
	self.register_building(FactoryEnums.BUILDING_SECTIONS.PRODUCTION, FactoryMine)
	self.register_building(FactoryEnums.BUILDING_SECTIONS.PRODUCTION, FactoryBelt)

func register_building(section_id: FactoryEnums.BUILDING_SECTIONS, building_class: GDScript) -> void:
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

func toggle_building_mode_with(building: Building):
	GameFactory.hud.building_mode.current_building = building
	GameFactory.hud.buildings_list.update_displays_with(building)
