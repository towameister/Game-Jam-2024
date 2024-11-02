extends Node

@export var max_hp = 100
@export var current_hp = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event: InputEvent):
		if Input.is_action_pressed("life_up"):
			LowerHealth()
		if Input.is_action_pressed("life_down"):
			IncreaseHealth()
			
func LowerHealth():
	current_hp -= 1
	SetHealthBar()
	

func IncreaseHealth():
	current_hp += 1
	SetHealthBar()
	
func SetHealthBar():
	$HealthBarLabel.text = "currentHealth / maxHealth"
	$HealthBar.
