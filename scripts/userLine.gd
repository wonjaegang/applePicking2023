extends Area2D

var collideVerticalCount = 0
var collideHorizontalCount = 0
var collideVerticalNode = Node2D
var proper = true


func _on_area_entered(area):
    var nodeName = area.get_parent().name
    if nodeName == "verticalLineManager":
        collideVerticalCount += 1
    if nodeName == "horizontalLineManager" or nodeName == "userLineManager":
        collideHorizontalCount += 1
    checkIsProper()


func _on_area_exited(area):
    var nodeName = area.get_parent().name
    if nodeName == "verticalLineManager":
        collideVerticalCount -= 1
    if nodeName == "horizontalLineManager" or nodeName == "userLineManager":
        collideHorizontalCount -= 1
    checkIsProper()


func checkIsProper():
    if collideHorizontalCount == 0 and collideVerticalCount == 2:
        proper = true
    else:
        proper = false
    
    
    
    
    
    
    
    
    
    
    
    
