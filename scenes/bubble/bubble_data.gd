extends Resource
class_name BubbleData

@export_enum(
	"big_ball",
	"fast_ball",
	"fast_paddle",
	"split_ball",
	"two_paddle"
	) var name: String
@export var texture: Texture2D
@export var speed: float = 1.0
@export var size: float = 1.0
@export var duration: float = 1.0
