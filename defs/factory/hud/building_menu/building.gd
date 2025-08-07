class_name MenuBuilding
extends MarginContainer

@export var resource: BuildingResource
@onready var texture: TextureRect = $Texture
@onready var price_lbl: Label = $Price

func _ready() -> void:
	texture.texture = resource.texture
	price_lbl.text = str(resource.price)
