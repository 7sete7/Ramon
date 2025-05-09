class_name FactoryGrid
extends Node2D

@onready var tile_map: FactoryTileMap = $TileMapLayer
@onready var camera: Camera2D = $"../Camera2D"

@export var MAP_W: int = 20
@export var MAP_H: int = 15

var tile_size: Vector2i = Vector2i.ZERO
var HALF_TILE: Vector2 = Vector2.ZERO

var grid_size: Vector2i = Vector2i.ZERO
var GRID: Dictionary = {}

var MAP_LIMITS := {"left": 0, "right": 0, "top": 0, "bottom": 0}

enum TILES {
	DEFAULT = 0,
	GREEN = 4,
	RED = 5,
	YELLOW = 6
}

signal tile_type_changed(new_type)

func _ready() -> void:
	tile_size = tile_map.tile_set.tile_size
	HALF_TILE = tile_size / 2
	grid_size = Vector2i(MAP_W * tile_size.x, MAP_H * tile_size.y)
	var half_grid_size: Vector2i = grid_size / 2
	MAP_LIMITS = {"left": - half_grid_size.x, "right": half_grid_size.x, "top": - half_grid_size.y, "bottom": half_grid_size.y}
	self.init_tiles()
	

func set_tile_at(pos: Vector2i, new_tile: TILES) -> void:
	if not is_in_grid(pos): return

	var tile := self.get_tile_at(pos)
	if not tile:
		var tilemap_position = tile_map.local_to_map(pos)
		tile = Tile.new(tilemap_position, new_tile, self.tile_size)
		GRID[tile.center_position] = tile
	
	GRID[tile.center_position].tile_type = new_tile
	tile_map.change_tile(pos, new_tile, true)
	tile_type_changed.emit(new_tile)
	
func get_tile_at(pos: Vector2i) -> Tile:
	if not is_in_grid(pos): return null

	var nearest_center_pos: Vector2i = Vector2i(HALF_TILE + Vector2(pos / tile_size).floor() * Vector2(tile_size))
	var tile: Tile = GRID.get(nearest_center_pos, null)

	return tile

func init_tiles() -> void:
	var HALF_W: int = MAP_W / 2
	var HALF_H: int = MAP_H / 2
	for x in range(-HALF_W, HALF_W):
		for y in range(-HALF_H, HALF_H):
			var pos := Vector2i(x * tile_size.x + 1, y * tile_size.y + 1)
			self.set_tile_at(pos, TILES.DEFAULT)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("click"):
		var local_mouse_pos := self.get_local_mouse_position()
		var local_int := Vector2i(int(local_mouse_pos.x), int(local_mouse_pos.y))
	
		self.set_tile_at(local_int, TILES.RED)
		
func is_in_grid(pos: Vector2):
	return not (pos.x < MAP_LIMITS.left or pos.y < MAP_LIMITS.top or pos.x >= MAP_LIMITS.right or pos.y >= MAP_LIMITS.bottom)
