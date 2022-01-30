extends PopupPanel

onready var Jam1 = $TextureRect/Bowser/Jams/Jams/Jam1
onready var Jam2 = $TextureRect/Bowser/Jams/Jams/Jam2
onready var Jam3 = $TextureRect/Bowser/Jams/Jams/Jam3
onready var Jam = $TextureRect/Bowser/Jams/Jams/Jam
onready var JamInfo = $TextureRect/Bowser/Jams/Info/JamInfo
onready var JamCover = $TextureRect/Bowser/Jams/Info/JamCover
onready var Play = $TextureRect/Play
onready var player1 = $TextureRect/Bowser/Responsavel/HBoxContainer/Player/Player1
onready var player2 = $TextureRect/Bowser/Responsavel/HBoxContainer/Player/Player2
onready var player3 = $TextureRect/Bowser/Responsavel/HBoxContainer/Player/Player3
onready var preview = $TextureRect/Bowser/Responsavel/HBoxContainer/Player/Player/Sprite
onready var hp = $TextureRect/Bowser/Responsavel/HBoxContainer/Info/GridContainer/Hp
onready var buy_hp = $TextureRect/Bowser/Responsavel/HBoxContainer/Info/GridContainer/BuyHp
onready var mp = $TextureRect/Bowser/Responsavel/HBoxContainer/Info/GridContainer/Mp
onready var buy_mp = $TextureRect/Bowser/Responsavel/HBoxContainer/Info/GridContainer/BuyMp
onready var special = $TextureRect/Bowser/Responsavel/HBoxContainer/Info/GridContainer/Special
onready var buy_special = $TextureRect/Bowser/Responsavel/HBoxContainer/Info/GridContainer/BuySpecial
onready var experience = $TextureRect/Bowser/Responsavel/HBoxContainer/Info/TotalXp
onready var damage = $TextureRect/Bowser/Responsavel/HBoxContainer/Info/GridContainer/Damage
onready var buy_damage = $TextureRect/Bowser/Responsavel/HBoxContainer/Info/GridContainer/BuyDamage

var has_special = false

var boss_selection = false
var player_selection = false
var tab = 1
var price = 100

func _ready():
	randomize()
	Jam1.grab_focus()
	Play.hide()
	hp.text = "hp :"+ str(GAME.player_hp)
	mp.text = "mp :" + str(GAME.player_mp)
	damage.text = "Dano: "+str(GAME.player_damage)
	buy_hp.text = "preço :"+str(price)+" xp"
	buy_mp.text = "preço :"+str(price*3/10)+" xp"
	buy_damage.text = "preço :"+str(price*5/10)+" xp"
	buy_special.text = "preço :"+str(price)+" xp"
	special.text = "Não tem"
	experience.text = "Exp: " + str(GAME.xp)
	if (GAME.week%4) == 0:
		Jam1.disabled = false
	if (GAME.week%7) == 0:
		Jam2.disabled = false
	if (GAME.week%10) == 0:
		Jam3.disabled = false

func _process(delta):
	show_info()
	
	show_player()

func show_player():
	if player1 == get_focus_owner():
		preview.play("1")
	if player2 == get_focus_owner():
		preview.play("2")
	if player3 == get_focus_owner():
		preview.play("3")


func show_info():
	if Jam == get_focus_owner():
		JamInfo.text = Jam.info
		JamCover.texture = load(Jam.cover)
	if Jam1 == 	get_focus_owner():
		JamInfo.text = Jam1.info
		JamCover.texture = load(Jam1.cover)
	if Jam2 == 	get_focus_owner():
		JamInfo.text = Jam2.info
		JamCover.texture = load(Jam2.cover)
	if Jam3 == 	get_focus_owner():
		JamInfo.text = Jam3.info
		JamCover.texture = load(Jam3.cover)


func _on_Jam1_pressed():
	GAME.boss = 0
	boss_selection = true
	$TextureRect/Bowser.current_tab = 1
	can_play()

func _on_Jam2_pressed():
	GAME.boss = 1
	boss_selection = true
	$TextureRect/Bowser.current_tab = 1
	can_play()

func _on_Jam3_pressed():
	GAME.boss = 2
	boss_selection = true
	$TextureRect/Bowser.current_tab = 1
	can_play()

func _on_Button_pressed():
	GAME.player = 0
	player_selection = true
	can_play()

func _on_Button2_pressed():
	GAME.player = 1
	player_selection = true
	can_play()
	
func _on_Button3_pressed():
	GAME.player = 2
	player_selection = true
	can_play()

func _on_Play_pressed():
	if GAME.boss == 0:
		get_tree().change_scene("res://Scenes/GMTKactus_boss_scene.tscn")
	elif GAME.boss == 1:
		get_tree().change_scene("res://Scenes/Ludum_Dario_boss_scene.tscn")
	elif GAME.boss == 2:
		get_tree().change_scene("res://Scenes/Amdre_boss_scene.tscn")
	elif GAME.boss == 5:
		var jamnumb = int(rand_range(1,6))
		print(jamnumb)
		var clube = "res://Scenes/generic_jams/Mentirinha%s.tscn" % jamnumb
		get_tree().change_scene("res://Scenes/generic_jams/Mentirinha%s.tscn" % jamnumb)

func can_play():
	if player_selection and boss_selection:
		Play.show()


func _on_BuyHp_pressed():
	if GAME.xp >= price:
		GAME.xp-=price
		GAME.player_hp+= 10
		hp.text = "hp :"+ str(GAME.player_hp)
		experience.text = "Exp: " + str(GAME.xp)


func _on_BuyMp_pressed():
	if GAME.xp >= price*0.3:
		GAME.xp-=price*0.3
		GAME.player_mp+= 10
		mp.text = "mp :" + str(GAME.player_mp)
		experience.text = "Exp: " + str(GAME.xp)


func _on_BuySpecial_pressed():
	if GAME.xp >= price:
		GAME.xp-=price
		special.text = "Tem"
		experience.text = "Exp: " + str(GAME.xp)
		buy_special.disabled = true


func _on_BuyDamage_pressed():
	if GAME.xp >= price*0.5:
		GAME.xp-=price*0.5
		GAME.player_damage+= 2
		damage.text = "mp :" + str(GAME.player_damage)
		experience.text = "Exp: " + str(GAME.xp)


func _on_Jam_pressed():
	GAME.boss = 5
	$TextureRect/Bowser.current_tab = 1
	boss_selection = true
	can_play()
