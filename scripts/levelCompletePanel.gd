extends Panel


func setStar(starNum):
    match starNum:
        1:
            $scorePanel/star1.visible = true
        2:
            $scorePanel/star1.visible = true
            $scorePanel/star2.visible = true
        3:
            $scorePanel/star1.visible = true
            $scorePanel/star2.visible = true
            $scorePanel/star3.visible = true
        4:
            $scorePanel/star1.visible = true
            $scorePanel/star2.visible = true
            $scorePanel/star3.visible = true
