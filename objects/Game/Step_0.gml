// Feather ignore all;

switch(room) {
	case room_Init:
		room_goto(room_Game);
		break;
	case room_Game:
		with (cls_Living) {
			self.depth = -self.bbox_bottom;
		}
		with (obj_Signpost) {
			self.depth = -self.bbox_bottom;
		}
		with (obj_NPC) {
			self.depth = -self.bbox_bottom;
		}
		
		if (InputPressed(INPUT_VERB.FULLSCREEN))		Camera.toggle_fullscreen();
		if (InputPressed(INPUT_VERB.INVENTORY))			show_debug_message(obj_Player.inventory);

		if (InputPressed(INPUT_VERB.TIME_SPEEDUP)) {
			var _period = time_source_get_period(self.ts);
			var _new_period = _period == self.hour_length_frames ? self.hour_length_frames_speedup : self.hour_length_frames;
			time_source_reconfigure(self.ts, _new_period, time_source_units_frames, self.advance_clock, [], -1, time_source_expire_nearest);
			time_source_start(self.ts);
		}
		break;
}