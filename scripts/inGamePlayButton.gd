extends Button
var isButtonPlay = true 


func _on_pressed():
    flipState()


func flipState():
    if isButtonPlay:
        icon = ResourceLoader.load("res://resources/resetIcon.svg")
        isButtonPlay = false
    else: 
        icon = ResourceLoader.load("res://resources/playIcon.svg")
        isButtonPlay = true
