extends Area3D

signal treasureCollected

func _ready():
	add_to_group("treasures")  

func _physics_process(delta):
	rotate_y(deg_to_rad(3))

func _on_body_entered(body):
	if body.name == "Player":
		$Timer.start()

func _on_timer_timeout():
	emit_signal("treasureCollected")
	queue_free()
