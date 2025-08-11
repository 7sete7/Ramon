class_name FactoryBelt
extends Building

const MAX_ITEMS: int = 2
var inventory: Array[Item] = []

const SPRITE_OFFSET: Vector2i = Vector2i(2, 0)

func _init() -> void:
	super ()
	self._input = [Vector2i.LEFT]
	self._output = [Vector2i.RIGHT]

static func get_resource_location() -> String:
	return "res://defs/factory/buildings/belt/belt_resource.tres"

func can_place_at(tilemap_position: Vector2i) -> bool:
	var tile: Tile = GameFactory.grid.get_tile_at(tilemap_position)
	return tile.building == null
	
func on_placed(_tile: Tile) -> void:
	super(_tile)
	
func on_tick() -> void:
	pass

func push_item_to_output(output_side: Vector2i, item: Item) -> bool:
	var will_output = super.push_item_to_output(output_side, item)
	if will_output: self.inventory.erase(item)
	return will_output

func input_item_from_input(input_side: Vector2i, item: Item) -> bool:
	if len(self.inventory) >= self.MAX_ITEMS: return false
	var can_input: bool = super.input_item_from_input(input_side, item)
	if not can_input: return false
	
	item.position = Vector2i(
		self.tile.bounds.left + self.SPRITE_OFFSET.x, 
		self.tile.center_position.y + self.SPRITE_OFFSET.y
	)
	var final_pos: Vector2 = Vector2(
		self.tile.bounds.right,
		item.position.y
	)
	
	if not item.is_inside_tree():
		GameFactory.grid.add_child(item)

	self.inventory.append(item)
	print("Belt: item instantiated at {0} - bounds {1}".format([self.tile.tilemap_position, self.tile.bounds]))
	
	var tween: Tween = GameFactory.grid.create_tween()
	tween.tween_property(item, "position", final_pos, 2).from_current()
	tween.tween_callback(func(): self.push_item_to_output(Vector2i.RIGHT, item))
	return true
