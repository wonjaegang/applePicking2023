extends Area2D

const SPEED = 200
var tween
var onVertical = true


func move_to(destination):
    if tween:
        tween.kill()
    tween = create_tween()
    var duration = (destination - position).length() / SPEED
    tween.tween_property(self, "position", destination, duration)


func _on_area_entered(area):
    if area.get_parent().name == "horizontalLineManager":
        move_to(area.position)









