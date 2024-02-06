# based on a script by DevWorm
extends CharacterBody2D

@export var speed = 100
@export var jump_vel = 350.0

@export var player: Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

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
	make_path()
