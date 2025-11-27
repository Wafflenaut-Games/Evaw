extends Node


signal level_end()


var vaw_form : String = "norm"

var world_map_dirs: Array = []
var level = 0
var lvl_selected = false
var lvl_completed = 0
var water_lvl = "" # always only set to "" or "_w"
var ice_lvl = false
var completed_lvls = []
var is_transitioning = false

var mins = 0
var secs = 0

var dying = false
var death_count = 0
var respawning = false
var paused = false

var vol = 10
var difficulty: float = 2

var wm_hovering = 0

var f = "bro forgot to name ts lvl"

var lvl_names: Array = ["Glass Bridge","Ruined Skyline","Jungle of Thorns", f, f, f, f, f, f, f, f, f, f, f, f, f, f,]

#region Feather vars

@onready var feathers_collected = 0

@onready var feathers_holding = 0

@onready var feather_lvl_1 = false
@onready var feather_lvl_2 = false
@onready var feather_lvl_3 = false
@onready var feather_lvl_4_1 = false
@onready var feather_lvl_4_2 = false
@onready var feather_lvl_4_3 = false
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
