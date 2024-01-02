extends Node2D

signal generateVerticalLine(start, end)
signal generateHorizontalLine(start, end, type)

var dict1 = {'line0': {0.5: {'type': 'Line',
                             'subtype': 'normal',
                             'toLine' : 1,
                             'toY': 0.5},
                       0.8: {'type': 'Line',
                             'subtype': 'normal',
                             'toLine' : 1,
                             'toY': 0.5}},
             'line1': {0.8: {'type': 'Line',
                             'subtype': 'normal',
                             'toLine' : 1,
                             'toY': 0.5}}}
                                
func _ready():
    createBoard(dict1)
    
func createBoard(boardInfoDict):
    """
    보드정보에 맞추어 보드 생성
    """
    var verticalNum = boardInfoDict.size()
    const df = 1
    print(get_viewport_rect().size)
    for verticalLine in boardInfoDict.values():
        emit_signal("generateVerticalLine", Vector2(0, 0), Vector2(0, 0))
        for yRatio in verticalLine:
            
            emit_signal("generateHorizontalLine", Vector2(0, 0), Vector2(0, 0), 'normal')
            print(yRatio)
            print(verticalLine[yRatio])







