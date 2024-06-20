extends CharacterBody2D
class_name Boid

var x_pos:float
var y_pos:float
var x_vel:float
var y_vel:float
const SPEED = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	x_pos = randi_range(120,1080)
	y_pos = randi_range(120,600)
	#x_vel = randf_range(-1,1)
	#y_vel = randf_range(-1,1)
	position = Vector2(x_pos,y_pos)
	
	pick_color()
	 
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var dir = velocity.normalized()
	look_at(dir)
	rotate(PI/2)
	position += velocity
	#var target = get_local_mouse_position() 
	#velocity = global_position.direction_to(target) * SPEED * delta
	#
	#if global_position.distance_to(target) > 10:
		#position += velocity
		
		##Remove this when separation logic is done
		#move_and_slide()


func pick_color():
	#var cyan = 00ffd6
	var r = randf()
	var g = randf()
	var b = randf()
	var alpha = 0.5
	modulate = Color(r,g,b,alpha)
