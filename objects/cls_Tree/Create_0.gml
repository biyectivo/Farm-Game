self.stats = {
	hp: irandom_range(3,5),
	qty: array_random([1,2,3],[0.7,0.2,0.1])
}

self.am = new SpriteManager();

self.am.add_state("idle",		"0",		self.sprite_index, 0, 1,8,,false);
self.am.add_state("hit",		"0",		self.sprite_index, 0, ,8,,false);
self.am.add_state("stump",		"0",		spr_stump, irandom_range(0,1), 1,8,,false);


self.fsm = new StateMachine();

self.fsm.add("idle", {
	enter: function() {
		self.am.set(self.fsm.get_current_state_name(), 0);
	},
	step: function() {
		
	},
	leave: function() {
	},
});
self.fsm.add("hit", {
	enter: function() {
		self.am.set(self.fsm.get_current_state_name(), 0);		
	},
	step: function() {
		
	},
	leave: function() {
	},
});
self.fsm.add("stump", {
	enter: function() {
		self.am.set(self.fsm.get_current_state_name(), 0);
		//obj_Player.inventory_add("wood");
		var _dx = irandom_range(-5,5);
		var _dy = irandom_range(-5,5);
		instance_create_layer(obj_Player.x+_dx, obj_Player.y+_dy, "lyr_Crops", obj_Item, {item_name: "wood", qty: self.stats.qty})
		self.mask_index = spr_Mask_Empty;
	},
	step: function() {
		
	},
	leave: function() {
	},
});

self.fsm.add_transition("hit", "idle", function() {
	return self.am.has_ended();
});
self.fsm.add_transition("hit", "stump", function() {
	return self.stats.hp <= 0;
});

self.fsm.init("idle");