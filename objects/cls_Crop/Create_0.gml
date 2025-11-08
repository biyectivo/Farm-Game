self.stage = 1;
self.set_sprite = function() {
	if (self.stage <= 3)		self.sprite_index = asset_get_index(string($"soil_0{self.stage}"));
	else						self.sprite_index = asset_get_index(string($"{self.crop}_0{self.stage-3}"));
	self.mask_index = self.sprite_index;
}
self.set_sprite();