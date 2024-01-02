extends Node2D

const boardOffsetX = 300
const boardOffsetY = 300
const boardHeight = 700
const boardHeight1 = 300

signal generateVerticalLine(start, end)
signal generateHorizontalLine(start, end, type)

var boardMap1 = [[1, 0],
                 [0, 1],
                 [2, 2],]
var lines1 = {type = ["nrm", "arR"],
              colorDot = [Color(1, 0, 0), null],}                    
                          
                              
func _ready():
    createBoard(boardMap1, lines1)
    
    
func createBoard(boardMap, lines):
    """
    보드정보에 맞추어 보드 생성
    """
    pass







