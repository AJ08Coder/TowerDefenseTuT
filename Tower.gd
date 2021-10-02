extends Node2D

onready var Tower = $Tower
onready var TowerHead = $Tower_Head
var bullet = preload("res://Bullet.tscn")

var enemies = []

var building = true
var canPlace = false

var current_enemy

func _physics_process(delta):
	if building == false:
		$Range.visible = false
		if enemies != []:
			current_enemy = enemies[0]
			TowerHead.look_at(current_enemy.global_position)
	else:
		$Range.visible = true
		global_position = get_global_mouse_position()
		if canPlace == true:
			$Range.modulate = Color(0,0,0)
			if Input.is_action_just_pressed("click"):
				building = false
				get_parent().tower_built()
		else:
			$Range.modulate =  Color(1, 1, 1)
		

func _on_Sight_area_entered(area):
	if area.is_in_group("Enemy"):
		if building == false:
			enemies.append(area)


func _on_Sight_area_exited(area):
	if area.is_in_group("Enemy"):
		if building == false:
			enemies.erase(area)



func _on_ShootTimer_timeout():
	if building == false:
		if current_enemy:
			if enemies:
				if current_enemy == enemies[0]:
					var b = bullet.instance()
					b.global_position = global_position
					b.target = current_enemy
					get_parent().add_child(b)
				


func _on_Placement_area_entered(area):
	if area.is_in_group("AddPlatform"):
		if building == true:
			canPlace = true


func _on_Placement_area_exited(area):
	if area.is_in_group("AddPlatform"):
		if building == true:
			canPlace = false
