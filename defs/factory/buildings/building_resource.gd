class_name BuildingResource
extends Resource

#General
@export_category("General")
@export var ID: String
@export var name: String
@export_multiline var description: String
@export var texture: Texture2D

#Tilemap
@export_category("Tilemap")
@export var tileset_id: int
@export var tileset_tile_id: int

#Economy
@export_category("Economy")
@export var currency: FactoryEnums.Currency = FactoryEnums.Currency.MONEY
@export var price: float = 0.0

#Offset
@export_category("Offset")
@export var tile_sprite_offset: Vector2
