// Feather ignore all;

// Shadow
draw_set_alpha(74/255);
draw_ellipse_color(self.x-5, self.y-3, self.x+5, self.y+1, #262B44, #262B44, false);
draw_set_alpha(1);

pal_swap_set(spr_PalSwap, self.outfit, false);
draw_self();
pal_swap_reset();
if (self.hairstyle != "") draw_sprite_ext(self.hair_spritedata.sprite_index, self.hair_spritedata.image_idx, self.x, self.y, self.hair_spritedata.image_xscale, self.image_yscale, self.image_angle, self.image_blend, self.image_alpha);

var _h = draw_get_halign();
draw_set_halign(fa_center);
draw_text(self.x, self.y-32, self.tools[self.current_tool]);
draw_set_halign(_h);