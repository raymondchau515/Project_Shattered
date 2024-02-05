extends CharacterBody3D

var SPEED = 50.0
var mouse_position : Vector3

func _process(_delta):
	var camera_direction = (get_parent().ScreenPointToRay() - self.position).normalized()

	
	velocity.x = camera_direction.x * SPEED
	velocity.z = camera_direction.z * SPEED

	move_and_slide()
	



func _on_camera_limit_body_exited(body):
	velocity.x = 0
	velocity.z = 0
