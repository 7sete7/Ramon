class_name FactoryGrid
extends Node2D

@onready var tile_map: FactoryTileMap = $TileMapLayer
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
	

func set_tile_at(pos: Vector2i, new_tile: TILES) -> void:
	if not is_in_grid(pos): return

	var tile := self.get_tile_at(pos)
	var tilemap_position = tile_map.local_to_map(pos)

	if not tile:
		tile = Tile.new(tilemap_position, new_tile, self.grid_sizes.tile.size)
		GRID[tile.center_position] = tile
		GRID_BY_MAP_POS[tilemap_position] = tile

	GRID[tile.center_position].tile_type = new_tile
	GRID_BY_MAP_POS[tilemap_position].tile_type = new_tile
	
	tile_map.change_tile(pos, new_tile, true)
	tile_type_changed.emit(new_tile)
	
func get_tile_at(pos: Vector2i, use_tile_map_coords: bool = false) -> Tile:
	if use_tile_map_coords:
		return GRID_BY_MAP_POS.get(pos, null)

	if not is_in_grid(pos): return null

	var nearest_center_pos: Vector2i = Vector2i(grid_sizes.tile.half + Vector2i(pos / grid_sizes.tile.size) * grid_sizes.tile.size)
	var tile: Tile = GRID.get(nearest_center_pos, null)

	return tile

# Fetch tiles by the index of the tile in the grid, as if it was a matrix
# The grid index grow from top to bottom, left to right
func get_tile_by_grid_index(index: Vector2i) -> Tile:
	return GRID_BY_MAP_POS.get(index, null)

func init_tiles() -> void:
	for x in range(-grid_sizes.by_grid.half.x, grid_sizes.by_grid.half.x):
		for y in range(-grid_sizes.by_grid.half.y, grid_sizes.by_grid.half.y):
			var pos := Vector2i(x * grid_sizes.tile.size.x + 1, y * grid_sizes.tile.size.y + 1)
			self.set_tile_at(pos, TILES.DEFAULT)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("click"):
		var local_mouse_pos := self.get_local_mouse_position()
		var local_int := Vector2i(int(local_mouse_pos.x), int(local_mouse_pos.y))
	
		self.set_tile_at(local_int, TILES.YELLOW)
		
func is_in_grid(pos: Vector2):
	return not (pos.x < grid_sizes.by_px.limits.left or pos.y < grid_sizes.by_px.limits.top or pos.x >= grid_sizes.by_px.limits.right or pos.y >= grid_sizes.by_px.limits.bottom)
