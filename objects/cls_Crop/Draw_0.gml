// Feather ignore all;

if (self.stage < 8) {
	draw_self();
}
else {
	var _mouseover = device_mouse_x(0) >= self.bbox_left && device_mouse_x(0) <= self.bbox_right && device_mouse_y(0) >= self.bbox_top && device_mouse_y(0) <= self.bbox_bottom;
	var _click = _mouseover && InputPressed(INPUT_VERB.INTERACT_PICKUP);
	
	shader_set(shd_Outline_Color);
	if (_mouseover) {
		shader_set_uniform_f(shader_get_uniform(shd_Outline_Color, "v_outline_color"), 1.0, 1.0, 1.0, 1.0);
	}
	else {
		shader_set_uniform_f(shader_get_uniform(shd_Outline_Color, "v_outline_color"), 0.8, 0.8, 0.8, 1.0);
	}
	//var _y = self.y - 2 - 2 * cos(current_time/200);
	self.y = self.ystart - 2 - 2 * cos(current_time/200);
	draw_sprite_ext(self.sprite_index, self.image_index, self.x, self.y, 1.1*self.image_xscale, 1.05*self.image_yscale, self.image_angle, self.image_blend, self.image_alpha);
	shader_reset();
	
	draw_sprite_ext(self.sprite_index, self.image_index, self.x, self.y, self.image_xscale, self.image_yscale, self.image_angle, self.image_blend, self.image_alpha);
	
	if (_click) {
		obj_Player.inventory_add(self.crop);
		instance_destroy();
	}
}
draw_text(self.x, self.y-32, self.crop);
//draw_set_alpha(0.5);
//draw_rectangle_color(self.bbox_left, self.bbox_top, self.bbox_right, self.bbox_bottom, c_red, c_red, c_red, c_red, false);
//draw_set_alpha(1);