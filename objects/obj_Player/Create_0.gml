self.stats = {
	spd: 2,
};

self.hairstyle = "longhair";

self.tools = ["dig", "watering", "axe", "plant"];
self.tool_object = undefined;
self.current_tool = 0;

self.inventory_max_size = 4;
self.inventory = []; // {item_name, qty}
self.inventory_add = function(_item_name, _qty=1) {
	var _idx = array_find_index(self.inventory, method({_item_name}, function(_elem, _i) {
		return _elem.item_name == _item_name;
	}));
	if (_idx != -1) {
		self.inventory[_idx].qty += _qty;
		return true;
	}
	else if (array_length(self.inventory) < self.inventory_max_size) {
		array_push(self.inventory, {item_name: _item_name, qty: _qty});
		return true;
	}
	else {
		return false;
	}
}

self.inventory_remove = function(_item_name, _qty=999999999) {
	var _idx = array_find_index(self.inventory, method({_item_name}, function(_elem, _i) {
		return _elem.item_name == _item_name;
	}));
	if (_idx != -1) {
		self.inventory[_idx].qty = max(0, self.inventory[_idx].qty - _qty);
		if (self.inventory[_idx].qty == 0) {
			array_delete(self.inventory, _idx, 1);
			
		}
		return true;
	}
	else {
		return false;
	}
}


self.facing = 0;
self.update_facing = function() {
	var _prev_facing = self.facing;
	if (InputCheck(INPUT_VERB.RIGHT))	self.facing = 0;
	if (InputCheck(INPUT_VERB.LEFT))	self.facing = 180;
	return self.facing != _prev_facing;
}

self.am = new SpriteManager();

self.am.add_state("axe",		"0",		base_axe, 0,, 4,,false);
self.am.add_state("carry",		"0",		base_carry, 0,, 8,,true);
self.am.add_state("dig",		"0",		base_dig, 0,, 4,,false);
self.am.add_state("idle",		"0",		base_idle, 0,, 8);
self.am.add_state("walk",		"0",		base_walk, 0,, 8);
self.am.add_state("watering",	"0",		base_watering, 0,, 8,,false);
self.am.add_state("plant",		"0",		base_watering, 0,, 5,,false);
self.am.add_state("axe",		"180",		base_axe, 0,, 4,,false,true);
self.am.add_state("carry",		"180",		base_carry, 0,, 8,,true,true);
self.am.add_state("dig",		"180",		base_dig, 0,, 4,,false,true);
self.am.add_state("idle",		"180",		base_idle, 0,, 8,,,true);
self.am.add_state("walk",		"180",		base_walk, 0,, 8,,,true);
self.am.add_state("watering",	"180",		base_watering, 0,, 8,,false,true);
self.am.add_state("plant",		"180",		base_watering, 0,, 5,,false,true);

self.am_hair = new SpriteManager();


self.am_hair.add_state("axe",		"0",		-1, 0,1, 4,,false);
self.am_hair.add_state("carry",		"0",		-1, 0,1, 8,,true);
self.am_hair.add_state("dig",		"0",		-1, 0,1, 4,,false);
self.am_hair.add_state("idle",		"0",		-1, 0,1, 8);
self.am_hair.add_state("walk",		"0",		-1, 0,1, 8);
self.am_hair.add_state("watering",	"0",		-1, 0,1, 8,,false);
self.am_hair.add_state("plant",		"0",		-1, 0,1, 5,,false);
self.am_hair.add_state("axe",		"180",		-1, 0,1, 4,,false,true);
self.am_hair.add_state("carry",		"180",		-1, 0,1, 8,,true,true);
self.am_hair.add_state("dig",		"180",		-1, 0,1, 4,,false,true);
self.am_hair.add_state("idle",		"180",		-1, 0,1, 8,,,true);
self.am_hair.add_state("walk",		"180",		-1, 0,1, 8,,,true);
self.am_hair.add_state("watering",	"180",		-1, 0,1, 8,,false,true);
self.am_hair.add_state("plant",		"180",		-1, 0,1, 5,,false,true);
	
