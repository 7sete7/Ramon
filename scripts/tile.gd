class_name Tile
extends RefCounted

var center_position: Vector2i
var tilemap_position: Vector2i

var id: String
var tile_size: Vector2i
var tile_type_str: String = "Blank"

var tile_type: FactoryGrid.TILES:
	set(value):
		tile_type = value
		match self.tile_type:
			FactoryGrid.TILES.DEFAULT:
				self.tile_type_str = "Blank"
			FactoryGrid.TILES.GREEN:
				self.tile_type_str = "Green"
			FactoryGrid.TILES.RED:
				self.tile_type_str = "Red"
			FactoryGrid.TILES.YELLOW:
				self.tile_type_str = "Yellow"
			_:
				self.tile_type_str = "Vish"

func _init(tilemap_pos: Vector2i, type: FactoryGrid.TILES, tile_sizes: Vector2i):
	self.tile_type = type
	self.tile_size = tile_sizes
	
	self.tilemap_position = tilemap_pos
	self.center_position = tilemap_position * tile_size + (tile_size / 2)
	self.id = "%v" % self.center_position
	
