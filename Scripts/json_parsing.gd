class_name JSONParsing
extends Object

static func parse_Vector2i(string: String) -> Vector2i:
	var values = string.split(" ")
	var x = values[0]
	var y = values[1]
	
	return Vector2i(int(x), int(y))

static func stringify_Vector2(coords) -> String: 
	return "%s %s" % [coords.x, coords.y]
