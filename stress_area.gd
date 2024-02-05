extends Area3D

var Stressing = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Stressing == true:
		get_node("/root/World/Player").Stress += delta * 5




func _on_body_entered(body):
	if body.name == "Player":
		Stressing = true

func _on_body_exited(body):
	if body.name == "Player":
		Stressing = false
