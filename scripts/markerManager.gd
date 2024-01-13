extends Node2D

var markerScene = preload("res://assets/marker.tscn")


func _on_in_game_manager_generate_marker(pos: Vector2, color: Color, isStart: bool):
    """
    boardMap에 따라 마커 생성
    """
    var marker = markerScene.instantiate()
    marker.position = pos
    marker.get_node("mesh").modulate = color
    if isStart:
        get_node("startManager").add_child(marker)
    else:
        get_node("endManager").add_child(marker)


func _on_inGame_play_button_pressed():
    var viewportHeight = get_viewport_rect().size[1]
    for marker in $startManager.get_children():
        marker.move_to(marker.position + Vector2(0, viewportHeight))
    






