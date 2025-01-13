extends Node

var audioPLayers : Array = []
var musicPlayer : AudioStreamPlayer

func _ready() -> void:
	musicPlayer = AudioStreamPlayer.new()
	add_child(musicPlayer)
	
func playSound(sound : AudioStream, volume : float = 1) -> void:
	var newAudioPlayer = AudioStreamPlayer.new()
	newAudioPlayer.stream = sound
	newAudioPlayer.volume_db = linear_to_db(volume)
	audioPLayers.append(newAudioPlayer)
	add_child(newAudioPlayer)
	newAudioPlayer.play()

func playMusic(sound : AudioStream, volume : float = 1) -> void:
	musicPlayer.stream = sound
	musicPlayer.volume_db = linear_to_db(volume)
	musicPlayer.play()
	
func _physics_process(delta):
	for i in audioPLayers.size():
		if not audioPLayers[i].playing:
			audioPLayers[i].queue_free()
			audioPLayers.remove_at(i)
			break
