class_name GridSizes
extends RefCounted

var tile: ConfigNS
var by_px: ConfigNS
var by_grid: ConfigNS
var grid_size: int

static func from(grid_config: GridConfig) -> GridSizes:
	var grid_sizes = new()
	
	var tile_size := Vector2i(grid_config.tile_width, grid_config.tile_height)
	var grid_px_size := Vector2i(grid_config.map_width * tile_size.x, grid_config.map_height * tile_size.y)
	var _grid_size := Vector2i(grid_config.map_width, grid_config.map_height)
	
	grid_sizes.tile = ConfigNS.from(tile_size)
	grid_sizes.by_px = ConfigNS.from(grid_px_size)
	grid_sizes.by_grid = ConfigNS.from(_grid_size)
	grid_sizes.by_grid.limits.right -= 1
	grid_sizes.by_grid.limits.bottom -= 1
	
	grid_sizes.grid_size = _grid_size.x * _grid_size.y
	
	return grid_sizes
