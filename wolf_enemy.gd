extends CharacterBody3D
var Player_Stressing = false
var chase = false
var player_location
@export var SPEED: float = 20
func _ready():
	chase = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if chase == true:
		get_node("AnimatedSprite3D").play("moving")
		player_location = get_node("/root/World/Player")
		var direction = (player_location.position - self.position).normalized()
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		if direction.x > 0:
			get_node("AnimatedSprite3D").flip_h = true
		if direction.x < 0:
			get_node("AnimatedSprite3D").flip_h = false
		
	
	else:
		get_node("AnimatedSprite3D").play("bark")
		velocity.x = 0
		velocity.z = 0
	if Player_Stressing == true:
		get_node("/root/World/Player").Stress += 5 * delta

	move_and_slide()




func _on_area_3d_area_entered(area):
	if area.name == "Detection Area":
		chase = false


func _on_area_3d_area_exited(area):
		if area.name == "Detection Area":
			chase = true
