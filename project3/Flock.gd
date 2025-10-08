extends Node2D
# Manager that spawns boids and provides neighbor queries + a simple chase trigger.

@export var boid_scene: PackedScene
@export var initial_count: int = 30

# chase parameters (used later for the player-chase mechanic)
@export var chase_duration: float = 3.0
@export var chase_trigger_radius: float = 400.0
@export var chase_strength: float = 2.0

var boids: Array = []
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

# runtime chase state
var chasing: bool = false
var chase_target = null
var _chase_timer: float = 0.0

func _ready() -> void:
	rng.randomize()
	if boid_scene == null:
		push_error("Flock: please assign boid_scene in the Inspector (res://Boid.tscn)")
		return

	# spawn a grid-ish mix of boids across the viewport
	var rect = get_viewport().get_visible_rect()
	for i in initial_count:
		_spawn_boid(rect)

func _process(delta: float) -> void:
	if chasing:
		_chase_timer -= delta
		if _chase_timer <= 0.0:
			chasing = false
			chase_target = null

	# Optional leader-follow mechanic
	if boids.size() > 1:
		var leader = boids[0]
		for b in boids:
			if b == leader:
				continue
			var to_leader = (leader.global_position - b.global_position).normalized()
			b.acceleration += to_leader * 5.0 * delta  # gentle pull toward leader

# spawn helper
func _spawn_boid(rect: Rect2) -> void:
	var b = boid_scene.instantiate()
	add_child(b)
	# random position inside the visible rect
	b.global_position = Vector2(rng.randf_range(0, rect.size.x), rng.randf_range(0, rect.size.y))
	# give boid a back-reference for neighbor queries & chase info
	b.manager = self
	boids.append(b)

# Called by boids to get neighbors
func get_neighbors(source_boid, radius: float) -> Array:
	var res: Array = []
	for b in boids:
		if b == source_boid:
			continue
		if b.global_position.distance_to(source_boid.global_position) <= radius:
			res.append(b)
	return res

# Public: trigger a chase toward a target node for a period (call from Player or signal)
func trigger_chase(target_node, duration: float = -1.0) -> void:
	chase_target = target_node
	chasing = true
	_chase_timer = duration if duration > 0 else chase_duration
