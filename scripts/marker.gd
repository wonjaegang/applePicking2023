extends Area2D

const SPEED = 200
var tween
var onVertical = true
var lastLine = null


func move_to(destination: Vector2):
    if tween:
        tween.kill()
    tween = create_tween()
    var duration = (destination - position).length() / SPEED
    tween.tween_property(self, "position", destination, duration)        

# 방법을 바꿔야할듯. 수평선을 따라 이동 중 이미 enter 된 아이들에대한 처리가 필요함.
func _on_area_entered(area):
    if onVertical and area.global_position.y > position.y and area != lastLine:
        if area.name == "startArea":
            onVertical = false
            lastLine = area
            move_to(area.global_position)
            await tween.finished
            move_to(area.get_parent().get_node("endArea").global_position) 
                       
            await tween.finished
            onVertical = true
            move_to(position + Vector2(0, 2000))
        elif area.name == "endArea":
            onVertical = false
            lastLine = area            
            move_to(area.global_position)
            await tween.finished
            move_to(area.get_parent().get_node("startArea").global_position)
            
            await tween.finished
            onVertical = true
            move_to(position + Vector2(0, 2000))









