extends Node

onready var http : HTTPRequest = $HTTPRequest

#Variables
var totalQn = 1 #Total No of Qn
var newQnSet
var qnList
var Question := {
	"QuestionText":{},
	"Option1":{},
	"Option2":{},
	"Option3":{},
	"Option4":{},
	"Ans":{}
}

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayBoard/MarginContainer/VBoxContainer/Label.set_text(global.worldSelected)

	totalQn = 1 #Get total number of qns here
	$ConfirmButton/Label.set_text("Save") #Replace Edit Button with Confirm Button
	newQnSet = load("res://View/util/customQuestionSet.tscn") #Sets Merged scene as custom Qn Set
	qnList = $PlayBoard/MarginContainer/VBoxContainer/Container/QnList


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AddButton_pressed():
	totalQn +=1
	#Add new instance
	var addQn = newQnSet.instance()
	#Change Question Name with its number
	addQn.get_child(0).get_child(0).set_text("Qn #"+str(totalQn)+": ")
	#Add qn to the list
	qnList.add_child(addQn)
	$PopUpControl.show()
	



func _on_ConfirmButton_pressed():
	global.difficulty="Normal"
	var getQuestions=global.difficulty+"World"+global.worldSelected.substr(7,1)
	for i in range(1,totalQn+1): #Loop For Total Number of Qn 
		print(i)
		var qnSet = qnList.get_child(i-1) #Save as qn set
		var qnTitle = qnSet.get_child(0).get_child(1).get_text() #Qn Title
		if qnTitle == "":
			continue
		var option1 = qnSet.get_child(1).get_child(1).get_text() #Option 1
		var option2 = qnSet.get_child(2).get_child(1).get_text() #Option 2
		var option3 = qnSet.get_child(3).get_child(1).get_text() #Option 3
		var option4 = qnSet.get_child(4).get_child(1).get_text() #Option 4
		var ans = qnSet.get_child(5).get_child(1).get_text() #Option 1
		#Set Question attributes
		Question.QuestionText={"stringValue": qnTitle}
		Question.Option1={"stringValue": option1}
		Question.Option2={"stringValue": option2}
		Question.Option3={"stringValue": option3}
		Question.Option4={"stringValue": option4}
		Question.Ans={"stringValue": ans}
		var format_string = "%s?documentId=DM-N-%s-R-%s"
		var random = int(floor(rand_range(0,100)))
		var actual_string = format_string % [getQuestions,global.worldSelected.substr(7,1),random]
		#http request to save the question
		Firebase.save_document(actual_string, Question, http)
		yield(get_tree().create_timer(2.0), "timeout")
		


func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	var result_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	print(result_body)
	print(response_code)
	match response_code:
		#error
		404:
			return
		#success
		200:
			return


func _on_BackButton_pressed():
	get_tree().change_scene("res://View/teachers/AddQnsSelectWorld.tscn")


func _on_QuitButton_pressed():
	$PopUpControl.hide()
