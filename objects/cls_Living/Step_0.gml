// Feather ignore all;
if (Game.fsm.get_current_state_name() == "Paused") exit;

self.fsm.step();
self.fsm.transition();