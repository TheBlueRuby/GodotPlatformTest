extends CharacterBody2D

@export var speed = 150.0
@export var jump_vel = -500.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var hitbox = $CollisionShape2D
@onready var texture = hitbox.get_node("Texture")

@onready var front_sprite = load("res://Images/player/front.png")
@onready var side_sprite = load("res://Images/player/side.png")
@onready var front_hitbox = load("res://Polygons/Collision/player_front.tres")
@onready var side_hitbox = load("res://Polygons/Collision/player_side.tres")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_vel

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	if velocity.x == 0:
		set_facing("front")
	else:
		if velocity.x < 0:
			set_facing("left")
		else:
			set_facing("right")

	move_and_slide()

func set_facing(side):
	match side:
		"front":
			hitbox.scale.x =  1
			texture.texture = front_sprite
			hitbox.shape = front_hitbox
		"left":
			hitbox.scale.x =  -1
			texture.texture = side_sprite
			hitbox.shape = side_hitbox
		"right":
			hitbox.scale.x =  1
			texture.texture = side_sprite
			hitbox.shape = side_hitbox
