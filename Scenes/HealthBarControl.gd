extends Node

@export var max_hp = 100
@export var min_hp = 0
@export var current_hp = 100

func _ready():
	SetHealthBar()
	
func _input(event: InputEvent):
		if Input.is_action_pressed("life_up"):
			LowerHealth()
		if Input.is_action_pressed("life_down"):
			IncreaseHealth()
			
func LowerHealth():
	if current_hp > min_hp:
		current_hp -= 1
		SetHealthBar()
	

func IncreaseHealth():
	current_hp += 1
	SetHealthBar()
	
func SetHealthBar():
	# Access the HealthBarLabel and HealthBar nodes directly
	var health_bar_label = get_node_or_null("HealthBarLabel")
	var health_bar = get_node_or_null("HealthBar")

	if health_bar_label and health_bar:  # Ensure nodes exist
		health_bar_label.text = str(current_hp) + " / " + str(max_hp)
		health_bar.max_value = max_hp
		health_bar.value = current_hp
