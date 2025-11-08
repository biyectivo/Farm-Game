// Feather ignore all;

var _mouseover = device_mouse_x(0) >= self.bbox_left && device_mouse_x(0) <= self.bbox_right && device_mouse_y(0) >= self.bbox_top && device_mouse_y(0) <= self.bbox_bottom;
var _click = _mouseover && InputPressed(INPUT_VERB.INTERACT_PICKUP);

if (_mouseover) {
	var _qty = self.qty > 1 ? string($" ({self.qty})") : "";
	var _h = draw_get_halign();
	draw_set_halign(fa_center);
	draw_text(self.x, self.y-32, string($"{self.item_name}{_qty}"));
	draw_set_halign(_h);
}

shader_set(shd_Outline_Color);

if (_mouseover) {
	shader_set_uniform_f(shader_get_uniform(shd_Outline_Color, "v_outline_color"), 1.0, 1.0, 1.0, 1.0);	
}
else {
	shader_set_uniform_f(shader_get_uniform(shd_Outline_Color, "v_outline_color"), 0.8, 0.8, 0.8, 1.0);
}
draw_sprite_ext(self.sprite_index, self.image_index, self.x, self.y, 1.1*self.image_xscale, 1.05*self.image_yscale, self.image_angle, self.image_blend, self.image_alpha);
shader_reset();
draw_sprite_ext(self.sprite_index, self.image_index, self.x, self.y, self.image_xscale, self.image_yscale, self.image_angle, self.image_blend, self.image_alpha);

if (_click) {
	var _success = obj_Player.inventory_add(self.item_name, self.qty);
	if (_success) instance_destroy();
}
