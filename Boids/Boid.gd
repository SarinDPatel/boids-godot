extends CharacterBody2D
class_name Boid

const SPEED = 100

@export var pause_time:bool = false
var initialDir = Vector2.UP 


# Called when the node enters the scene tree for the first time.
func _ready():
	var x_pos = randi_range(120,1080)
	var y_pos = randi_range(120,600)
	#x_vel = randf_range(-1,1)
	#y_vel = randf_range(-1,1)
	position = Vector2(x_pos,y_pos)
	pick_color()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var dir = velocity.normalized()
	#var newDir = initialDir-dir
	#look_at(newDir)
	#look_at(dir)
	#rotate(PI/4)
	
	#initialDir = newDir
	if not pause_time:
		position += velocity
		
	#var target = get_local_mouse_position() 
	#velocity = global_position.direction_to(target) * SPEED * delta
	#
	#if global_position.distance_to(target) > 10:
		#position += velocity
	


#func _draw():
	#draw_line(position, velocity*2, Color.YELLOW, 50)
	#
	
func pick_color():
	#var cyan = 00ffd6
	var r = randf()
	var g = randf()
	var b = randf()
	var alpha = 0.5
	modulate = Color(r,g,b,alpha)
