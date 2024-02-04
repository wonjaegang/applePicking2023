extends Control


func _ready():
    # 레벨 선택 버튼 시그널 연결, 레벨 값 포함 연결
    var level = 0
    for levelButton in $levelPanel/GridContainer.get_children():
        level += 1
        levelButton.pressed.connect(_on_play_level_button_pressed.bind(level))

func _on_play_level_button_pressed(level):
    GlobalVariables.selectedLevel = level
    get_tree().change_scene_to_file("res://inGame.tscn")


func _on_go_to_home_button_pressed():
    get_tree().change_scene_to_file("res://homeScene.tscn")
