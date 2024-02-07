extends Node
var FULLSCREEN = false
var SAVED_GAME = false

var MUSIC_ENABLED = true
var MUSIC_PLAYING = false
var MainTheme = ""
var CURRENT_CELL = null
var SEEDS = 0
var shaker_obj = null

enum SeedTiers {
	D,
	C, 
	B,
	A,
	S,
}

func save_game():
	pass
#	var saved_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
#	saved_game.store_var(Global.LEVEL)
#	saved_game.close()
#
#	var saved_poss = FileAccess.open("user://savepos.save", FileAccess.WRITE)
#	saved_poss.store_var(Global.POSSESSIONS)
#	saved_poss.close()
	
func load_game():
	pass
#	var saved_game = FileAccess.open("user://savegame.save", FileAccess.READ)
#	PLAY_INTRO = !saved_game
#	if saved_game:
#		var level = saved_game.get_var()
#		if level:
#			SAVED_GAME = true
#			Global.LEVEL = level
#			saved_game.close()
#
#	var saved_poss = FileAccess.open("user://savepos.save", FileAccess.READ)
#	if saved_poss:
#		var pos = saved_poss.get_var()
#		if pos:
#			Global.POSSESSIONS = pos
#			saved_poss.close()

func _ready():
	load_sfx()
	load_game()
	
func load_sfx():
	pass
	
func init():
	pass

func pick_random(container):
	if typeof(container) == TYPE_DICTIONARY:
		return container.values()[randi() % container.size() ]
	assert( typeof(container) in [
			TYPE_ARRAY, TYPE_PACKED_COLOR_ARRAY, TYPE_PACKED_INT32_ARRAY,
			TYPE_PACKED_BYTE_ARRAY, TYPE_PACKED_FLOAT32_ARRAY, TYPE_PACKED_STRING_ARRAY,
			TYPE_PACKED_VECTOR2_ARRAY, TYPE_PACKED_VECTOR3_ARRAY
			], "ERROR: pick_random" )
	return container[randi() % container.size()]

func play_sound(stream: AudioStream, options:= {}) -> AudioStreamPlayer:
	var audio_stream_player = AudioStreamPlayer.new()

	add_child(audio_stream_player)
	audio_stream_player.stream = stream
	audio_stream_player.bus = "SFX"
	
	for prop in options.keys():
		audio_stream_player.set(prop, options[prop])
	
	audio_stream_player.play()
	audio_stream_player.finished.connect(kill.bind(audio_stream_player))
	
	return audio_stream_player
	
func kill(_audio_stream_player):
	_audio_stream_player.queue_free()
