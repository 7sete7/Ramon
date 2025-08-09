extends Node
#class_name Events
# Class loaded globally as a Singleton (Project > Project Settings > Globals)

var from_factory: FactoryEvents = FactoryEvents.new()

class FactoryEvents:
	signal tile_changed(newTile: Tile)
	signal building_added(building: Building)
