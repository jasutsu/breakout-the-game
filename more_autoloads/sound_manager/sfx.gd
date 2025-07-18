extends AudioStreamPlayer

var type: GlobalMappings.SfxType

func initialize(sfx_type: GlobalMappings.SfxType) -> void:
	type = sfx_type

func _ready() -> void:
	stream = GlobalMappings.SfxResources[type]
	play()
