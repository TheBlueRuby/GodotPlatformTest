extends Camera2D

@export var target: Node2D

@export var still_width = 32
@export var still_height = 64

@export var speed = 150
@export var lerp_factor = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.x > (target.position.x + still_width):
		position.x -= speed * delta
	if position.x < (target.position.x - still_width):
		position.x += speed * delta
		
	if position.y > (target.position.y + still_height):
		position.y -= speed * delta
	if position.y < (target.position.y - still_height):
		position.y += speed * delta
		
	if position != target.position:
		position = position.lerp(target.position, delta * lerp_factor)
	
