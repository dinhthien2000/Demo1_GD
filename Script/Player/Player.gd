extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0

@onready var anim = get_node("AnimatedSprite2D");

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var flag

func _process(_delta):
		if flag:
			anim.play("Death");
			
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		anim.play("Jump");
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		anim.play("Run");
		anim.scale.x = direction; # flip: lật
		velocity.x = direction * SPEED
	else:
		anim.play("Idle");
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.name == "Bee":
		print("Bee")
		flag = true
	pass # Replace with function body.
