extends Area2D

var pressing = false
signal verticalLinePressed(verticalLineNode)

func _on_input_event(viewport, event, shape_idx):
    if event.is_pressed():
        if not pressing:
            pressing = true
            emit_signal("verticalLinePressed", self)
    else:
        pressing = false
