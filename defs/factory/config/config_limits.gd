class_name ConfigLimits
extends RefCounted

var left: int
var top: int
var right: int
var bottom: int

static func from(l: int, r: int, t: int, b: int) -> ConfigLimits:
	var limits = new()
	
	limits.left = l
	limits.right = r
	limits.top = t
	limits.bottom = b
	
	return limits

func _to_string() -> String:
	return "l:{}, t:{}, r:{}, b:{}".format([left, top, right, bottom], "{}")
