extends Node2D

var markerScene = preload("res://assets/marker.tscn")


func _on_in_game_manager_generate_marker(pos, color, isStart):
    var marker = markerScene.instantiate()
    marker.position = pos
    marker.modulate = color
    if isStart:
        pass
    else:
        pass
                        
                        
                                                                        
