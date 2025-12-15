self.stats = {
	spd: 2,
};

self.hairstyle = "spikeyhair";


self.facing = 0;
self.update_facing = function() {
	var _prev_facing = self.facing;
	var _angle = point_direction(self.x, self.y, obj_Player.x, obj_Player.y);
	self.facing = _angle > 270 || _angle < 90 ? 0 : 180;
	return self.facing != _prev_facing;
}

self.am = new SpriteManager();

self.am.add_state("idle",		"0",		base_idle, 0,, 8);
self.am.add_state("idle",		"180",		base_idle, 0,, 8,,,true);

self.am_hair = new SpriteManager();


self.am_hair.add_state("idle",		"0",		-1, 0,1, 8);
self.am_hair.add_state("idle",		"180",		-1, 0,1, 8,,,true);
	
self.setup_hair = function(_skin=-1) {
	if (_skin != -1) {
		self.am_hair.get("idle",		"0").sprite			= 	asset_get_index(_skin+"_"+"idle")		;		
		self.am_hair.get("idle",		"180").sprite		=	asset_get_index(_skin+"_"+"idle")		;
		
		self.am_hair.get("idle",		"0").num_frames		= 	sprite_get_number(self.am_hair.get("idle",		"0").sprite	 );
		self.am_hair.get("idle",		"180").num_frames	=	sprite_get_number(self.am_hair.get("idle",		"180").sprite);		
	}
}

self.setup_hair(self.hairstyle);
self.hair_spritedata = undefined;

self.fsm = new StateMachine();

self.fsm.add("idle", {
	enter: function() {
		self.am.set(self.fsm.get_current_state_name(), string(self.facing));
		self.am_hair.set(self.fsm.get_current_state_name(), string(self.facing));
	},
	step: function() {
		var _test = update_facing();
		if (_test) {
			self.am.set(self.fsm.get_current_state_name(), string(self.facing));
			self.am_hair.set(self.fsm.get_current_state_name(), string(self.facing));
		}
	},
	draw_overlay: function() {
	},
	leave: function() {
	},
});

self.fsm.init("idle");


self.quest = undefined;
self.start_quests = [[{thing: choose("meat", "milk", "egg", "wood", "wool"), qty: choose(1,3)}, {thing: choose("meat", "milk", "egg", "wood", "wool"), qty: choose(1,3)}], [{thing: choose("meat", "milk", "egg", "wood", "wool"), qty: choose(1,4)}], [{thing: choose("meat", "milk", "egg", "wood", "wool"), qty: choose(1,2)}]];
self.process_quest = function() {
	var _msg_time = 60*2;
	var _txt = "";
	if (self.quest == undefined) { // new quest
		self.quest = [];
		if (array_length(self.start_quests) > 0) {
			self.quest = array_pop(self.start_quests);
			for (var _i=0, _n=array_length(self.quest); _i<_n; _i++) {
				var _sprite = sprite_exists(asset_get_index(self.quest[_i].thing)) ? asset_get_index(self.quest[_i].thing) : asset_get_index(self.quest[_i].thing + "_05");
				_txt += string($"[scale,3][c_white][{_sprite}][scale,2][#eeeeee] x{self.quest[_i].qty}\n");
			}
		}
		else {
			var _num_things = array_random([1,2,3], [0.6, 0.2, 0.2]);			
			repeat (_num_things) {
				var _options_crops = ["beetroot", "cabbage", "carrot", "cauliflower", "kale", "parsnip", "potato", "pumpkin", "radish", "sunflower", "wheat"];
				var _options_other = ["meat", "milk", "egg", "wood", "wool"];
				var _which = random(1) < 0.35 ? "crops" : "other";
				var _thing = _which == "crops" ? array_random(_options_crops) : array_random(_options_other);
				var _qty = _which == "crops" ? 1 : (_thing == "wood" ? irandom_range(1, 5) : irandom_range(1,2));
				array_push(self.quest, {thing: _thing, qty: _qty});
				var _sprite = _which == "crops" ? _thing+"_05" : _thing;
				_txt += string($"[scale,3][c_white][{_sprite}][scale,2][#eeeeee] x{_qty}\n");
			}
		}
		Game.set_text_textbox("I need you to do some work for me!");
		ui_get("Text_Quest").setText(_txt, true);
	}
	else {
		var _i=0;
		var _n=array_length(self.quest);
		var _quest_fulfilled = true;
		while (_i<_n && _quest_fulfilled) {
			var _this = self.quest[_i];
			var _idx = array_find_index(obj_Player.inventory, method({_this}, function(_elem, _i) {
				return _elem != undefined && _elem.item_name == _this.thing && _elem.qty >= _this.qty;
			}));
			_quest_fulfilled = _quest_fulfilled && _idx != -1;
			if (_quest_fulfilled) _i++;
		}
		if (_quest_fulfilled) {
			if (Game.options.audio.sounds_enabled)		audio_play_sound(snd_ChaChing, 50, false, Game.options.audio.sounds_volume,, 0.95, 1.02);
			//self.quest_message = string($"Thanks! Come back for more quests");
			Game.set_text_textbox("Thanks! Here's some money...\nCome back later if you want to run more errands!");
			obj_Player.money += 10;
			for (_i=0; _i<_n; _i++) { // remove from inventory
				var _this = self.quest[_i];
				obj_Player.inventory_remove(_this.thing, _this.qty);
			}
			//self.alarm[0] = _msg_time;
			call_later(_msg_time, time_source_units_frames, function() {
				self.quest = undefined;
			});
		}
		else {
			Game.set_text_textbox("Come back when you've finished the quest!");
			//self.alarm[0] = _msg_time;
		}
	}
}