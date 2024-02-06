extends Node2D

var verticalLineScene = preload("res://assets/verticalLine.tscn")


func generateLine(pos: Vector2, color: Color):
    var verticalLine = verticalLineScene.instantiate()
    add_child(verticalLine)
    verticalLine.position = pos
    verticalLine.get_node("mesh").modulate = color
