class_name FactoryGrid
extends Node2D

@onready var tile_map: FactoryTileMap = $TileMapLayer
@onready var building_map_layer: FactoryTileMap = $BuildingMapLayer
@export var config: GridConfig
 
var grid_sizes: GridSizes
var map_builder: MapBuilder
var GRID: Dictionary = {}

func _ready() -> void:
	GameFactory.grid = self

	if not config:
		config = GridConfig.new()
	
	grid_sizes = GridSizes.from(config)
	
	self.init_tiles()
	TickManager.start()

	self.map_builder = MapBuilder.new(self)
	self.map_builder.build_ores()
	

func set_tile_at(tilemap_position: Vector2i, new_tile: FactoryEnums.TILES) -> void:
	var tile := self.get_tile_at(tilemap_position)

	if not tile:
		tile = Tile.new(tilemap_position, new_tile, self.grid_sizes.tile.size)
		GRID[tilemap_position] = tile

	GRID[tilemap_position].tile_type = new_tile
	
	tile_map.change_tile(tilemap_position, new_tile)
	Events.from_factory.tile_changed.emit(tile)
	
func get_tile_at(tilemap_position: Vector2i) -> Tile:
	return GRID.get(tilemap_position, null)

func init_tiles() -> void:
	for x in range(grid_sizes.by_grid.limits.left, grid_sizes.by_grid.limits.right + 1):
		for y in range(grid_sizes.by_grid.limits.top, grid_sizes.by_grid.limits.bottom + 1):
			self.set_tile_at(Vector2i(x, y), FactoryEnums.TILES.DEFAULT)

func ss_process(_delta: float) -> void:
	if Input.is_action_just_pressed("click"):	
		var tile = self.get_tile_at(self.get_position_under_mouse())
		if tile:
			self.set_building_at(tile, GameFactory.building_manager.get_building("mine"))
		
func is_in_grid(pos: Vector2):
	return not (pos.x < grid_sizes.by_px.limits.left or pos.y < grid_sizes.by_px.limits.top or pos.x >= grid_sizes.by_px.limits.right or pos.y >= grid_sizes.by_px.limits.bottom)

func set_building_at(tile: Tile, building: Building) -> void:
	building_map_layer.set_cell(tile.tilemap_position, building.tileset_id, Vector2i(0, 0), building.tileset_tile_id)
	tile.building = building
	building.tilemap_position = tile.tilemap_position

func get_position_under_mouse() -> Vector2i:
	var local_mouse_pos := self.get_local_mouse_position()
	return self.tile_map.local_to_map(local_mouse_pos)
