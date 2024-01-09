extends Node2D

const LINE_MARGIN = 30
const VERTICAL_OFFSET_Y = 300
const VERTICAL_INTERVAL_ARRAY = [0, 0, 200, 170, 150]
const MARKER_OFFSET = 20

signal generateVerticalLine(pos, color)
signal generateHorizontalLine(startPos, endPos, type)
signal generateMarker(pos, color, isStart)

var chapterColor1 = {background = Color("#edddd4"),
                     vertical = Color("#283d3b"),}
var boardMap1 = [[1, 0, 0, 0],
                 [0, 1, 0, 0],
                 [2, 2, 0, 0],]
var lines1 = {type = ["nrm", "nrm"],
              colorDot = [Color(1, 0, 0), null],}
                           

func _ready():
    createBoard(boardMap1, lines1, chapterColor1)
    
    
func createBoard(boardMap, lines, chapterColor):
    """
    보드정보에 맞추어 보드 생성
    """
    # 배경색 설정
    get_node("../background").modulate = chapterColor.background
    
    # 선 생성을 위한 변수 선언
    var verticalHeight = preload("res://assets/verticalLine.tscn").instantiate().get_node("mesh").mesh.height
    var mapSize = [boardMap.size(), boardMap[0].size()]
    var verticalInterval = VERTICAL_INTERVAL_ARRAY[mapSize[1]]
    var verticalX = (get_viewport_rect().size[0] - verticalInterval * (mapSize[1] - 1)) * 0.5
    var verticalPos = []
    var gridHeight = (verticalHeight - 2 * LINE_MARGIN) / (mapSize[0] + 1)
    
    # 수직선 생성
    for verticalIdx in range(mapSize[1]):
        var pos = Vector2(verticalX, VERTICAL_OFFSET_Y)
        verticalPos.append(pos)
        verticalX += verticalInterval
        
        emit_signal("generateVerticalLine", pos, chapterColor.vertical)
        emit_signal("generateMarker", pos - Vector2(0, MARKER_OFFSET), 0, true)
        emit_signal("generateMarker", pos + Vector2(0, MARKER_OFFSET + verticalHeight), 0, false)
        #  마커 색 전달 필요
    
    # 수평선 생성
    for lineIdx in range(lines.type.size()):
        
        # 해당 선의 보드상의 위치 찾기
        var posIdx = []
        for yIdx in range(mapSize[0]):
            for xIdx in range(mapSize[1]):
                if boardMap[yIdx][xIdx] == lineIdx + 1:
                    posIdx.append([yIdx, xIdx])
            if posIdx.size() == 2:
                break
        
        var startPos = Vector2(verticalPos[posIdx[0][1]].x,
                               VERTICAL_OFFSET_Y + LINE_MARGIN + gridHeight * (posIdx[0][0] + 1))
        var endPos = Vector2(verticalPos[posIdx[1][1]].x,
                               VERTICAL_OFFSET_Y + LINE_MARGIN + gridHeight * (posIdx[1][0] + 1))
        emit_signal("generateHorizontalLine", startPos, endPos, lines.type[lineIdx])
        # colorDot 정보 전달 필요
        
        







