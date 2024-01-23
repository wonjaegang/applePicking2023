extends Control
var isPressing = false
var touchJustFinished = false

var startY
var currentY
var firstVscroll
var scrollVel = 0

const DECEL = 0.2


func _process(_delta):
    if isPressing:
        currentY = get_viewport().get_mouse_position().y
        $ScrollContainer.scroll_vertical = firstVscroll + startY - currentY
    else:
        if touchJustFinished:
            scrollVel = get_viewport().get_mouse_position().y - currentY
            touchJustFinished = false
        if abs(scrollVel) > 0:
            if abs(scrollVel) > DECEL:
                scrollVel -= sign(scrollVel) * DECEL
                $ScrollContainer.scroll_vertical -= scrollVel
            else:
                scrollVel = 0
            

func _on_button_down():
    isPressing = true
    startY = get_viewport().get_mouse_position().y
    firstVscroll = $ScrollContainer.scroll_vertical


func _on_button_up():
    isPressing = false
    touchJustFinished = true
    

    
    
    
    
    
    
    
