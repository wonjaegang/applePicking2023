extends Node2D
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
    for verticalLine in boardInfoDict.values():
        for yRatio in verticalLine:
            
            print(yRatio)
            print(verticalLine[yRatio])







