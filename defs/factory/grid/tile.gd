class_name Tile
extends RefCounted

var center_position: Vector2i
var tilemap_position: Vector2i

var id: String
var tile_size: Vector2i
var tile_type_str: String = "Blank"

var building: Building
var bounds: ConfigLimits

var tile_type: FactoryEnums.TILES:
	set(value):
		tile_type = value
		match self.tile_type:
			FactoryEnums.TILES.DEFAULT:
				self.tile_type_str = "Blank"
			FactoryEnums.TILES.GREEN:
				self.tile_type_str = "Green"
			FactoryEnums.TILES.RED:
				self.tile_type_str = "Red"
			FactoryEnums.TILES.YELLOW:
				self.tile_type_str = "Yellow"
			_:
				self.tile_type_str = "Vish"

func _init(tilemap_pos: Vector2i, type: FactoryEnums.TILES, tile_sizes: Vector2i):
	var half_tile: Vector2i = tile_sizes / 2
	self.tile_type = type
	self.tile_size = tile_sizes
	
	self.tilemap_position = tilemap_pos
	self.center_position = tilemap_position * tile_size + half_tile
	self.id = "%v" % self.tilemap_position
	
	self.bounds = ConfigLimits.from(
		center_position.x - half_tile.x,
		center_position.x + half_tile.x,
		center_position.y - half_tile.y,
		center_position.y + half_tile.y
	)
