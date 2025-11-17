extends Node


var vaw_form : String = "norm"

var world_map_dirs: Array = []
var level = 0
var lvl_selected = false
var water_lvl = "" # always only set to "" or "_w"
var completed_lvls = []
var is_transitioning = false

var mins = 0
var secs = 0

var dying = false
var respawning = false

var wm_hovering = 0

var lvl_names: Array = ["Glass Bridge","Ruined Skyline","lvl 3 is rly cool trust"]

#region Feather vars

@onready var feathers_collected = 0

@onready var feather_lvl_1 = false
@onready var feather_lvl_2 = false
@onready var feather_lvl_3 = false
@onready var feather_lvl_4 = false
@onready var feather_lvl_5 = false
@onready var feather_lvl_6 = false
@onready var feather_lvl_7 = false
@onready var feather_lvl_8 = false
@onready var feather_lvl_9 = false
@onready var feather_lvl_10 = false
@onready var feather_lvl_11 = false
@onready var feather_lvl_12 = false
@onready var feather_lvl_13 = false
@onready var feather_lvl_14 = false
@onready var feather_lvl_15 = false
@onready var feather_lvl_16 = false

#endregion
