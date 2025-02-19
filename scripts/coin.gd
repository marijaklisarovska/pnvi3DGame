extends Area3D

signal coinCollected

func _ready():
	add_to_group("coins")  

func _physics_process(delta):
	rotate_y(deg_to_rad(3))

func _on_body_entered(body):
	if body.name == "Player":
		$Timer.start()

func _on_timer_timeout():
	emit_signal("coinCollected")
	queue_free()
