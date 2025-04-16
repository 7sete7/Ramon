extends Label

@onready var hud: HUD = get_node("/root/Factory/CanvasLayer/HUD")
var process_timer := 0.0
var process_interval := 0.1 # Process every 0.1 seconds (10 times per second)

var current_tile: Tile

func _ready() -> void:
	hud.grid.tile_type_changed.connect(func (_value): self.update_label())

func _process(delta: float) -> void:
	process_timer += delta
	if process_timer < process_interval:
		return
	
	process_timer = 0.0
	
	var mouse_pos := get_global_mouse_position()
	var int_pos := Vector2i(int(mouse_pos.x), int(mouse_pos.y))
	
	var tile := hud.grid.get_tile_at(int_pos)
	if tile and tile != current_tile:
		current_tile = tile
		self.update_label()
		
func update_label() -> void:
	self.text = "{pos} {type}".format({ 
		"pos": current_tile.tilemap_position, 
		"type": current_tile.tile_type_str 
	})
