class_name FactoryTileMap
extends TileMapLayer

func change_tile(tile_pos: Vector2i, tile_id: FactoryGrid.TILES, _local_to_map: bool = false):
	if _local_to_map:
		tile_pos = local_to_map(tile_pos)
	self.set_cell(tile_pos, tile_id, Vector2i(0, 0), 0)
	
