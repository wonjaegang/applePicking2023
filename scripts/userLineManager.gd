extends Node2D

var userLineScene = preload("res://assets/userLine.tscn")
var userLineMinH = 0

var generatingLine = false
var generatingFrom = ""

func _vertical_line_pressed(verticalLineNode):
    var userLine = userLineScene.instantiate()
    userLineMinH = userLine.get_child(0).mesh.radius * 2
    
    userLine.position.x = verticalLineNode.position.x
    userLine.position.y = get_viewport().get_mouse_position().y
    userLine.get_child(0).mesh.height = userLineMinH
    userLine.get_child(1).shape.height = userLineMinH
    userLine.changePositionByHeight()
    add_child(userLine)
    
    generatingLine = true
    generatingFrom = verticalLineNode
                
                                                                                        
func _process(delta):
    if generatingLine:
        var newline = get_child(-1)
        if Input.is_mouse_button_pressed(1):
            var end = get_viewport().get_mouse_position()
            # 수직선에 닿았을 때
            if 0:
                end.x = 0
            # 다른 선에 닿았을 때
            if 0:
                end.y = 0
            var diff = end - newline.position
            newline.rotation = atan2(diff.y, diff.x) - PI/2
            if diff.length() > userLineMinH:
                newline.get_child(0).mesh.height = diff.length()
                newline.get_child(1).shape.height = diff.length()
                newline.changePositionByHeight()
        else:
            if newline.proper:
                pass
            else:
                remove_child(newline)
            generatingLine = false

    
    
    
    
    
    
