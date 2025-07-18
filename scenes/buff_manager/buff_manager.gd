extends Node
class_name BuffManager

signal buff_started(buff_type: GlobalMappings.BuffType)
signal buff_finished(buff_type: GlobalMappings.BuffType)

var timers: Dictionary[GlobalMappings.BuffType, SceneTreeTimer] = {}

func _ready() -> void:
	buff_started.connect(UiManager.start_buff)
	buff_finished.connect(UiManager.finish_buff)

func start_buff(buff_type: GlobalMappings.BuffType) -> void:
	SoundManager.play_sfx(GlobalMappings.SfxType.BUFF_STARTED)
	if timers.has(buff_type):
		var time_left: float = timers[buff_type].time_left
		# TODO: use start() instead or time_left directly
		timers[buff_type].time_left = time_left + GlobalMappings.BubbleResources[buff_type].duration
		return
		
	buff_started.emit(buff_type)
	var timer: SceneTreeTimer = get_tree().create_timer(GlobalMappings.BubbleResources[buff_type].duration)
	timer.timeout.connect(finish_buff.bind(buff_type))
	timers[buff_type] = timer

func finish_buff(buff_type: GlobalMappings.BuffType) -> void:
	timers.erase(buff_type)
	buff_finished.emit(buff_type)
