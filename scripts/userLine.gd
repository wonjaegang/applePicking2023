extends Area2D

var collideVerticalCount = 0
var collideHorizontalCount = 0
var proper = true

var stickVerticalFlg = false
var stickVerticalNode = Node2D


func _on_area_entered(area):
    var nodeName = area.get_parent().name
    if nodeName == "verticalLineManager":
        collideVerticalCount += 1
    if nodeName == "horizontalLineManager" or nodeName == "userLineManager":
        collideHorizontalCount += 1
    checkIsProper()


func _on_area_exited(area):
    var nodeName = area.get_parent().name
    if nodeName == "verticalLineManager":
        collideVerticalCount -= 1
    if nodeName == "horizontalLineManager" or nodeName == "userLineManager":
        collideHorizontalCount -= 1
    checkIsProper()


func checkIsProper():
    """
    생성 가능한 라인인지 판단
    """
    if collideHorizontalCount == 0 and collideVerticalCount == 2:
        proper = true
    else:
        proper = false
        
        
func setLineLength(length):
    """
    선 길이 설정, position 유지
    """
    $mesh.mesh.height = length
    $CollisionShape2D.shape.height = length
    
    $mesh.position.y = length / 2
    $CollisionShape2D.position.y = length / 2
    $lineEnd.position.y = length - $mesh.mesh.radius


func _end_area_entered(area):
    if area.get_parent().name == "verticalLineManager":
        stickVerticalFlg = true
        stickVerticalNode = area
