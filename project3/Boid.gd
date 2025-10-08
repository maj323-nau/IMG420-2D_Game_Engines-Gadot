extends Node2D

@export var max_speed: float = 90.0
@export var max_force: float = 80.0

@export var neighbor_radius: float = 140.0
@export var separation_radius: float = 45.0

@export var alignment_weight: float = 1.0
@export var cohesion_weight: float = 0.9
@export var separation_weight: float = 1.8

var manager = null
var velocity: Vector2 = Vector2.ZERO
var acceleration: Vector2 = Vector2.ZERO

func _ready() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	velocity = Vector2(rng.randf_range(-1.0, 1.0), rng.randf_range(-1.0, 1.0))
	if velocity.length() == 0:
		velocity = Vector2.RIGHT
	velocity = velocity.normalized() * (max_speed * 0.5)

func _physics_process(delta: float) -> void:
	var neighbors: Array = []
	if manager:
		neighbors = manager.get_neighbors(self, neighbor_radius)

	var sep = _separation(neighbors) * separation_weight
	var ali = _alignment(neighbors) * alignment_weight
	var coh = _cohesion(neighbors) * cohesion_weight

	var steer = sep + ali + coh

	# Optional chase mechanic
	if manager and manager.chasing and manager.chase_target:
		var to_target = manager.chase_target.global_position - global_position
		if to_target.length() <= manager.chase_trigger_radius:
			var desired = to_target.normalized() * max_speed
			steer += (desired - velocity) * manager.chase_strength

	# Subtle random wander for variety
	var jitter = Vector2(randf() - 0.5, randf() - 0.5).normalized() * 5.0
	steer += jitter

	# Apply steering
	acceleration = _clamp_vector(steer, max_force)
	velocity += acceleration * delta

	# Smooth velocity to encourage unification
	velocity = velocity.lerp(_clamp_vector(velocity, max_speed), 0.05)
	velocity = _clamp_vector(velocity, max_speed)

	global_position += velocity * delta

	if velocity.length() > 0.1:
		rotation = velocity.angle()

	_wrap_around_viewport()
	queue_redraw()

# --- helper to clamp a vector's length ---
func _clamp_vector(v: Vector2, max_len: float) -> Vector2:
	var l = v.length()
	if l == 0.0:
		return v
	if l > max_len:
		return v.normalized() * max_len
	return v

# --- Behaviors ---
func _separation(neighbors: Array) -> Vector2:
	var steer = Vector2.ZERO
	var count = 0
	for n in neighbors:
		var d = global_position.distance_to(n.global_position)
		if d > 0 and d < separation_radius:
			var diff = (global_position - n.global_position).normalized()
			diff /= max(d, 0.001)
			steer += diff
			count += 1
	if count > 0:
		steer /= count
		steer = steer.normalized() * max_speed
		steer = _clamp_vector(steer - velocity, max_force)
	return steer

func _alignment(neighbors: Array) -> Vector2:
	if neighbors.is_empty():
		return Vector2.ZERO
	var avg = Vector2.ZERO
	for n in neighbors:
		avg += n.velocity
	avg /= neighbors.size()
	if avg.length() == 0:
		return Vector2.ZERO
	var desired = avg.normalized() * max_speed
	return _clamp_vector(desired - velocity, max_force)

func _cohesion(neighbors: Array) -> Vector2:
	if neighbors.is_empty():
		return Vector2.ZERO
	var center = Vector2.ZERO
	for n in neighbors:
		center += n.global_position
	center /= neighbors.size()
	var desired = (center - global_position)
	if desired.length() == 0:
		return Vector2.ZERO
	desired = desired.normalized() * max_speed
	return _clamp_vector(desired - velocity, max_force)

func _wrap_around_viewport() -> void:
	var rect = get_viewport().get_visible_rect()

	if global_position.x < 0:
		global_position.x = rect.size.x
	elif global_position.x > rect.size.x:
		global_position.x = 0
	if global_position.y < 0:
		global_position.y = rect.size.y
	elif global_position.y > rect.size.y:
		global_position.y = 0

func _draw() -> void:
	# Draw a faint circle to show neighbor detection
	draw_circle(Vector2.ZERO, neighbor_radius, Color(0, 0.5, 1, 0.15))
