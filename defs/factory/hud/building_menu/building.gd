class_name MenuBuilding
extends MarginContainer

@export var resource: BuildingResource
@onready var texture_btn: TextureButton = $TextureButton
@onready var price_lbl: Label = $Price
@onready var border: PanelContainer = $Border

var btn_group: ButtonGroup

func _ready() -> void:
	self.name = self.resource.name
	self.price_lbl.text = str(resource.price)
	
	self.texture_btn.toggle_mode = true
	self.texture_btn.name = self.resource.ID
	self.texture_btn.button_group = self.btn_group
	self.texture_btn.texture_normal = resource.texture

func toggle_border(on_off: bool) -> void:
	self.border.visible = on_off
