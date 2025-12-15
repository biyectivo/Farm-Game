// Feather ignore all;

switch(room) {
	case room_Init:
		room_goto(room_Game);
		break;
	case room_Game:
		layer_set_visible(layer_get_id("lyr_Tile_Collision"), false);
		
		if (Game.options.audio.music_enabled) {
			audio_play_sound(snd_Music, 100, true);
			audio_sound_gain(snd_Music, Game.options.audio.music_volume);
		}
		
		// Spawn trees
		self.spawn(obj_Spawn_Trees, cls_Tree, [obj_Tree_Pine, obj_Tree_Round], 15, 10, false);
		
		// Spawn animals
		self.spawn(obj_Spawn_Animals, cls_Animal, [obj_Chicken], 2, 4, false);
		self.spawn(obj_Spawn_Animals, cls_Animal, [obj_Cow], 2, 4, false);
		self.spawn(obj_Spawn_Animals, cls_Animal, [obj_Pig], 2, 4, false);
		self.spawn(obj_Spawn_Animals, cls_Animal, [obj_Sheep], 2, 4, false);
		
		break;
}