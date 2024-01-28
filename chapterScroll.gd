extends Control
var isPressing = false
var touchJustFinished = false
var isInOrder = true

var startY
var currentY
var firstVscroll
var scrollVel = 0

var lastSelectedChapterIdx = 1
var selectedChapterIdx = 1

const DECEL = 1
const STOP_VEL = 8  # STOP_VEL should be bigger than DECEL


func _ready():
    $ScrollContainer.set_deferred("scroll_vertical", 200)


func _process(_delta):
    # 터치 중 마우스 위치에 따라 스크롤
    if isPressing:
        currentY = get_viewport().get_mouse_position().y
        $ScrollContainer.scroll_vertical = firstVscroll + startY - currentY
    
    # 터치 종료 후 스크롤 로직
    else:
        # 터치 종료 시점 마우스 속도 저장
        if touchJustFinished:
            scrollVel = get_viewport().get_mouse_position().y - currentY
            touchJustFinished = false
            
        # 관성처리
        if abs(scrollVel) > STOP_VEL:
            scrollVel -= sign(scrollVel) * DECEL
            $ScrollContainer.scroll_vertical -= scrollVel
            if $ScrollContainer.scroll_vertical == 0 or\
               $ScrollContainer.scroll_vertical == $ScrollContainer/VBoxContainer.size.y - $ScrollContainer.size.y:
                scrollVel = 0
            
        # 관성처리 종료 시 제 위치로 정렬
        else:
            if not isInOrder:
                var gap = ($ScrollContainer.scroll_vertical + 200) % 400
                if gap > 200 or $ScrollContainer.scroll_vertical == 0:
                    $ScrollContainer.scroll_vertical += min(STOP_VEL, 400 - gap)
                elif gap > 0:
                    $ScrollContainer.scroll_vertical -= min(STOP_VEL, gap)
                else:
                    isInOrder = true
                    
    # 선택된 챕터 계산
    selectedChapterIdx = $ScrollContainer.scroll_vertical / 400 + 1
    if selectedChapterIdx > $ScrollContainer/VBoxContainer.get_child_count() - 2:
        selectedChapterIdx = $ScrollContainer/VBoxContainer.get_child_count() - 2
    
    # 선택된 챕터 변경 시 로직
    if not lastSelectedChapterIdx == selectedChapterIdx:
        $ScrollContainer/VBoxContainer.get_child(lastSelectedChapterIdx).color = Color(1, 1, 1)
        $ScrollContainer/VBoxContainer.get_child(selectedChapterIdx).color = Color(0, 0, 0)
        lastSelectedChapterIdx = selectedChapterIdx
                        

func _on_button_down():
    """
    스크롤 시작
    """
    isPressing = true
    isInOrder = false
    startY = get_viewport().get_mouse_position().y
    firstVscroll = $ScrollContainer.scroll_vertical


func _on_button_up():
    """
    스크롤 종료
    """
    isPressing = false
    touchJustFinished = true








