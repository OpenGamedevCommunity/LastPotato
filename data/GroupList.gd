extends Resource
class_name GroupList

export (Array) var list:Array

func Add(inst:Node)->void:
	list.append(inst)

func Remove(inst:Node)->void:
	list.erase(inst)
