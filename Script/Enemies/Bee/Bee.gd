extends CharacterBody2D

const SPEED = 3000.0;
const JUMP_VELOCITY = 400.0;

@onready var anim = get_node("AnimatedSprite2D");
@onready var player = get_node("../Player");
@onready var anim_player = player.get_child(1)

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") # trọng lực mặc định
var flag_detect_player
var flag_player_death
# Called every frame. '_delta' is the elapsed time since the previous frame.
func _ready():
	anim.play("Idle");
	pass

func _process(_delta):	
		if flag_player_death:	
			await get_tree().create_timer(1.0).timeout
			reload()
			
func _physics_process(_delta):
	# Cách detect player 1:
	#var bound_player_and_enemy = player.position.x - self.position.x; # phạm vi giữa player và enemy, self là gọi thuộc tính của node 
	#
	#if ( bound_player_and_enemy < 100.0 && bound_player_and_enemy > -100.0 ):
		#velocity = (player.position - self.position).normalized() * SPEED * _delta; # nhớ extend CharacterBody2D để có được vị trí của nhân vật
	#else:
		## dừng lại  không di chuyển nữa
		#velocity.x = move_toward(velocity.x, 0, SPEED);
		#velocity.y = move_toward(velocity.y, 0, SPEED);
	
	# Cách detect player 2:	
	if flag_detect_player:
		velocity = (player.position - position).normalized() * SPEED * _delta;
	else:
		# dừng lại  không di chuyển nữa
		velocity.x = move_toward(velocity.x, 0, SPEED);
		velocity.y = move_toward(velocity.y, 0, SPEED);
	
		
	# flip object
	if self.position.x > player.position.x:
		anim.scale.x = 1;
	elif position.x < player.position.x:
		anim.scale.x = -1;	
		
	
	move_and_slide() # kết thúc hàm có hàm này để sprite di chuyển	

# death erea
func _on_area_death_body_entered(body):
	if body.name == "Player":
		flag_player_death = true
	pass # Replace with function body.

# detec
func _on_area_detect_body_entered(body):
	if body.name == "Player":
		flag_detect_player = true;
	pass # Replace with function body.

# detec
func _on_area_detect_body_exited(body):
	if body.name == "Player":
		flag_detect_player = false;
	pass # Replace with function body.


func reload():
	get_tree().change_scene_to_file("res://Scene/Worlds/World_1.tscn")

