extends Area2D

const SPEED = 400
var tween
var startPos
var endPosY
var isCorrect = false
var onVertical = true
var lastLine = null


func move_to(destination: Vector2):
    """
    현재 이동을 종료하고 목표 지점(global position)으로 이동
    """
    if tween:
        tween.kill()
    tween = create_tween()
    var duration = (destination - position).length() / SPEED
    tween.tween_property(self, "position", destination, duration)        


func moveAlongLine(lineStart: Vector2, lineEnd: Vector2):
    """
    수평선을 타고 이동 후 다시 하강.
    lineStart로 먼저 이동 후 lineEnd로 이동.
    """
    onVertical = false
    
    move_to(lineStart)
    await tween.finished
    
    move_to(lineEnd)                
    await tween.finished
    
    onVertical = true
    move_to(Vector2(position.x, endPosY))
    
    # 이동 중 충돌 시그널이 이미 start/end area 처리
    for area in get_overlapping_areas():
        _on_area_entered(area)


func _on_area_entered(area):
    # 수직선 위에서 새 수평선의 start/end 에 닿았을 때
    if area.name == "startArea" or area.name == "endArea":
        if not onVertical or area.global_position.y <= position.y:
            return
        var lineStart = area.global_position
        var lineEnd = Vector2.ZERO
        if area.name == "startArea":
            lineEnd = area.get_parent().get_node("endArea").global_position
        else:
            lineEnd = area.get_parent().get_node("startArea").global_position
        moveAlongLine(lineStart, lineEnd)
        
    # end 마커와 닿았을 때
    elif area.get_parent().name == "endManager":
        if area.get_node("mesh").modulate == $mesh.modulate:
            isCorrect = true
    
    
    
    
    
    
    
    
    
    
    
    
    
    
        








