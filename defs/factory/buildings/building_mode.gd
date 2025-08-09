class_name BuildingMode
extends PanelContainer

var is_active: bool = false
	
var current_building: Building = null:
	set(value):
		current_building = value
		self.is_active = value != null
		self.visible = self.is_active
