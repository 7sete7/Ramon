class_name BuildingSectionButton
extends TextureButton

@export var ID: FactoryEnums.BUILDING_SECTIONS
@export var section_name: String
# var _buildings: Dictionary[String, Building] = {}

func _ready() -> void:
	self.tooltip_text = self.section_name

# func add_building_if_hasnt(building: Building) -> void:
# 	self._buildings[building.ID] = building
