extends Node2D

# 추후 game manager 에서 관리
const Y_MIN = 300 + 10 * 3
const Y_MAX = 300 + 700 - 10 * 3

var userLineScene = preload("res://assets/horizontalLine.tscn")
var userLineMinH

var generatingLine = false

func _vertical_line_pressed(verticalLineNode):
    """
    userLine 생성하여 출력
    """
    generatingLine = true
    
    var userLine = userLineScene.instantiate()
    userLineMinH = userLine.get_node("mesh").mesh.radius * 2
    
    userLine.isUserLine = true
    userLine.startVerticalNode = verticalLineNode
    userLine.position.x = verticalLineNode.position.x
    userLine.position.y = max(min(get_viewport().get_mouse_position().y, Y_MAX), Y_MIN)
    userLine.setLineLength(userLineMinH)
    add_child(userLine)
                
                                                                                        
func _process(delta):
    if generatingLine:
        setGeneratingUserLine()     
          

func setGeneratingUserLine():
    """
    터치/드래그로 생성중인 userLine 위치조정 및 생성/삭제
    """
    var newline = get_child(-1)
    
    # 터치 중에는 마우스 포인터의 위치를 따라 선 이동
    if Input.is_mouse_button_pressed(1):
        var end = get_viewport().get_mouse_position()
        # 수직선에 닿았을 때
        if newline.endVerticalNode:
            end.x = newline.endVerticalNode.position.x
            newline.stickFlg = true
        # 위/아래 경계선 내로 지정
        end.y = max(min(end.y, Y_MAX), Y_MIN)
        
        var diff = end - newline.position
        newline.rotation = atan2(diff.y, diff.x) - PI/2
        if diff.length() > userLineMinH:
            newline.setLineLength(diff.length())
            
    # 터치 종료시 생성 또는 삭제
    else:
        generatingLine = false
        if not newline.checkIsProper():
            newline.queue_free()
