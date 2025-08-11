class_name Factory
extends Node2D

var building_manager: BuildingManager
var grid: FactoryGrid
var hud: HUD

func _ready() -> void:
	TickManager.start()
	ItemManager.load_items()
