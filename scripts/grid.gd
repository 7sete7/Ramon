class_name FactoryGrid
extends Node2D

@onready var buildings: Array[Building] = Building.load_from_resources_folder("res://assets/buildings")
@onready var tile_map: FactoryTileMap = $TileMapLayer
@onready var building_map_layer: FactoryTileMap = $BuildingMapLayer
@export var config: GridConfig


var grid_sizes: GridSizes

var map_builder: MapBuilder

var GRID: Dictionary = {}
var GRID_BY_MAP_POS: Dictionary = {}

enum TILES {
	DEFAULT = 0,
	GREEN = 4,
	RED = 5,
	YELLOW = 6
}

signal tile_type_changed(new_type)

func _ready() -> void:
	if not config:
		config = GridConfig.new()
	
	grid_sizes = GridSizes.from(config)
	
	self.init_tiles()

	self.map_builder = MapBuilder.new(self)
	self.map_builder.build_ores()
	

func set_tile_at(tilemap_position: Vector2i, new_tile: TILES) -> void:
	var tile := self.get_tile_at(tilemap_position)

	if not tile:
		tile = Tile.new(tilemap_position, new_tile, self.grid_sizes.tile.size)
		GRID[tilemap_position] = tile

	GRID[tilemap_position].tile_type = new_tile
	
	tile_map.change_tile(tilemap_position, new_tile)
	tile_type_changed.emit(new_tile)
	
func get_tile_at(tilemap_position: Vector2i) -> Tile:
	return GRID.get(tilemap_position, null)

func init_tiles() -> void:
	for x in range(grid_sizes.by_grid.limits.left, grid_sizes.by_grid.limits.right + 1):
		for y in range(grid_sizes.by_grid.limits.top, grid_sizes.by_grid.limits.bottom + 1):
			self.set_tile_at(Vector2i(x, y), TILES.DEFAULT)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("click"):
		var local_mouse_pos := self.get_local_mouse_position()
		var local_int := self.tile_map.local_to_map(local_mouse_pos)
	
		var tile = self.get_tile_at(local_int)
		if tile:
			self.set_building_at(tile, self.buildings[0])
		
func is_in_grid(pos: Vector2):
	return not (pos.x < grid_sizes.by_px.limits.left or pos.y < grid_sizes.by_px.limits.top or pos.x >= grid_sizes.by_px.limits.right or pos.y >= grid_sizes.by_px.limits.bottom)

func set_building_at(tile: Tile, building: Building) -> void:
	building_map_layer.set_cell(tile.tilemap_position, building.tileset_id, Vector2i(0, 0), building.tileset_tile_id)
	tile.building = building
