extends Resource
class_name BrickData

@export var health: int
@export_enum(
	"none",
	"big_ball",
	"fast_ball",
	"fast_paddle",
	"split_ball",
	"two_paddle"
	) var buff: String
@export var wall: bool
