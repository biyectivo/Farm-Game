if (self.fsm.get_current_state_name() == "hit")		shader_set(shd_Hit);
draw_self();
if (self.fsm.get_current_state_name() == "hit")		shader_reset();