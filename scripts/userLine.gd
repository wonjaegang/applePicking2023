extends Area2D

var startVerticalNode
var endVerticalNode
var stickFlg = false


func setLineLength(length):
    """
    선 길이 설정, position 유지
    """
    $mesh.mesh.height = length
    $CollisionShape2D.shape.height = length
    
    $mesh.position.y = length / 2
    $CollisionShape2D.position.y = length / 2
    $lineEnd.position.y = length - $mesh.mesh.radius
    
    
func checkIsProper():
    """
    생성 가능한 라인인지 판단:
        - user/horizontal 미충돌
        - 수직선 2개와 충돌
    """
    for overlapping in get_overlapping_areas():
        if overlapping.get_parent().name == "horizontalLineManager":
            return false
        if overlapping.get_parent().name == "userLineManager":
            return false
    if stickFlg:
        return true
    else:
        return false
        
        
func _on_area_entered(area):
    """
    새로운 수직선과 충돌시 stick
    """
    print(area.get_parent())
    if area.get_parent().name == "verticalLineManager":
        if area != startVerticalNode:
            stickFlg = true
            endVerticalNode = area


func _on_input_event(viewport, event, shape_idx):
    """
     선 클릭 시 삭제
    """
    if event.is_pressed():
        queue_free()


