self.setup_hair = function(_skin=-1) {
	if (_skin != -1) {
		self.am_hair.get("axe",			"0").sprite			= 	asset_get_index(_skin+"_"+"axe")		;
		self.am_hair.get("carry",		"0").sprite			= 	asset_get_index(_skin+"_"+"carry")		;
		self.am_hair.get("dig",			"0").sprite			= 	asset_get_index(_skin+"_"+"dig")		;
		self.am_hair.get("idle",		"0").sprite			= 	asset_get_index(_skin+"_"+"idle")		;
		self.am_hair.get("walk",		"0").sprite			= 	asset_get_index(_skin+"_"+"walk")		;
		self.am_hair.get("watering",	"0").sprite			= 	asset_get_index(_skin+"_"+"watering")	;
		self.am_hair.get("plant",		"0").sprite			= 	asset_get_index(_skin+"_"+"watering")	;
		self.am_hair.get("axe",			"180").sprite		=	asset_get_index(_skin+"_"+"axe")		;
		self.am_hair.get("carry",		"180").sprite		=	asset_get_index(_skin+"_"+"carry")		;
		self.am_hair.get("dig",			"180").sprite		=	asset_get_index(_skin+"_"+"dig")		;
		self.am_hair.get("idle",		"180").sprite		=	asset_get_index(_skin+"_"+"idle")		;
		self.am_hair.get("walk",		"180").sprite		=	asset_get_index(_skin+"_"+"walk")		;
		self.am_hair.get("watering",	"180").sprite		=	asset_get_index(_skin+"_"+"watering")	;
		self.am_hair.get("plant",		"180").sprite		=	asset_get_index(_skin+"_"+"watering")	;
	
		self.am_hair.get("axe",			"0").num_frames		= 	sprite_get_number(self.am_hair.get("axe",		"0").sprite	 );
		self.am_hair.get("carry",		"0").num_frames		= 	sprite_get_number(self.am_hair.get("carry",		"0").sprite	 );
		self.am_hair.get("dig",			"0").num_frames		= 	sprite_get_number(self.am_hair.get("dig",		"0").sprite	 );
		self.am_hair.get("idle",		"0").num_frames		= 	sprite_get_number(self.am_hair.get("idle",		"0").sprite	 );
		self.am_hair.get("walk",		"0").num_frames		= 	sprite_get_number(self.am_hair.get("walk",		"0").sprite	 );
		self.am_hair.get("watering",	"0").num_frames		= 	sprite_get_number(self.am_hair.get("watering",	"0").sprite	 );
		self.am_hair.get("plant",		"0").num_frames		= 	sprite_get_number(self.am_hair.get("plant",		"0").sprite	 );
		self.am_hair.get("axe",			"180").num_frames	=	sprite_get_number(self.am_hair.get("axe",		"180").sprite);
		self.am_hair.get("carry",		"180").num_frames	=	sprite_get_number(self.am_hair.get("carry",		"180").sprite);
		self.am_hair.get("dig",			"180").num_frames	=	sprite_get_number(self.am_hair.get("dig",		"180").sprite);
		self.am_hair.get("idle",		"180").num_frames	=	sprite_get_number(self.am_hair.get("idle",		"180").sprite);
		self.am_hair.get("walk",		"180").num_frames	=	sprite_get_number(self.am_hair.get("walk",		"180").sprite);
		self.am_hair.get("watering",	"180").num_frames	=	sprite_get_number(self.am_hair.get("watering",	"180").sprite);
		self.am_hair.get("plant",		"180").num_frames	=	sprite_get_number(self.am_hair.get("plant",		"180").sprite);
	}
}

self.setup_hair(self.hairstyle);
self.hair_spritedata = undefined;


self.walk = function() {
	var _spd = self.stats.spd
	var _h = InputCheck(INPUT_VERB.RIGHT)-InputCheck(INPUT_VERB.LEFT);
	var _v = InputCheck(INPUT_VERB.DOWN)-InputCheck(INPUT_VERB.UP);
	var _tilemap = layer_tilemap_get_id(layer_get_id("lyr_Tile_Collision"));
	var _collisions = [_tilemap, cls_Tree, cls_Collisionable];
	
	if (place_meeting(self.x + _spd*_h, self.y, _collisions)) {
		while (!place_meeting(self.x + sign(_spd * _h), self.y, _collisions)) {
			self.x += sign(_spd * _h);
		}
	}
	else {
		self.x += _spd * _h;
	}
		
	if (place_meeting(self.x, self.y + _spd * _v, _collisions)) {
		while (!place_meeting(self.x, self.y + sign(_spd * _v), _collisions)) {
			self.y += sign(_spd * _v);
		}
	}
	else {
		self.y += _spd * _v;
	}
		
		
		
	var _test = update_facing();
	if (_test) {
		self.am.set(self.fsm.get_current_state_name(), string(self.facing));
		self.am_hair.set(self.fsm.get_current_state_name(), string(self.facing));
	}
}

