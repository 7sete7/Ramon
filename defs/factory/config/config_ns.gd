class_name ConfigNS
extends RefCounted

var size: Vector2i
var half: Vector2i
var limits: ConfigLimits

static func from(_size: Vector2i):
	var config_ns = new()
	
	config_ns.size = _size
	config_ns.half = _size / 2
	
	config_ns.limits = ConfigLimits.from(
		- config_ns.half.x,
		config_ns.half.x,
		- config_ns.half.y,
		config_ns.half.y
	)
	
	return config_ns
