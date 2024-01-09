extends Node2D

var verticalLineScene = preload("res://assets/verticalLine.tscn")


func _on_in_game_manager_generate_vertical_line(pos, color):
    var verticalLine = verticalLineScene.instantiate()
    verticalLine.position = pos
    verticalLine.get_node("mesh").modulate = color
    add_child(verticalLine)
