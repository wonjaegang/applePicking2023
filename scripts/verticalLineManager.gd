extends Node2D

var verticalLineScene = preload("res://assets/verticalLine.tscn")


func _on_in_game_manager_generate_vertical_line(pos):
    var verticalLine = verticalLineScene.instantiate()
    verticalLine.position = pos
    add_child(verticalLine)
