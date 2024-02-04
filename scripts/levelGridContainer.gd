extends GridContainer

var levelButtonScene = preload("res://assets/levelButton.tscn")


func _ready():
    # 씬 시작 시 20개의 레벨 버튼 생성
    for level in range(1, 21):
        var levelButton = levelButtonScene.instantiate()
        levelButton.custom_minimum_size = Vector2(100, 100)
        levelButton.get_node("label").text = str(level)
        levelButton.setStar(0)
        add_child(levelButton)
