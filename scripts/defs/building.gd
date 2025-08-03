class_name Building
extends Resource

@export var name: String
@export_multiline var description: String

@export_category("Tilemap")
@export var tileset_id: int
@export var tileset_tile_id: int

@export_category("$$$")
@export var currency: GlobalEnums.Currency = GlobalEnums.Currency.MONEY
@export var price: float = 0.0

@export_category("Offset")
@export var tile_sprite_offset: Vector2

var tile_position: Vector2i

static func load_from_resources_folder(path: String) -> Array[Building]:
	var files: PackedStringArray = DirAccess.get_files_at(path)
	var buildings: Array[Building] = []
	for file in files:
		if file.ends_with(".tres"):
			var building: Building = load(path + "/" + file)
			buildings.append(building)
	return buildings
