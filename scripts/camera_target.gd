extends Node3D  

@onready var player = $"Player/CameraTarget"  
var smoothing_speed = 5.0  

func _process(delta):
	if player:
		position = position.lerp(player.position, smoothing_speed * delta)
