# based on a script by DevWorm
extends CharacterBody2D

@export var speed = 100
@export var jump_vel = 450.0

@export var player: Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

@onready var player_scanner := $PlayerScanner as RayCast2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var can_see_player = false

func _physics_process(delta):
	
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity.x = dir.x * speed
	
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y += jump_vel * dir.y
		
	move_and_slide()
	
func make_path():
	nav_agent.target_position = player.global_position


func _on_timer_timeout():
	scan_for_player()
	if can_see_player:
		make_path()

func scan_for_player():
	can_see_player = false
	player_scanner.target_position = player_scanner.to_local(player.global_position)
	
	if player_scanner.is_colliding():
		if player_scanner.get_collider() == player:
			var player_dist = player_scanner.get_collision_point() - player_scanner.global_position
			if player_dist.length() < 256:
				can_see_player = true
		

