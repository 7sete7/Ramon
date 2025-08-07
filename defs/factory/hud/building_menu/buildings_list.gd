class_name BuildingsList
extends GridContainer

var menu_building_scene := preload("res://defs/factory/hud/building_menu/building.tscn")
@onready var building_manager: BuildingManager = get_tree().get_first_node_in_group("building manager")

var _current_section: String
var buildings: Array[Building] = []

func _ready() -> void:
	pass
	
func display_buildings(section_id: String, force_refresh: bool = false):
	if not force_refresh and _current_section == section_id: return

	var building_ids = building_manager.sections.get(section_id, [])
	if not len(building_ids):
		push_warning("No buildings registered for section " + section_id)
		self.reset_list()
		return
	
	self.reset_list()
	for building_id in building_ids:
		var menu_building: MenuBuilding = menu_building_scene.instantiate()
		menu_building.resource = building_manager.resources.get(building_id)
		
		self.add_child(menu_building)
	
	
func reset_list():
	self.buildings = []
	for child in get_children():
		child.queue_free()