self.fsm = new StateMachine();
self.fsm.add("axe", {
	enter: function() {
		self.am.set(self.fsm.get_current_state_name(), string(self.facing));
		self.am_hair.set(self.fsm.get_current_state_name(), string(self.facing));
		self.tool_object = instance_create_layer(self.x, self.y, "lyr_Instances", obj_Tool, {sprite_index: tools_axe});
		self.tool_object.image_xscale= self.image_xscale;
	},
	step: function() {
		self.tool_object.image_index = self.image_index;
		self.tool_object.image_xscale= self.image_xscale;
		
		with (self.tool_object) {
			if (place_meeting(self.x, self.y, [cls_Tree, cls_Animal])) {
				var _id = instance_place(self.x, self.y, [cls_Tree, cls_Animal]);
				if (_id.fsm.get_current_state_name() == "idle") {
					_id.fsm.trigger("hit");
					_id.stats.hp--;
				}
			}
		}
	},
	draw_overlay: function() {
		
	},
	leave: function() {
		instance_destroy(self.tool_object);
	},
});
self.fsm.add("carry", {
	enter: function() {
		self.am.set(self.fsm.get_current_state_name(), string(self.facing));
		self.am_hair.set(self.fsm.get_current_state_name(), string(self.facing));
		self.tool_object = instance_create_layer(self.x, self.y, "lyr_Instances", obj_Tool, {sprite_index: tools_carry});
		self.tool_object.image_xscale= self.image_xscale;
	},
	step: function() {
		with (self.tool_object) {
			if (InputCheckMany([INPUT_VERB.UP, INPUT_VERB.DOWN, INPUT_VERB.LEFT, INPUT_VERB.RIGHT])) {
				self.image_index  = other.image_index;
				self.image_xscale = other.image_xscale;
				self.x = other.x;
				self.y = other.y;
			}
			else {
				self.image_index  = 0;
			}
		}
		self.walk();
	},
	draw_overlay: function() {
	},
	leave: function() {
		instance_destroy(self.tool_object);
	},
});
self.fsm.add("dig", {
	enter: function() {
		self.am.set(self.fsm.get_current_state_name(), string(self.facing));
		self.am_hair.set(self.fsm.get_current_state_name(), string(self.facing));
		self.tool_object = instance_create_layer(self.x, self.y, "lyr_Instances", obj_Tool, {sprite_index: tools_dig});
		self.tool_object.image_xscale= self.image_xscale;
	},
	step: function() {
		with (self.tool_object) {
			self.image_index  = other.image_index;
			self.image_xscale = other.image_xscale;
			
			if (self.image_index >= 2 && self.image_index <= 6) {				
				var _tilemap = layer_tilemap_get_id(layer_get_id("lyr_Tile_World_Floor_2"));
				var _tilemap_bg = layer_tilemap_get_id(layer_get_id("lyr_Tile_World_Floor_1"));
				var _x = self.bbox_left + (self.bbox_right-self.bbox_left)/2;
				var _y = self.bbox_top + (self.bbox_bottom-self.bbox_top)/2;
				var _col = tilemap_get_cell_x_at_pixel(_tilemap, _x, _y);
				var _row = tilemap_get_cell_y_at_pixel(_tilemap, _x, _y);
				var _tile = tilemap_get_at_pixel(_tilemap, _x, _y);
				var _crop_tiles = [67,449,457,458,459,521,522];
				if (array_get_index(_crop_tiles, _tile) != -1) {
					call_later(30, time_source_units_frames, method({_col, _row, _tilemap, _tilemap_bg}, function() {
						tilemap_set(_tilemap, 818, _col, _row);
						tilemap_set(_tilemap_bg, 67, _col, _row);
					}));
				}
			}
		}
	},
	draw_overlay: function() {
		
	},
	leave: function() {
		instance_destroy(self.tool_object);
	},
});
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
self.fsm.add("walk", {
	enter: function() {
		self.am.set(self.fsm.get_current_state_name(), string(self.facing));
		self.am_hair.set(self.fsm.get_current_state_name(), string(self.facing));
	},
	step: function() {
		self.walk();
	},
	draw_overlay: function() {
	},
	leave: function() {
	},
});
self.fsm.add("watering", {
	enter: function() {
		self.am.set(self.fsm.get_current_state_name(), string(self.facing));
		self.am_hair.set(self.fsm.get_current_state_name(), string(self.facing));
		self.tool_object = instance_create_layer(self.x, self.y, "lyr_Instances", obj_Tool, {sprite_index: tools_watering});
		self.tool_object.image_xscale= self.image_xscale;
		self.action_done = false;
	},
	step: function() {
		self.tool_object.image_index = self.image_index;
		self.tool_object.image_xscale= self.image_xscale;
		
		
		with (self.tool_object) {
			self.image_index  = other.image_index;
			self.image_xscale = other.image_xscale;
			
			if (!other.action_done && self.image_index >= 3 && self.image_index <= 3) {				
				var _x = self.bbox_left + (self.bbox_right-self.bbox_left)/2;
				var _y = self.bbox_top + (self.bbox_bottom-self.bbox_top)/2;
				
				if (position_meeting(_x, _y, cls_Crop)) {
					var _id = instance_position(_x, _y, cls_Crop);
					_id.stage = clamp(_id.stage+1, 1, 8);
				}
				other.action_done = true;
			}
		}
		
	},
	draw_overlay: function() {
		
	},
	leave: function() {
		instance_destroy(self.tool_object);
	},
});
self.fsm.add("plant", {
	enter: function() {
		self.am.set(self.fsm.get_current_state_name(), string(self.facing));
		self.am_hair.set(self.fsm.get_current_state_name(), string(self.facing));
		self.action_done = false;
	},
	step: function() {
		if  (!self.action_done && self.image_index == 3) {
			var _tilemap = layer_tilemap_get_id(layer_get_id("lyr_Tile_World_Floor_2"));
			var _x = self.x + (self.facing == 0 ? 1 : -1) * 16;
			var _y = self.y;
			var _col = tilemap_get_cell_x_at_pixel(_tilemap, _x, _y);
			var _row = tilemap_get_cell_y_at_pixel(_tilemap, _x, _y);
			var _tile = tilemap_get_at_pixel(_tilemap, _x, _y);
			var _crop_tiles = [818];
			if (array_get_index(_crop_tiles, _tile) != -1 && !position_meeting(_x, _y, cls_Crop)) {
				var _size = tilemap_get_tile_width(_tilemap);
				var _x = _size * (_col + 0.5);
				var _y = _size * (_row + 0.5);
				instance_create_layer(_x, _y, "lyr_Crops", cls_Crop, {crop: choose("beetroot", "cabbage", "carrot", "cauliflower", "kale", "parsnip", "potato", "pumpkin", "radish", "sunflower", "wheat")});			
				self.action_done = true;
			}
		}
	},
	draw_overlay: function() {
	},
	leave: function() {
	},
});

