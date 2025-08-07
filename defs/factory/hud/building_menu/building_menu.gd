class_name BuildingMenu
extends HBoxContainer

@onready var building_sections_grid: GridContainer = $BuildingSections
@onready var buildings_container: PanelContainer = $BuildingsContainer
@onready var buildings_list: BuildingsList = $%BuildingsList

var sections_btn_group: ButtonGroup
var sections: Dictionary[String, BuildingSectionButton] = {}

func _ready() -> void:
	var section_btns = building_sections_grid.get_children()
	for btn: BuildingSectionButton in section_btns: self.sections[btn.ID] = btn
	
	self.sections_btn_group = section_btns[0].button_group
	self.sections_btn_group.pressed.connect(self.on_btn_toggle)

func add_building_to(section_id: String, building: Building) -> void:
	var section := self.sections[section_id]
	if not section:
		push_error("Section not found %s" % section_id)
		return
	
	section.add_building_if_hasnt(building)

func on_btn_toggle(btn: BuildingSectionButton) -> void:
	var pressed_btn: BuildingSectionButton = sections_btn_group.get_pressed_button()
	
	buildings_container.visible = pressed_btn != null
	
	if pressed_btn != null:
		buildings_list.display_buildings(pressed_btn.ID)
		
