extends Control

var isPressing = false
var touchJustFinished = false
var isInOrder = true

var scrollMax
var chapterNum

var startY
var currentY
var firstVscroll
var scrollVel = 0

var lastSelectedChapterIdx = 1
var selectedChapterIdx = 1

const DECEL = 1
const STOP_VEL = 8  # STOP_VEL should be bigger than DECEL
const CHAPTER_Y = 400  # Shold be even number


func _ready():
    @warning_ignore("integer_division")
    $ScrollContainer.set_deferred("scroll_vertical", CHAPTER_Y / 2)
    scrollMax = $ScrollContainer/VBoxContainer.size.y - $ScrollContainer.size.y
    chapterNum = $ScrollContainer/VBoxContainer.get_child_count() - 2


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
               $ScrollContainer.scroll_vertical == scrollMax:
                scrollVel = 0
            
        # 관성처리 종료 시 제 위치로 정렬
        else:
            if not isInOrder:
                @warning_ignore("integer_division")
                var gap = ($ScrollContainer.scroll_vertical + CHAPTER_Y / 2) % CHAPTER_Y
                if gap > 200 or $ScrollContainer.scroll_vertical == 0:
                    $ScrollContainer.scroll_vertical += min(STOP_VEL, CHAPTER_Y - gap)
                elif gap > 0:
                    $ScrollContainer.scroll_vertical -= min(STOP_VEL, gap)
                else:
                    isInOrder = true
                    
    # 선택된 챕터 계산
    selectedChapterIdx = min($ScrollContainer.scroll_vertical / CHAPTER_Y + 1, chapterNum)
    GlobalVariables.selectedChapter = selectedChapterIdx
    
    # 선택된 챕터 변경 시 로직
    if not lastSelectedChapterIdx == selectedChapterIdx:
        $ScrollContainer/VBoxContainer.get_child(lastSelectedChapterIdx).deselected()
        $ScrollContainer/VBoxContainer.get_child(selectedChapterIdx).selected()
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








