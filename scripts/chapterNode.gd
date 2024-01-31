extends Control


func selected():
    $linePanel/circlePanel.custom_minimum_size = Vector2(100, 100)


func deselected():
    $linePanel/circlePanel.custom_minimum_size = Vector2(50, 50)
