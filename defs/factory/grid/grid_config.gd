class_name GridConfig
extends Resource

@export_group("Grid")
@export var map_width: int = 20
@export var map_height: int = 15

@export_group("Ores")
@export_range(0, 100, 1.0, "suffix:%") var map_ore_coverage: int = 33
@export var min_ore_per_clump: int = 3
@export var max_ore_per_clump: int = 14

@export_group("Tile Size", "tile_")
@export var tile_width: int = 16
@export var tile_height: int = 16
