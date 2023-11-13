@tool
extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not Engine.is_editor_hint():
		var coll := CollisionPolygon2D.new()
		coll.polygon = $Polygon2D.polygon
		coll.global_position = $Polygon2D.global_position
		coll.scale = $Polygon2D.scale
		add_child(coll)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Engine.is_editor_hint():
		$Line2D.global_position = $Polygon2D.global_position
		$Line2D.scale = $Polygon2D.scale
		var points := PackedVector2Array($Polygon2D.polygon)
		points.append($Polygon2D.polygon[0])
		$Line2D.points = points
