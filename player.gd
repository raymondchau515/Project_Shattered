extends CharacterBody3D


const SPEED = 100.0
const JUMP_VELOCITY = 4.5
@export var Stress : float = 0.0
var anim

# Called when the node enters the scene tree for the first time.
func _ready():
	anim = get_node("AnimatedSprite3D")
	anim.play("Idle")
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
#	if Stress >= 100:
	#	self.queue_free()
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
#	if Input.is_action_just_pressed("Jump") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("Move_Left", "Move_Right", "Move_Up", "Move_Down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	if velocity.x or velocity.y > 0:
		
		if direction.x > 0:
			anim.play("moving")
			anim.flip_h = false
			
		if direction.x < 0:
			anim.play("moving")
			anim.flip_h = true
	else:
		anim.play("Idle")
		
	get_node("MeshInstance3D").look_at(ScreenPointToRay(),Vector3.UP)
		
	#var input_camera_dir = Input.get_axis("Camera_Left","Camera_Right")
	
	move_and_slide()
	
func ScreenPointToRay():
	var spaceState = get_world_3d().direct_space_state
	var mousePos = get_viewport().get_mouse_position()
	var camera = get_node("Camera_Body/Player_Camera")
	var rayOrigin = camera.project_ray_origin(mousePos)
	var rayEnd = rayOrigin + camera.project_ray_normal(mousePos) * 2000
	var rayArray = spaceState.intersect_ray(PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd))
	if rayArray.has("position"):
		return rayArray["position"]
	return Vector3()
