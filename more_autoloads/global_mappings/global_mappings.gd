extends Node

enum BuffType {
	BALL_SPLIT,
	BALL_FAST,
	BALL_BIG,
	PADDLE_FAST,
	PADDLE_TWO,
}
const BubbleResources: Dictionary[int, BubbleData] = {
	BuffType.BALL_SPLIT: preload("res://scenes/bubble/bubble_types/bubble_ball_split.tres"),
	BuffType.BALL_FAST: preload("res://scenes/bubble/bubble_types/bubble_ball_fast.tres"),
	BuffType.BALL_BIG: preload("res://scenes/bubble/bubble_types/bubble_ball_big.tres"),
	BuffType.PADDLE_FAST: preload("res://scenes/bubble/bubble_types/bubble_paddle_fast.tres"),
	BuffType.PADDLE_TWO: preload("res://scenes/bubble/bubble_types/bubble_paddle_two.tres"),
}


enum BrickType {
	NORMAL,
	CRACKABLE,
	WALL,
	BUFF_BALL_SPLIT,
	BUFF_BALL_FAST,
	BUFF_BALL_BIG,
	BUFF_PADDLE_FAST,
	BUFF_PADDLE_TWO,
	TWO_CRACKABLE,
}
const BrickResources: Dictionary[int, BrickData] = {
	BrickType.NORMAL: preload("res://scenes/brick/brick_resource_types/brick_normal.tres"),
	BrickType.CRACKABLE: preload("res://scenes/brick/brick_resource_types/brick_crackable.tres"),
	BrickType.TWO_CRACKABLE: preload("res://scenes/brick/brick_resource_types/brick_two_crackable.tres"),
	BrickType.WALL: preload("res://scenes/brick/brick_resource_types/brick_wall.tres"),
	BrickType.BUFF_BALL_SPLIT: preload("res://scenes/brick/brick_resource_types/brick_buff_ball_split.tres"),
	BrickType.BUFF_BALL_FAST: preload("res://scenes/brick/brick_resource_types/brick_buff_ball_fast.tres"),
	BrickType.BUFF_BALL_BIG: preload("res://scenes/brick/brick_resource_types/brick_buff_ball_big.tres"),
	BrickType.BUFF_PADDLE_FAST: preload("res://scenes/brick/brick_resource_types/brick_buff_paddle_fast.tres"),
	BrickType.BUFF_PADDLE_TWO: preload("res://scenes/brick/brick_resource_types/brick_buff_paddle_two.tres"),
}

const BrickColors: ColorPalette = preload("res://scenes/brick/brick_colors.tres") as ColorPalette
