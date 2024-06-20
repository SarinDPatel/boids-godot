extends Node2D
@export var BoidTemplate:PackedScene
var boids = []  

const CLOSE_RANGE = 8
const AVOID_FACTOR = 0.01
const VISBLE_RANGE = 20
const MATCHING_FACTOR = 0.005
const CENTERING_FACTOR = 0.0001
const TURN_FACTOR = 0.2
const LEFT_MARGIN = 120
const RIGHT_MARGIN = 1060
const TOP_MARGIN = 120
const BOTTOM_MARGIN = 600
const MAX_SPEED = 10
const MIN_SPEED = 5


# Called when the node enters the scene tree for the first time.
func _ready():
	#Initialize boids
	for i in range(1):
		var boid = BoidTemplate.instantiate()
		boid.name = "Boid_" + str(i)
		add_child(boid)
		boid.add_to_group("Boids")
		#get_tree().call_group("Boids", "pick_color")
	boids = get_tree().get_nodes_in_group("Boids")
	
	print_debug(boids)
	print_tree_pretty()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	#Separation 
	var close_dx = 0
	var close_dy = 0
	#Alignment
	var x_vel_avg = 0
	var y_vel_avg = 0
	var neighbouring_boids = 0
	#Cohesion
	var x_pos_avg = 0
	var y_pos_avg = 0

	for bird in boids:
		for other_bird in boids:
			if bird == other_bird:
				continue
			var distance_squared = (bird.position.x - other_bird.position.x)**2 + (bird.position.y - other_bird.position.y)**2
			if distance_squared < CLOSE_RANGE**2:
				close_dx += bird.position.x - other_bird.position.x
				close_dy += bird.position.y - other_bird.position.y
		
			if distance_squared < VISBLE_RANGE**2:
				x_vel_avg += other_bird.velocity.x
				y_vel_avg += other_bird.velocity.y
				x_pos_avg += other_bird.position.x
				y_pos_avg += other_bird.position.y
				neighbouring_boids += 1
	
		bird.velocity.x += close_dx*AVOID_FACTOR
		bird.velocity.y += close_dy*AVOID_FACTOR
	
		if neighbouring_boids > 0:
			x_vel_avg = x_vel_avg/neighbouring_boids
			y_vel_avg = y_vel_avg/neighbouring_boids
			x_pos_avg = x_pos_avg/neighbouring_boids
			y_pos_avg = y_pos_avg/neighbouring_boids
			
		bird.velocity.x += (x_vel_avg - bird.velocity.x)*MATCHING_FACTOR
		bird.velocity.y += (y_vel_avg - bird.velocity.y)*MATCHING_FACTOR
		bird.velocity.x += (x_pos_avg - bird.position.x)*CENTERING_FACTOR
		bird.velocity.y += (y_pos_avg - bird.position.y)*CENTERING_FACTOR
	#
		if bird.position.x < LEFT_MARGIN:
			bird.velocity.x += TURN_FACTOR
		if bird.position.x > RIGHT_MARGIN:
			bird.velocity.x -= TURN_FACTOR
		if bird.position.y > BOTTOM_MARGIN:
			bird.velocity.y -= TURN_FACTOR
		if bird.position.y < TOP_MARGIN:
			bird.velocity.y += TURN_FACTOR
	#
		var speed_squared = bird.velocity.x**2 + bird.velocity.y**2
		if speed_squared>MAX_SPEED**2:
			bird.velocity.x = (bird.velocity.x/sqrt(speed_squared))*MAX_SPEED
			bird.velocity.y = (bird.velocity.y/sqrt(speed_squared))*MAX_SPEED
		if speed_squared<MIN_SPEED**2:
			bird.velocity.x = (bird.velocity.x/sqrt(speed_squared))*MIN_SPEED
			bird.velocity.y = (bird.velocity.y/sqrt(speed_squared))*MIN_SPEED
	
#func _draw():
	#var rect = Rect2(Vector2(120,120),Vector2(1080-120,600-120))
	#draw_rect(rect, Color.YELLOW, true, 0.25)
'''

def update(boids:list[Bird]):
	CLOSE_RANGE = 0.2
	AVOID_FACTOR = 2.0
	VISBLE_RANGE = 0.5
	MATCHING_FACTOR = 1.5
	CENTERING_FACTOR = 1.0
	TURN_FACTOR = 0.2
	LEFT_MARGIN, RIGHT_MARGIN, TOP_MARGIN, BOTTOM_MARGIN = 100
	MAX_SPEED = 2
	MIN_SPEED = 0.75    
	
	for bird in boids:
		close_dx, close_dy, x_vel_avg, y_vel_avg, neighbouring_boids, x_pos_avg, y_pos_avg = 0
	
		for other_bird in boids:
			if bird == other_bird:
				continue
			
			distance_squared = (bird.position.x - other_bird.position.x)**2 + (bird.position.y - other_bird.position.y)**2
			if distance_squared < CLOSE_RANGE**2:
				close_dx += bird.position.x - other_bird.position.x
				close_dy += bird.position.y - other_bird.position.y
		
			if distance_squared < VISBLE_RANGE**2:
				x_vel_avg += other_bird.velocity.x
				y_vel_avg += other_bird.velocity.y
				x_pos_avg += other_bird.position.x
				y_pos_avg += other_bird.position.y
				neighbouring_boids += 1

		bird.velocity.x += close_dx*AVOID_FACTOR
		bird.velocity.y += close_dy*AVOID_FACTOR
		
		if neighbouring_boids > 0:
			x_vel_avg = x_vel_avg/neighbouring_boids
			y_vel_avg = y_vel_avg/neighbouring_boids
			x_pos_avg = x_pos_avg/neighbouring_boids
			y_pos_avg = y_pos_avg/neighbouring_boids
			
		bird.velocity.x += (x_vel_avg - bird.velocity.x)*MATCHING_FACTOR
		bird.velocity.y += (y_vel_avg - bird.velocity.y)*MATCHING_FACTOR
		bird.velocity.x += (x_pos_avg - bird.position.x)*CENTERING_FACTOR
		bird.velocity.y += (y_pos_avg - bird.position.y)*CENTERING_FACTOR
		
		if bird.position.x < LEFT_MARGIN:
			bird.velocity.x = bird.velocity.x + TURN_FACTOR
		if bird.position.x > RIGHT_MARGIN:
			bird.velocity.x = bird.velocity.x - TURN_FACTOR
		if bird.position.y > BOTTOM_MARGIN:
			bird.velocity.y = bird.velocity.y - TURN_FACTOR
		if bird.position.y < TOP_MARGIN:
			bird.velocity.y = bird.velocity.y + TURN_FACTOR

		speed_squared = bird.velocity.x**2 + bird.velocity.y**2
		if speed_squared>MAX_SPEED**2:
			bird.velocity.x = (bird.velocity.x/math.sqrt(speed_squared))*MAX_SPEED
			bird.velocity.y = (bird.velocity.y/math.sqrt(speed_squared))*MAX_SPEED
		if speed_squared<MIN_SPEED**2:
			bird.velocity.x = (bird.velocity.x/math.sqrt(speed_squared))*MIN_SPEED
			bird.velocity.y = (bird.velocity.y/math.sqrt(speed_squared))*MIN_SPEED



if __name__ == "__main__":
	boids = []
	#Initialize 20-ish boids
	for i in range(20):
		b = Bird(0,0,0,0)
		boids.append(b)
	
	while(True):
		update(boids)

	
'''
