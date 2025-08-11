class_name BuildingMode
extends PanelContainer

var is_active: bool = false
	
var current_building: Building = null:
	set(value):
		current_building = value
		self.is_active = value != null
		self.visible = self.is_active

func _gui_input(event: InputEvent) -> void:
	if not self.is_active: return

	if event is InputEventMouseButton:
		self.handle_mouse_btn_event(event)
	elif event is InputEventKey:
		self.handle_key_event(event)

func handle_mouse_btn_event(event: InputEventMouseButton):
	var mouse_pos: Vector2i = GameFactory.grid.get_position_under_mouse()
	
	if event.is_action_pressed("click"):
		GameFactory.building_manager.try_place_building_at(mouse_pos, self.current_building.ID)

func handle_key_event(event: InputEventKey):
	if event.is_action_pressed("cancel"):
			GameFactory.building_manager.toggle_building_mode_with(null)
