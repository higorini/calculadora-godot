extends Control

@onready var display_text: Label = get_node("Background/Display/Text")

var number_1: String
var number_2: String
var operator: String = ""
var index: int = 0

func _ready() -> void:
	display_text.text = "0"
	
	for button in get_tree().get_nodes_in_group("button"):
		button.pressed.connect(is_pressed.bind(button.name))


func is_pressed(button_name: String) -> void:
	match button_name:
		"Reset":
			reset(true)
			
		
		"=":
			var value_1: int = int(number_1)
			var value_2: int = int(number_2)
			var result: int = 0
			
			match operator:
				"+":
					result = value_1 + value_2
					
				"-":
					result = value_1 - value_2
					
				"/":
					@warning_ignore("integer_division")
					result = value_1 / value_2
					
				"*":
					result = value_1 * value_2
					
			display_text.text = str(result)
			reset()
		
		"Add":
			change_operator("+")
		
		"Sub":
			change_operator("-")
		
		"Div":
			change_operator("/")
		
		"Mul":
			change_operator("*")
		
		_:
			if index == 0:
				number_1 += button_name
				
				if operator == "":
					display_text.text = number_1
				
			if index == 1:
				number_2 += button_name
				
				display_text.text = number_1 + " " + operator + " " + number_2
				
func reset(is_reseting: bool = false) -> void:
	number_1 = ""
	number_2 = ""
	operator = ""
	index = 0
	
	if is_reseting:
		display_text.text = "0"
		
func change_operator(sig: String) -> void:
	if number_1 == "" or operator != "":
				return
			
	operator = sig
	index = 1
	display_text.text = number_1 + " " + operator
