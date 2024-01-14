extends Node2D

var markerScene = preload("res://assets/marker.tscn")
var endMarkerY


func _on_in_game_manager_generate_marker(pos: Vector2, color: Color, isStart: bool):
    """
    boardMap에 따라 마커 생성
    """
    var marker = markerScene.instantiate()
    marker.position = pos
    marker.startPos = pos
    marker.get_node("mesh").modulate = color
    if isStart:
        get_node("startManager").add_child(marker)
    else:
        endMarkerY = pos.y
        get_node("endManager").add_child(marker)


func _on_inGame_play_button_pressed():
    for marker in $startManager.get_children():
        marker.endPosY = endMarkerY
        marker.move_to(Vector2(marker.position.x, endMarkerY))
    






