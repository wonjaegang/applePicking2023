extends Area2D

var startVerticalNode
var endVerticalNode
var stickFlg = false


func setLineLength(length):
    """
    선 길이 설정, position 유지
    """
    var radius = 10
    $mesh.mesh.radius = radius
    $mesh.mesh.height = length
    
    $outerMesh.mesh.height = length + 0.5 * radius
    $outerMesh.mesh.radius = 1.25 * radius
    
    $CollisionShape2D.shape.radius = radius
    $CollisionShape2D.shape.height = length + 2 * radius
    
    var position_y = length / 2
    $mesh.position.y = position_y
    $outerMesh.position.y = position_y
    $CollisionShape2D.position.y = position_y    
    
    
func checkIsProper():
    """
    생성 가능한 라인인지 판단:
        - user/horizontal 미충돌
        - 수직선 2개와 충돌
        - 선의 끝이 수직선과 충돌
    """
    var verticalCount = 0
    for overlapping in get_overlapping_areas():
        if overlapping.get_parent().name == "horizontalLineManager":
            return false
        if overlapping.get_parent().name == "userLineManager":
            return false
        if overlapping.get_parent().name == "verticalLineManager":
            verticalCount += 1            
    if verticalCount != 2:
        return false
        
    if stickFlg:
        return true
    else:
        return false
        
        
func _on_area_entered(area):
    # 새로운 수직선과 충돌시 stick
    if area.get_parent().name == "verticalLineManager":
        if area != startVerticalNode:
            stickFlg = true
            endVerticalNode = area   
                     
    # 평행선/유저선과 충돌 시 충돌 가시화
    if area.get_parent().name == "horizontalLineManager":
        area.get_node("outerMesh").visible = true
        area.get_node("outerMesh").modulate = Color(1, 0, 0)
    if area.get_parent().name == "userLineManager":
        area.get_node("outerMesh").visible = true
        area.get_node("outerMesh").modulate = Color(1, 0, 0)


func _on_area_exited(area):
    # 평행선/유저선과 충돌 종료 시 충돌 종료 가시화
    if area.get_parent().name == "horizontalLineManager":
        area.get_node("outerMesh").visible = false
        area.get_node("outerMesh").modulate = Color(1, 1, 1)        
    if area.get_parent().name == "userLineManager":
        area.get_node("outerMesh").visible = false
        area.get_node("outerMesh").modulate = Color(1, 1, 1)
    

func _on_input_event(viewport, event, shape_idx):
    """
     선 클릭 시 삭제
    """
    if event.is_pressed():
        queue_free()













