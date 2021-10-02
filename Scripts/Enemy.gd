extends PathFollow2D


var health = 5
var speed = 30


func _process(delta):
	
	offset += speed *delta
	
	if offset >= 10000:
		queue_free()

func _on_Enemy_area_entered(area):
	if area.is_in_group("Projectile"):
		area.queue_free()
		health -= 1
		if health <= 0:
			get_parent().get_parent().money += 10
			queue_free()
