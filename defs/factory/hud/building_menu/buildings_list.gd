class_name BuildingsList
extends GridContainer

var _current_section: FactoryEnums.BUILDING_SECTIONS = -1
var buildings: Dictionary[String, MenuBuilding] = {}

var buildings_btn_group: ButtonGroup = ButtonGroup.new()
var current_selected: MenuBuilding

func _ready() -> void:
	self.buildings_btn_group.allow_unpress = true
	buildings_btn_group.pressed.connect(self.on_building_select)
	
func display_buildings(section_id: FactoryEnums.BUILDING_SECTIONS, force_refresh: bool = false):
	if not force_refresh and _current_section == section_id: return

	var building_ids = GameFactory.building_manager.sections.get(section_id, [])
	if not len(building_ids):
		push_warning("No buildings registered for section %s" % section_id)
		self.reset_list()
		return
	
	self.reset_list()
	for building_id in building_ids:
		var menu_building: MenuBuilding = Refs.menu_building_scene.instantiate()
		menu_building.resource = GameFactory.building_manager.resources.get(building_id)
		menu_building.btn_group = self.buildings_btn_group
		
		self.buildings[building_id] = menu_building
		self.add_child(menu_building)
	
	
func reset_list():
	self.buildings = {}
	for child in get_children():
		child.queue_free()

func on_building_select(btn: TextureButton):
	var menu_building: MenuBuilding = self.buildings.get(btn.name)
	menu_building.toggle_border(btn.button_pressed)

	var selected_building: Building
	if btn.button_pressed:
		selected_building = GameFactory.building_manager.get_building(btn.name)
		if self.current_selected: self.current_selected.toggle_border(false)

	self.current_selected = menu_building
	GameFactory.building_manager.toggle_building_mode_with(selected_building)
	
