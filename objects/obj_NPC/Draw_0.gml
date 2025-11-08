// Feather ignore all;

// Shadow
draw_set_alpha(74/255);
draw_ellipse_color(self.x-5, self.y-3, self.x+5, self.y+1, #262B44, #262B44, false);
draw_set_alpha(1);

var _mouseover = device_mouse_x(0) >= self.bbox_left && device_mouse_x(0) <= self.bbox_right && device_mouse_y(0) >= self.bbox_top && device_mouse_y(0) <= self.bbox_bottom;
var _click = _mouseover && InputPressed(INPUT_VERB.INTERACT_PICKUP);
shader_set(shd_Outline_Color);
if (_mouseover) {
	shader_set_uniform_f(shader_get_uniform(shd_Outline_Color, "v_outline_color"), 1.0, 1.0, 1.0, 1.0);	
	if (_click) self.process_quest();
}
else {
	shader_set_uniform_f(shader_get_uniform(shd_Outline_Color, "v_outline_color"), 0.8, 0.8, 0.8, 1.0);
}
draw_sprite_ext(self.sprite_index, self.image_index, self.x, self.y, 1.1*self.image_xscale, 1.05*self.image_yscale, self.image_angle, self.image_blend, self.image_alpha);
if (self.hairstyle != "") draw_sprite_ext(self.hair_spritedata.sprite_index, self.hair_spritedata.image_idx, self.x, self.y, 1.1*self.hair_spritedata.image_xscale, 1.05*self.image_yscale, self.image_angle, self.image_blend, self.image_alpha);
shader_reset();
draw_sprite_ext(self.sprite_index, self.image_index, self.x, self.y, self.image_xscale, self.image_yscale, self.image_angle, self.image_blend, self.image_alpha);
if (self.hairstyle != "") draw_sprite_ext(self.hair_spritedata.sprite_index, self.hair_spritedata.image_idx, self.x, self.y, self.hair_spritedata.image_xscale, self.image_yscale, self.image_angle, self.image_blend, self.image_alpha);


if (self.alarm[0] >= 0) {
	var _h = draw_get_halign();
	draw_set_halign(fa_left);
	draw_text(self.x, self.y-32, self.quest_message);
	draw_set_halign(_h);
}