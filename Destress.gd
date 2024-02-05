extends CharacterBody3D



func _on_area_3d_body_entered(body):
	if body.name == "Player":
		get_node("/root/World/Player").Stress -= 5
		self.queue_free()
	