self.fsm.add_transition("idle", "walk", function() {
	return InputCheckMany([INPUT_VERB.UP, INPUT_VERB.DOWN, INPUT_VERB.LEFT, INPUT_VERB.RIGHT]);
});
self.fsm.add_transition("walk", "idle", function() {
	return !InputCheckMany([INPUT_VERB.UP, INPUT_VERB.DOWN, INPUT_VERB.LEFT, INPUT_VERB.RIGHT]);
});
self.fsm.add_transition(["idle", "walk"], "dig", function() {
	return self.tools[self.current_tool] == "dig" && InputPressed(INPUT_VERB.USE_TOOL);
});
self.fsm.add_transition("dig", "idle", function() {
	return self.am.has_ended();
});
self.fsm.add_transition(["idle", "walk"], "axe", function() {
	return self.tools[self.current_tool] == "axe" && InputPressed(INPUT_VERB.USE_TOOL);
});
self.fsm.add_transition("axe", "idle", function() {
	return self.am.has_ended();
});
self.fsm.add_transition(["idle", "walk"], "watering", function() {
	return self.tools[self.current_tool] == "watering" && InputPressed(INPUT_VERB.USE_TOOL);
});
self.fsm.add_transition("watering", "idle", function() {
	return self.am.has_ended();
});
self.fsm.add_transition(["idle", "walk"], "carry", function() {
	return self.tools[self.current_tool] == "carry" && InputPressed(INPUT_VERB.USE_TOOL);
});
self.fsm.add_transition("carry", "idle", function() {
	return InputPressed(INPUT_VERB.USE_TOOL);
});
self.fsm.add_transition(["idle", "walk"], "plant", function() {
	return self.tools[self.current_tool] == "plant" && InputPressed(INPUT_VERB.USE_TOOL);
});
self.fsm.add_transition("plant", "idle", function() {
	return self.am.has_ended();
});


self.fsm.init("idle");

pal_swap_init_system(shd_pal_swapper);