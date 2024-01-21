extends Control


func _on_play_level_button_pressed():
    get_tree().change_scene_to_file("res://inGame.tscn")


func _on_go_to_home_button_pressed():
    get_tree().change_scene_to_file("res://homeScene.tscn")
