class_name HUD
extends PanelContainer

@onready var building_mode: BuildingMode = %BuildingMode
@onready var building_menu: BuildingMenu = %BuildingMenu
@onready var buildings_list: BuildingsList = %BuildingsList

func _ready() -> void:
	GameFactory.hud = self
