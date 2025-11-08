// Feather ignore all;

var _period = time_source_get_period(self.ts);

var _h = draw_get_halign();
draw_set_halign(fa_right);
draw_text_transformed(display_get_gui_width()-100, 20, string($"{_period == self.hour_length_frames_speedup ? ">>" : ""} {self.hour}"), 4, 4, 0);
draw_set_halign(_h);