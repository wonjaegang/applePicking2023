extends Resource
class_name ChapterInfo

static var chapterInfo = \
[
    # Chapter 1
    {
        chapterColor = {background = Color("#edddd4"),
                        vertical = Color("#283d3b"),
                        horizontal = Color("283d3b"),
                        user = Color("a999d0"),
                        marker = [Color("197278"),
                                  Color("83a8a6"),
                                  Color("ae9d96"),
                                  Color("d99185"),],},
        levelInfo = \
            [
                # Level 1
                {
                    boardMap = [[1, 2,],
                                [0, 0,],
                                [2, 1,],],                
                    lines = {type = [],},            
                    minUserLineNum = 1,
                },                
                # Level 2
                {
                    boardMap = [[0, 1, 2,],
                                [0, 0, 0,],
                                [0, 0, 0,],
                                [1, 2, 0,],],                
                    lines = {type = [],},            
                    minUserLineNum = 2,
                },                
                # Level 3
                {
                    boardMap = [[0, 1, 2,],
                                [0, 1, 0,],
                                [1, 0, 0,],
                                [0, 2, 1,],],                 
                    lines = {type = ["nrm",],},            
                    minUserLineNum = 2,
                },                
                # Level 4
                {
                    boardMap = [[1, 2, 3,],
                                [0, 0, 0,],
                                [1, 1, 2,],
                                [0, 2, 0,],
                                [1, 2, 3,],],                
                    lines = {type = ["nrm", "nrm",],},            
                    minUserLineNum = 2,
                },            
                # Level 5
                {
                    boardMap = [[1, 2, 3, 0],
                                [0, 0, 0, 0],
                                [0, 1, 1, 0],
                                [0, 0, 0, 0],
                                [0, 3, 2, 1],],           
                    lines = {type = ["nrm",],},            
                    minUserLineNum = 5,
                },
            ],
    },
    
    # Chapter 2
    {
        chapterColor = {background = Color("#e1d1d4"),
                        vertical = Color("#213d1b"),
                        horizontal = Color("213d1b"),
                        user = Color("a199d0"),
                        marker = [Color("117278"),
                                  Color("81a816"),
                                  Color("a19d16"),
                                  Color("d19115"),],},
        levelInfo = \
            [
                # Level 1
                {
                    boardMap = [[0, 1, 2,],
                                [0, 0, 0,],
                                [0, 0, 0,],
                                [1, 2, 0,],],                
                    lines = {type = [],},            
                    minUserLineNum = 2,
                },   
            ],
    },
    
    # Chapter 3
    {
        chapterColor = {background = Color("#edddd4"),
                        vertical = Color("#283d3b"),
                        horizontal = Color("283d3b"),
                        user = Color("a999d0"),
                        marker = [Color("197278"),
                                  Color("83a8a6"),
                                  Color("ae9d96"),
                                  Color("d99185"),],},
        levelInfo = \
            [
            ],
    },
    
    # Chapter 4
    {
        chapterColor = {background = Color("#edddd4"),
                        vertical = Color("#283d3b"),
                        horizontal = Color("283d3b"),
                        user = Color("a999d0"),
                        marker = [Color("197278"),
                                  Color("83a8a6"),
                                  Color("ae9d96"),
                                  Color("d99185"),],},
        levelInfo = \
            [
            ],
    },
]
