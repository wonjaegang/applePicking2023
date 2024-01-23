extends Area2D

var pressing = false
signal verticalLinePressed(verticalLineNode)

func _on_input_event(_viewport, event, _shape_idx):
    """
    클릭 시 한 번 시그널 출력 to userLineManager
    """
    if event.is_pressed():
        if not pressing:
            pressing = true
            emit_signal("verticalLinePressed", self)
    else:
        pressing = false
