extends Node

var _items: Dictionary[String, PackedScene] = {}

func load_items() -> void:
	const items_folder: String = "res://defs/factory/items"
	for file in DirAccess.get_files_at(items_folder):
		if file.ends_with(".tscn"):
			var scene: PackedScene = load(items_folder + "/" + file)
			var item: Item = scene.instantiate()
			self._items[item.ID] = scene
			item.queue_free()

func get_item(item_id: String) -> Item:
	var scene: PackedScene = self._items.get(item_id)
	return scene.instantiate() if scene else null
