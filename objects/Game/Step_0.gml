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
		
		if (InputPressed(INPUT_VERB.FULLSCREEN))		{
			self.options.video.fullscreen = !self.options.video.fullscreen;
			Camera.toggle_fullscreen();
		}
		
		if (InputPressed(INPUT_VERB.INVENTORY))	 {
			ui_get("Panel_Inventory").setVisible(!ui_get("Panel_Inventory").getVisible());
			if (Game.options.audio.sounds_enabled) {
				var _sound = ui_get("Panel_Inventory").getVisible() ? snd_Open : snd_Close;
				audio_play_sound(_sound, 50, false, Game.options.audio.sounds_volume,, 0.95, 1.02);
			}
		}
		if (InputPressed(INPUT_VERB.PAUSE))	{
			if (self.fsm.get_current_state_name() == "Playing")		self.pause();
			else													self.resume();
		}

		if (InputPressed(INPUT_VERB.TIME_SPEEDUP)) {
			var _period = time_source_get_period(self.ts);
			var _new_period = _period == self.hour_length_frames ? self.hour_length_frames_speedup : self.hour_length_frames;
			time_source_reconfigure(self.ts, _new_period, time_source_units_frames, self.advance_clock, [], -1, time_source_expire_nearest);
			time_source_start(self.ts);
		}
		break;
}