class_name MapBuilder

@warning_ignore("integer_division")

var grid: FactoryGrid
var config: GridConfig

var rng: RandomNumberGenerator
var map_size: int = 0

func _init(_grid: FactoryGrid) -> void:
	self.grid = _grid
	self.config = _grid.config
	
	self.rng = RandomNumberGenerator.new()
	self.rng.seed = "leo".hash()

func build_ores() -> void:
	var ore_types = FactoryGrid.TILES.keys()
	ore_types.erase("DEFAULT")

	var max_ore_count: int = int(self.grid.grid_sizes.grid_size * self.config.map_ore_coverage / 100)
	var qtt_ores_per_type: int = max_ore_count / len(ore_types)

	for ore_type in ore_types:
		var remaining_ores: int = qtt_ores_per_type

		while remaining_ores > 0:
			var clump_size: int = rng.randi_range(config.min_ore_per_clump, config.max_ore_per_clump)
			clump_size = clamp(clump_size, config.min_ore_per_clump, remaining_ores)
			print(ore_type, " Remaining ores: ", remaining_ores, " Clump size: ", clump_size)
			remaining_ores -= spawn_ore_clump(FactoryGrid.TILES[ore_type], clump_size)


func spawn_ore_clump(ore_type: FactoryGrid.TILES, clump_size: int) -> int:
	# Pick a random starting tile index
	var grid_settings = grid.grid_sizes.by_grid
	var start_x := rng.randi_range(grid_settings.limits.left, grid_settings.limits.right)
	var start_y := rng.randi_range(grid_settings.limits.top, grid_settings.limits.bottom)
	var current_tile_pos := Vector2i(start_x, start_y)
	var current_tile = grid.get_tile_at(current_tile_pos)
	var clump: Array[Tile] = []


	var placed = 0
	while placed < clump_size:
		if current_tile:
			grid.set_tile_at(current_tile.tilemap_position, ore_type)
			clump.append(current_tile)
			placed += 1
		else:
			break
		
		# Get next tile using the last inserted tile on clump
		# If not found, backtrack trough all the clump till we find a valid next tile
		var clump_idx := clump.size()
		while clump_idx >= 0:
			clump_idx -= 1
			var tile := clump[clump_idx]
			
			current_tile = self.pick_next_tile_on_clump(tile.tilemap_position, ore_type)
			if current_tile:
				current_tile_pos = current_tile.tilemap_position
				break
		
	return placed

func pick_next_tile_on_clump(current_tile_pos: Vector2i, ore_type: FactoryGrid.TILES):
	# Directions: N, E, S, W
	var directions: Array[Vector2i] = [Vector2i(0, -1), Vector2i(1, 0), Vector2i(0, 1), Vector2i(-1, 0)]
	var new_dir_idx := rng.randi_range(0, directions.size() - 1)
	
	# Get random direction for next tile and try to return it
	# If not valid, iterate trough all the directions in order trying to get a free tile
	for i in range(0, directions.size() - 1):
		var direction_index := (new_dir_idx + i) % directions.size()
		var dir := directions[direction_index]
		var new_pos := current_tile_pos + dir
		
		var tile := grid.get_tile_at(new_pos)
		if tile != null and tile.tile_type != ore_type:
			return tile
