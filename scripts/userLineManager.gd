extends Node2D

var userLineScene = preload("res://assets/userLine.tscn")

var generatingLine = false
var generatingFrom = ""

func _vertical_line_pressed(verticalLineNode):
    var userLine = userLineScene.instantiate()
    userLine.position.x = verticalLineNode.position.x
    userLine.position.y = get_viewport().get_mouse_position().y
    userLine.get_child(0).mesh.height = 10
    print(userLine.get_child(0).mesh.height)
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
            newline.get_child(0).mesh.height = diff.length()
        else:
            if newline.proper:
                pass
            else:
                remove_child(newline)
            generatingLine = false

    
    
    
    
    
    
