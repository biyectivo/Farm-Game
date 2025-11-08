event_inherited();

if (InputPressed(INPUT_VERB.NEXT_TOOL)) {
	self.current_tool = (self.current_tool+1) % array_length(self.tools);
}
if (InputPressed(INPUT_VERB.PREV_TOOL)) {
	self.current_tool = (self.current_tool-1);
	if (self.current_tool == -1) self.current_tool = array_length(self.tools)-1;
}
self.hair_spritedata = self.am_hair.step(true);