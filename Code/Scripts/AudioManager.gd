extends Node

var audioPLayers : Array = []
var musicPlayer : AudioStreamPlayer

func _ready() -> void:
	musicPlayer = AudioStreamPlayer.new()
	add_child(musicPlayer)
	for i in 10:
		audioPLayers.append(AudioStreamPlayer.new())
	for i in audioPLayers:
		add_child(i)
	
func playSound(sound : AudioStream, volume : float = 1, startPosition : float = 0.0) -> void:
	var newAudioPlayer = getAvailableStreamPlayer()
	if newAudioPlayer != null:
		newAudioPlayer.stream = sound
		newAudioPlayer.volume_db = linear_to_db(volume)
		newAudioPlayer.play(startPosition)

func playMusic(sound : AudioStream, volume : float = 1) -> void:
	musicPlayer.stream = sound
	musicPlayer.volume_db = linear_to_db(volume)
	musicPlayer.play()

func getAvailableStreamPlayer() -> AudioStreamPlayer:
	for i in audioPLayers:
		if not i.playing:
			return i
	return null
