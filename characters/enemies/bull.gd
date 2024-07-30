extends enemy_class

var dashing = false
var velocity = Vector2.ZERO
var player_attraction = 15
var max_velocity = 15
var center_attraction = 0.7
var rotation_speed = 3
var speed = 100
var start_velocity = 8
var dash_dmg = 30

func ready():
	light_dmg *= 0.7
	scorch_dmg *= 1.5

func start_dash():
	if can_attack:
		dashing = true
	$dash_duration.start()
	$attack.show()
	velocity = Vector2.RIGHT.rotated(rotation) * start_velocity

func stop_dash():
	velocity = Vector2.ZERO
	dashing = false
	$attack.hide()
	$walk_duration.start()
	$dash_duration.stop()

func process(delta):
	if not can_attack and not $dash_duration.is_stopped():
		stop_dash()
	if dashing:
		dash(delta)
	else:
		walk(delta)
	if $dash_duration.is_stopped() and $walk_duration.is_stopped():
		start_dash()

func walk(delta):
	rotation = lerp(rotation, global_position.direction_to(player.global_position).angle(),rotation_speed*delta)
	global_position += Vector2.RIGHT.rotated(rotation)*delta*get_speed(speed)

func dash(delta):
	velocity -= (global_position-player.global_position).normalized() * get_speed(player_attraction) * delta\
	+ (global_position-tilemap.sun.center).normalized() * get_speed(center_attraction)**2\
	* (global_position-tilemap.sun.center).length() ** 0.5 * delta
	var diff = velocity.length()/max_velocity
	if diff > 1:
		velocity /= diff
		
	global_position += (get_speed(velocity)+velocity)*0.5
	rotation = velocity.angle()
	#$Progress_bar.global_rotation = 0


func area_entered(area):
	var target = area.get_parent()
	target.get_damage(dash_dmg)
	get_damage(2)
