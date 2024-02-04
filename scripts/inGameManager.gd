extends Node2D

const LINE_MARGIN = 30
const VERTICAL_OFFSET_Y = 260
const VERTICAL_INTERVAL_ARRAY = [0, 0, 170, 170, 150]
const MARKER_OFFSET = 50

signal generateVerticalLine(pos, color)
signal generateHorizontalLine(startPos, endPos, type, color)
signal generateMarker(pos, color, isStart)

var chapterColor
var boardMap
var lines
var minUserLineNum



func _ready():
    """
    globalVariable 에 저장된 selected 챕터/레벨 정보 기반으로 보드 생성
    """
    var chapter = GlobalVariables.selectedChapter - 1
    var level = GlobalVariables.selectedLevel - 1    
    chapterColor = ChapterInfo.chapterInfo[chapter].chapterColor
    boardMap = ChapterInfo.chapterInfo[chapter].levelInfo[level].boardMap
    lines = ChapterInfo.chapterInfo[chapter].levelInfo[level].lines
    minUserLineNum = ChapterInfo.chapterInfo[chapter].levelInfo[level].minUserLineNum
    createBoard()
    
    
func createBoard():
    """
    보드정보에 맞추어 보드 생성
    """
    # 배경색 설정
    get_node("../background").modulate = chapterColor.background
    
    # 선 생성을 위한 변수 선언
    var verticalHeight = preload("res://assets/verticalLine.tscn").instantiate().get_node("mesh").mesh.height
    var mapSize = [boardMap.size() - 2, boardMap[0].size()]
    var verticalInterval = VERTICAL_INTERVAL_ARRAY[mapSize[1]]
    var verticalX = (get_viewport_rect().size[0] - verticalInterval * (mapSize[1] - 1)) * 0.5
    var verticalPos = []
    var gridHeight = (verticalHeight - 2 * LINE_MARGIN) / (mapSize[0] + 1)
    
    # Manager 파라미터 지정
    $"../horizontalLineManager".yMin = VERTICAL_OFFSET_Y + LINE_MARGIN
    $"../horizontalLineManager".yMax = VERTICAL_OFFSET_Y + verticalHeight - LINE_MARGIN
    $"../horizontalLineManager".userLineColor = chapterColor.user
    
    # 수직선 생성
    for verticalIdx in range(mapSize[1]):
        var pos = Vector2(verticalX, VERTICAL_OFFSET_Y)
        verticalPos.append(pos)
        verticalX += verticalInterval
        
        emit_signal("generateVerticalLine", pos, chapterColor.vertical)
        
        var startMarkerType = boardMap[0][verticalIdx]
        if startMarkerType != 0:
            var markerPos = pos - Vector2(0, MARKER_OFFSET)
            var markerColor = chapterColor.marker[startMarkerType - 1]
            emit_signal("generateMarker", markerPos, markerColor, true)
        
        var endMarkerType = boardMap[-1][verticalIdx]
        if endMarkerType != 0:
            var markerPos = pos + Vector2(0, MARKER_OFFSET + verticalHeight)
            var markerColor = chapterColor.marker[endMarkerType - 1]
            emit_signal("generateMarker", markerPos, markerColor, false)
        
    
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
        emit_signal("generateHorizontalLine",
                    startPos,
                    endPos,
                    lines.type[lineIdx],
                    chapterColor.horizontal)
        # colorDot 정보 전달 필요
        
    
func _on_marker_manager_level_completed():
    # 레벨 종료 시 점수 창 표시
    var star = 0
    var usedLineNum = 0
    for horizontalLine in $"../horizontalLineManager".get_children():
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
    print(star)


func _on_chapter_button_pressed():
    get_tree().change_scene_to_file("res://chapterSelectScene.tscn")







