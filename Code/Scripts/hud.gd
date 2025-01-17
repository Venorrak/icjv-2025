extends CanvasLayer

@export var timerLabel : RichTextLabel
@export var roundTimer : Timer
@export var timerLabelAccent : Color
@export var animator : AnimationPlayer
@export var shockSound : AudioStream

var currentMiniGame = null

func _ready() -> void:
	SignalBus.connect("newLoop", newLoopAnimation)
	SignalBus.connect("startMiniGame", startMiniGame)

func _physics_process(delta: float) -> void:
	var remainingTime : float = roundTimer.time_left
	var currentColor : Color = getCurrentColor(remainingTime, roundTimer.wait_time)
	updateTimerLabel(remainingTime, currentColor)
	
func getCurrentColor(time : float, totalTime : float) -> Color:
	var amount : float = inverse_lerp(totalTime, 0.0, time)
	return Color.WHITE.lerp(timerLabelAccent, amount)

func updateTimerLabel(remainingTime : float, accentColor : Color) -> void:
	var secondes = str(int(remainingTime) % 60)
	var minutes = str(int(remainingTime) / 60)
	if secondes.length() < 2:
		secondes = "0" + secondes
	if minutes.length() < 2:
		minutes = "0" + minutes
	var text = minutes + " : " + secondes
	text = BBcodeBuild.color(text, accentColor)
	text = BBcodeBuild.fontSize(text, 30)
	text = BBcodeBuild.center(text)
	var amount : float = inverse_lerp(roundTimer.wait_time, 0.0, remainingTime)
	text = BBcodeBuild.shake(text, amount * 50, 5, true)
	timerLabel.text = text

func newLoopAnimation() -> void:
	animator.play("loop")
	AudioManager.playSound(shockSound, 0.5)

func loopAnimationEnd() -> void:
	get_tree().reload_current_scene()

func startMiniGame(caller: Node2D, minigame : PackedScene) -> void:
	var newMiniGame = minigame.instantiate()
	newMiniGame.connect("finished", caller.onMiniGameFinished)
	add_child(newMiniGame)
