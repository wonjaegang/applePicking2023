extends Node2D

const LINE_MARGIN = 30
const VERTICAL_OFFSET_Y = 260
const VERTICAL_INTERVAL_ARRAY = [0, 0, 170, 170, 150]
const MARKER_OFFSET = 50

var chapterColor
var boardMap
var lines
var minUserLineNum

var chapter = GlobalVariables.selectedChapter
var level = GlobalVariables.selectedLevel
    
var levelCompleteScene = preload("res://assets/levelCompletePanel.tscn")


func _ready():
    """
    globalVariable 에 저장된 selected 챕터/레벨 정보 기반으로 보드 생성
    """  
    getSelectedLevelInfo()
    createBoard()
    
    
func getSelectedLevelInfo():
    """
    ChapterInfo 클래스에서 선택한 챕터/레벨 정보 불러오기
    """
    chapterColor = ChapterInfo.chapterInfo[chapter-1].chapterColor
    boardMap = ChapterInfo.chapterInfo[chapter-1].levelInfo[level-1].boardMap
    lines = ChapterInfo.chapterInfo[chapter-1].levelInfo[level-1].lines
    minUserLineNum = ChapterInfo.chapterInfo[chapter-1].levelInfo[level-1].minUserLineNum

    
func createBoard():
    """
    보드정보에 맞추어 보드 생성
    """
    # 배경색 설정
    get_node("background").modulate = chapterColor.background
    
    # 레벨 라벨 표시
    $levelLabel.text = str(chapter) + ' - ' + str(level)
    
    # 선 생성을 위한 변수 선언
    var verticalHeight = preload("res://assets/verticalLine.tscn").instantiate().get_node("mesh").mesh.height
    var mapSize = [boardMap.size() - 2, boardMap[0].size()]
    var verticalInterval = VERTICAL_INTERVAL_ARRAY[mapSize[1]]
    var verticalX = (get_viewport_rect().size[0] - verticalInterval * (mapSize[1] - 1)) * 0.5
    var verticalPos = []
    var gridHeight = (verticalHeight - 2 * LINE_MARGIN) / (mapSize[0] + 1)
    
    # Manager 파라미터 지정
    $horizontalLineManager.yMin = VERTICAL_OFFSET_Y + LINE_MARGIN
    $horizontalLineManager.yMax = VERTICAL_OFFSET_Y + verticalHeight - LINE_MARGIN
    $horizontalLineManager.userLineColor = chapterColor.user
    
    # 수직선 생성
    for verticalIdx in range(mapSize[1]):
        var pos = Vector2(verticalX, VERTICAL_OFFSET_Y)
        verticalPos.append(pos)
        verticalX += verticalInterval
        
        $verticalLineManager.generateLine(pos, chapterColor.vertical)
        
        # 시작 마커 생성
        var startMarkerType = boardMap[0][verticalIdx]
        if startMarkerType != 0:
            var markerPos = pos - Vector2(0, MARKER_OFFSET)
            var markerColor = chapterColor.marker[startMarkerType - 1]
            $markerManager.generateMarker(markerPos, markerColor, true)
            
        # 종료 마커 생성
        var endMarkerType = boardMap[-1][verticalIdx]
        if endMarkerType != 0:
            var markerPos = pos + Vector2(0, MARKER_OFFSET + verticalHeight)
            var markerColor = chapterColor.marker[endMarkerType - 1]
            $markerManager.generateMarker(markerPos, markerColor, false)
    
    # 수직선 터치 시그널 연결
    $horizontalLineManager.connectLineGenerateSignal()
    
    # 수평선 생성
    for lineIdx in range(lines.type.size()):
        
        # 해당 선의 보드상의 위치 찾기
        var posIdx = []
        for yIdx in range(mapSize[0]):
            for xIdx in range(mapSize[1]):
                if boardMap[yIdx + 1][xIdx] == lineIdx + 1:
                    posIdx.append([yIdx, xIdx])
            if posIdx.size() == 2:
                break
        
        var startPos = Vector2(verticalPos[posIdx[0][1]].x,
                               VERTICAL_OFFSET_Y + LINE_MARGIN +
                               gridHeight * (posIdx[0][0] + 1))
        var endPos = Vector2(verticalPos[posIdx[1][1]].x,
                             VERTICAL_OFFSET_Y + LINE_MARGIN +
                             gridHeight * (posIdx[1][0] + 1))
        $horizontalLineManager.generateLine(startPos, endPos,
                                            lines.type[lineIdx],
                                            chapterColor.horizontal)
                    
    
func _on_marker_manager_level_completed():
    """
    레벨 완료 시 점수계산/다스플레이
    """
    # 점수(별) 계산
    var star = 0
    var usedLineNum = 0
    for horizontalLine in $horizontalLineManager.get_children():
        if horizontalLine.isUserLine:
            usedLineNum += 1
    if usedLineNum < minUserLineNum:
        star = 4
    elif usedLineNum == minUserLineNum:
        star = 3
    elif usedLineNum <= minUserLineNum + 2:
        star = 2
    else:
        star = 1
    
    # 점수 패널 디스플레이
    var scorePanel = levelCompleteScene.instantiate()
    add_child(scorePanel)
    scorePanel.setStar(star)
    scorePanel.set_deferred("size", get_viewport_rect().size)
    scorePanel.get_node("scorePanel/retryButton").pressed.connect(retry_button_pressed)
    scorePanel.get_node("scorePanel/nextLevelButton").pressed.connect(nextLevel_button_pressed)
    scorePanel.get_node("scorePanel/selectLevelButton").pressed.connect(chapter_button_pressed)
    
    
func chapter_button_pressed():
    """
    챕터 선택 씬으로 이동
    """
    get_tree().change_scene_to_file("res://chapterSelectScene.tscn")
    

func retry_button_pressed():
    """
    인게임 씬 재로드
    """
    get_tree().change_scene_to_file("res://inGame.tscn")
    
    
func nextLevel_button_pressed():
    """
    다음 레벨 이동. 마지막 레벨의 경우, 챕터 선택씬으로 이동
    """
    GlobalVariables.selectedLevel += 1
    if GlobalVariables.selectedLevel > len(ChapterInfo.chapterInfo[chapter-1].levelInfo):
        GlobalVariables.selectedLevel = 1
        get_tree().change_scene_to_file("res://chapterSelectScene.tscn")
    else:
        get_tree().change_scene_to_file("res://inGame.tscn")
    
    
    
    
    
    
    
    
    
    
    
    
    
    

