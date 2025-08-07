extends Label

@onready var hud: HUD = owner
var process_timer := 0.0
var process_interval := 0.1 # Process every 0.1 seconds (10 times per second)

var current_tile: Tile
var enabled = false

func _ready() -> void:
	if hud.grid:
		hud.grid.tile_type_changed.connect(func(_value): self.update_label())
		enabled = true

func _process(delta: float) -> void:
	process_timer += delta
	if not enabled or process_timer < process_interval:
		return
	
	process_timer = 0.0
	
	var mouse_pos := hud.grid.tile_map.local_to_map(hud.grid.tile_map.get_local_mouse_position())
	
	var tile := hud.grid.get_tile_at(mouse_pos)
	if tile != current_tile:
		current_tile = tile
		self.update_label()
		
func update_label() -> void:
	if current_tile:
		self.text = "{pos} {type} {building}".format({
			"pos": current_tile.tilemap_position,
			"type": current_tile.tile_type_str,
			"building": "\n" + current_tile.building.name if current_tile.building else ""
		})
	else:
		self.text = "(øø, øø)"
