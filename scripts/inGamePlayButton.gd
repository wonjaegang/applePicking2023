extends Button
var isButtonPlay = true 


func _on_pressed():
    flipState()


func flipState():
    if isButtonPlay:
        text = "STOP"
        isButtonPlay = false
    else:
        text = "PLAY"
        isButtonPlay = true
