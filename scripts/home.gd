extends Control



func _on_select_level_button_pressed():
    get_tree().change_scene_to_file("res://chapterSelectScene.tscn")
