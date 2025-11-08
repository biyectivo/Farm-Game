event_inherited();

self.stats = {
	spd: 1,
	hp: irandom_range(2,4)
};

self.facing = 0;
self.dir_h = undefined;
self.dir_v = undefined;
self.time_current_state = undefined;

self.update_facing = function() {
	var _prev_facing = self.facing;
	if (self.dir_h == 1)	self.facing = 0;
	if (self.dir_h == -1)	self.facing = 180;
	return self.facing != _prev_facing;
}

self.am = new SpriteManager();

self.am.add_state("idle",		"0",		self.sprite_index, 0, 1,8,,,true);
self.am.add_state("walk",		"0",		self.sprite_index, 0, ,8,,,true);
self.am.add_state("idle",		"180",		self.sprite_index, 0, 1,8);
self.am.add_state("walk",		"180",		self.sprite_index, 0, ,8);

self.fsm = new StateMachine();

self.fsm.add("idle", {
	enter: function() {
		self.am.set(self.fsm.get_current_state_name(), string(self.facing));
		self.time_current_state = random_range(1, 5) * 60;
	},
	step: function() {
		var _test = update_facing();
		if (_test) self.am.set(self.fsm.get_current_state_name(), string(self.facing));
	},
	leave: function() {
	},
});
self.fsm.add("walk", {
	enter: function() {
		self.am.set(self.fsm.get_current_state_name(), string(self.facing));
		self.time_current_state = random_range(0, 3) * 60;
		do {
			self.dir_h = choose(-1,0,1);
			self.dir_v = choose(-1,0,1);
		}
		until (self.dir_h != 0 || self.dir_v != 0);
	},
	step: function() {
		var _spd = self.stats.spd
		var _tilemap = layer_tilemap_get_id(layer_get_id("lyr_Tile_Collision"));
		var _collisions = [_tilemap, cls_Tree, cls_Collisionable];
		
		var _num_col = 0;
		if (place_meeting(self.x + _spd*self.dir_h, self.y, _collisions)) {
			_num_col++;
			while (!place_meeting(self.x + sign(_spd*self.dir_h), self.y, _collisions)) {
				self.x += sign(_spd*self.dir_h);
			}
		}
		else {
			self.x += _spd*self.dir_h;
		}
		
		if (place_meeting(self.x, self.y + _spd * self.dir_v, _collisions)) {
			_num_col++;
			while (!place_meeting(self.x, self.y + sign(_spd * self.dir_v), _collisions)) {
				self.y += sign(_spd * self.dir_v);
			}
		}
		else {
			self.y += _spd * self.dir_v;
		}
		
		
		
		var _test = update_facing();
		if (_test) self.am.set(self.fsm.get_current_state_name(), string(self.facing));
		
		if (_num_col == 2) self.time_current_state = 0;
	},
	leave: function() {
	},
});
self.fsm.add("hit", {
	enter: function() {
		self.am.set("idle", string(self.facing));
		self.time_current_state = 15;
	},
	step: function() {
		
	},
	leave: function() {
	},
});
self.fsm.add("die", {
	enter: function() {
		self.visible = false;
		if (self.gives != "") {
			//obj_Player.inventory_add(self.gives);
			var _dx = irandom_range(-5,5);
			var _dy = irandom_range(-5,5);
			instance_create_layer(obj_Player.x+_dx, obj_Player.y+_dy, "lyr_Crops", obj_Item, {item_name: self.gives})
		}
		call_later(5, time_source_units_frames, function() {
			instance_destroy();
		});
	},
	step: function() {
		
	},
	leave: function() {
	},
});

self.fsm.add_transition("idle", "walk", function() {
	return self.fsm.get_state_timer() >= self.time_current_state;
});
self.fsm.add_transition("walk", "idle", function() {
	return self.fsm.get_state_timer() >= self.time_current_state;
});
self.fsm.add_transition("hit", "walk", function() {
	return self.fsm.get_state_timer() >= self.time_current_state;
});
self.fsm.add_transition([], "die", function() {
	return self.stats.hp <= 0;
});

self.fsm.init("idle");