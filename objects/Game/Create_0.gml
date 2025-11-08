randomize();
self.seed = irandom_range(1,999999999);
random_set_seed(self.seed);
//self.seed = 344574555;
show_debug_message($"Seed: {self.seed}");

self.fsm = new StateMachine();
self.fsm.add("Title", {
	enter: function() {
	},
	step: function() {
	},
	leave: function() {
	},
});
self.fsm.add("Playing", {
	enter: function() {
	},
	step: function() {
	},
	leave: function() {
	},
});
self.fsm.add("Paused", {
	enter: function() {
	},
	step: function() {
	},
	leave: function() {
	},
});
self.fsm.init("Playing");

self.spawn = function(_spawn_zone, _class, _objects, _num, _spacing=0, _limit_to_num=true) {
	var _current_count = 0;
	for (var _i=0, _n=array_length(_objects); _i<_n; _i++) {
		_current_count += instance_number(_objects[_i]);
	}
	
	var _total = _limit_to_num ? max(0, _num - _current_count) : _num;
	repeat(_total) {		
		var _zone = instance_find(_spawn_zone, irandom_range(0, instance_number(_spawn_zone)-1));
		var _x0 = _zone.x;
		var _y0 = _zone.y;
		var _x1 = _zone.x + _zone.sprite_width;
		var _y1 = _zone.y + _zone.sprite_height;
		
		var _obj = array_random(_objects);
		var _id = instance_create_layer(0, 0, "lyr_Instances", _obj);
			
		with (_id) {
			do {
				self.x = irandom_range(_x0, _x1);
				self.y = irandom_range(_y0, _y1);
			}
			until (collision_rectangle(self.bbox_left-_spacing, self.bbox_top-_spacing, self.bbox_right+_spacing, self.bbox_bottom+_spacing, _class, false, true) == noone);
		}
			
	}
		
	with (_class) {
		self.depth = -self.bbox_bottom;
	}
}

self.hour_length_frames = 60 * 3;
self.hour_length_frames_speedup = 30;
self.hour = 6;
self.advance_clock = function() {

	self.hour = (self.hour+1) % 24;
	if (self.hour == 0) {
		
		// Clear stumps
		with (cls_Tree) {
			if (self.fsm.get_current_state_name() == "stump") instance_destroy();
		}
		
		// Spawn trees
		self.spawn(obj_Spawn_Trees, cls_Tree, [obj_Tree_Pine, obj_Tree_Round], 15, 10, true);
		
		// Spawn animals
		self.spawn(obj_Spawn_Animals, cls_Animal, [obj_Chicken], 2, 4, true);
		self.spawn(obj_Spawn_Animals, cls_Animal, [obj_Cow], 2, 4, true);
		self.spawn(obj_Spawn_Animals, cls_Animal, [obj_Pig], 2, 4, true);
		self.spawn(obj_Spawn_Animals, cls_Animal, [obj_Sheep], 2, 4, true);
	}
	
};

self.ts = time_source_create(time_source_game, self.hour_length_frames, time_source_units_frames, self.advance_clock, [], -1, time_source_expire_nearest);
time_source_start(self.ts);

self.day_overlay = [
    { color: #020816, alpha: 0.80 },
    { color: #030A1A, alpha: 0.80 },
    { color: #040D21, alpha: 0.78 },
    { color: #051028, alpha: 0.76 },
    { color: #071433, alpha: 0.72 },
    { color: #101C40, alpha: 0.65 },
    { color: #F6A354, alpha: 0.35 },
    { color: #FFD08A, alpha: 0.25 },
    { color: #FFE5B2, alpha: 0.15 },
    { color: #FFF5D7, alpha: 0.08 },
    { color: #FFFFFF, alpha: 0.04 },
    { color: #FFFFFF, alpha: 0.02 },
    { color: #FFFFFF, alpha: 0.00 },
    { color: #FFF7E0, alpha: 0.02 },
    { color: #FFE7B8, alpha: 0.05 },
    { color: #FFD08A, alpha: 0.10 },
    { color: #FFB56A, alpha: 0.16 },
    { color: #FF9A54, alpha: 0.24 },
    { color: #F5794F, alpha: 0.32 },
    { color: #D45B6B, alpha: 0.42 },
    { color: #3B3260, alpha: 0.55 },
    { color: #232542, alpha: 0.66 },
    { color: #11152B, alpha: 0.74 },
    { color: #060A19, alpha: 0.80 }
];

draw_set_font(fnt_UI);