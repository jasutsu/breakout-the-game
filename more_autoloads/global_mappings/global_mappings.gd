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

const BrickColorResource: BrickColors = preload("res://scenes/brick/brick_colors.tres") as BrickColors



enum GamePauseType {
	PAUSE,
	GAME_OVER,
	GAME_WIN,
}

const PauseActionText: Dictionary[int, String] = {
	GamePauseType.PAUSE: "Resume",
	GamePauseType.GAME_OVER: "Try Again",
	GamePauseType.GAME_WIN: "Next Level",
}



const GAME_LEVEL_PATH_PREFIX: String = "res://scenes/levels/level_"
const GAME_LEVEL_PATH_SUFFIX: String = ".tscn"



const IN_GAME_STATE_NAME: String = "InGame"



enum SfxType {
	BUTTON_HOVER,
	BUTTON_CLICK,
	PADDLE_BALL_HIT,
	BRICK_CRACKED,
	BRICK_SMASHED,
	BRICK_BUFF,
	BRICK_WALL,
	BUFF_STARTED,
	#BUFF_FINISHED,
	APPLY_MOVES,
	#UNAPPLY_MOVES,
	GAME_WIN,
	GAME_OVER,
	BALL_HIT_BOUNDARY,
}

const SfxResources: Dictionary[SfxType, AudioStream] = {
	SfxType.BUTTON_HOVER: preload("res://assets/sound/choosen_sounds/button_hover.ogg"),
	SfxType.BUTTON_CLICK: preload("res://assets/sound/choosen_sounds/button_click.ogg"),
	SfxType.PADDLE_BALL_HIT: preload("res://assets/sound/choosen_sounds/paddle_ball_hit.ogg"),
	SfxType.BRICK_CRACKED: preload("res://assets/sound/choosen_sounds/brick_cracked.wav"),
	SfxType.BRICK_SMASHED: preload("res://assets/sound/choosen_sounds/brick_smashed.ogg"),
	SfxType.BRICK_BUFF: preload("res://assets/sound/choosen_sounds/brick_buff.ogg"),
	SfxType.BRICK_WALL: preload("res://assets/sound/choosen_sounds/brick_wall.ogg"),
	SfxType.BUFF_STARTED: preload("res://assets/sound/choosen_sounds/buff_started.ogg"),
	SfxType.APPLY_MOVES: preload("res://assets/sound/choosen_sounds/apply_moves.wav"),
	SfxType.GAME_WIN: preload("res://assets/sound/choosen_sounds/game_win.ogg"),
	SfxType.GAME_OVER: preload("res://assets/sound/choosen_sounds/game_over.ogg"),
	SfxType.BALL_HIT_BOUNDARY: preload("res://assets/sound/choosen_sounds/ball_hit_boundary.ogg"),
}

const MusicResource: AudioStream = preload("res://assets/sound/choosen_sounds/background_music.ogg")
