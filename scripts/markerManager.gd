extends Node2D

var markerScene = preload("res://assets/marker.tscn")
var endMarkerY
var isPlaying = false
var arrivedMarkerNum = 0
var correctMarkerNum = 0

signal levelCompleted


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
        # 종료 마커 처음 생성 시 markerGoal 위치 지정
        if endMarkerY == null:
            endMarkerY = pos.y
            $markerGoal.position.y = endMarkerY + marker.get_node("mesh").mesh.radius * 2
            $markerGoal/CollisionShape2D.shape.size.y = marker.get_node("mesh").mesh.radius * 2
        get_node("endManager").add_child(marker)


func resetMarkers():
    isPlaying = false
    arrivedMarkerNum = 0
    correctMarkerNum = 0
    for marker in $startManager.get_children():
        marker.isCorrect = false
        marker.onVertical = true
        marker.position = marker.startPos
        marker.tween.kill()
    await get_tree().create_timer(0.05).timeout

func _on_inGame_play_button_pressed():
    # 시작 마커 아래로 이동 시작
    if not isPlaying:
        isPlaying = true
        for marker in $startManager.get_children():
            marker.endPosY = endMarkerY
            marker.dropMarker()
    
    # 시작마커 이동 중지, 초기위치로 이동
    else:
        resetMarkers()
    

func _on_marker_goal_area_entered(area):    
    if area.get_parent().name == "startManager":
        # 시작 마커 도착 수/정답 수 확인
        arrivedMarkerNum += 1
        if area.isCorrect: 
            correctMarkerNum += 1
            print("marker Glow!")
        else:
            print("marker off")
        
        # 오답/정답 판단
        if arrivedMarkerNum == $startManager.get_child_count():
            if correctMarkerNum == arrivedMarkerNum:
                print("right answer!")
                emit_signal("levelCompleted")
            else:
                print("wrong answer!")
                print("return markers to initial point")
                resetMarkers()
                $"../inGamePlayButton".flipState()










