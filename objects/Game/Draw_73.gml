// Feather ignore all

var _next_hour = (self.hour + 1) % 24;
var _lambda = 1-time_source_get_time_remaining(self.ts)/self.hour_length_frames;

var _color_hour = self.day_overlay[self.hour].color;
var _color_next_hour = self.day_overlay[_next_hour].color;
var _color = merge_color(_color_hour, _color_next_hour, _lambda);

var _alpha_hour = self.day_overlay[self.hour].alpha;
var _alpha_next_hour = self.day_overlay[_next_hour].alpha;
var _alpha = lerp(_alpha_hour, _alpha_next_hour, _lambda);

draw_set_alpha(_alpha);
draw_rectangle_color(0, 0, room_width, room_height, _color, _color, _color, _color, false);
draw_set_alpha(1);