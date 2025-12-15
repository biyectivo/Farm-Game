// Feather ignore all;
if (!surface_exists(self.surf)) {
	self.surf = surface_create(250, 250);
	self.update_surf();
	if (ui_exists("Canvas_Options_Game_Skin")) ui_get("Canvas_Options_Game_Skin").setSurface(self.surf);
}

if (!ui_exists("Panel_Pause")) {
	var _panel = new UIPanel("Panel_Pause", 0, Game.pause_menu_y, 350, 250, green_panel, UI_RELATIVE_TO.MIDDLE_CENTER);
	_panel.setResizable(false).setMovable(false).setTitle("Game Paused").setTitleFormat("[fnt_UI][fa_top][fa_center][scale,3]");
	_panel.setPreRenderCallback(function() {
		ui_get("Panel_Pause").setDimensions(,Game.pause_menu_y);
	});
	_panel.setVisible(false);
	
	var _grid = new UIGrid("Grid_Pause", 2, 1);
	_grid.setSpacingVertical(20).setMargins(20).setMarginTop(80).setShowGridOverlay(true);
	_panel.add(_grid);
	
	var _button = new UIButton("Button_Pause_Options", 0, 0, 0, 0, "Options", green_button00, UI_RELATIVE_TO.MIDDLE_CENTER);
	_button.setSpriteMouseover(green_button01).setSpriteClick(green_button02).setTextFormat("[fnt_UI][fa_center][fa_middle][scale,2]", true);
	_button.setInheritWidth(true).setInheritHeight(true);
	_button.setCallback(UI_EVENT.MOUSE_ENTER, self.hover_sound);
	_button.setCallback(UI_EVENT.LEFT_CLICK, self.click_sound);
	_button.setCallback(UI_EVENT.LEFT_RELEASE, function() {
		ui_get("Panel_Pause").setVisible(false);
		ui_get("Panel_Options").setVisible(true);
	});
	_grid.addToCell(_button, 0, 0);
	
	var _button = new UIButton("Button_Pause_Resume", 0, 0, 0, 0, "Resume", green_button00, UI_RELATIVE_TO.MIDDLE_CENTER);
	_button.setSpriteMouseover(green_button01).setSpriteClick(green_button02).setTextFormat("[fnt_UI][fa_center][fa_middle][scale,2]", true);
	_button.setInheritWidth(true).setInheritHeight(true);
	_button.setCallback(UI_EVENT.MOUSE_ENTER, self.hover_sound);
	_button.setCallback(UI_EVENT.LEFT_CLICK, self.click_sound);
	_button.setCallback(UI_EVENT.LEFT_RELEASE, self.resume);
	_grid.addToCell(_button, 1, 0);
	
}

if (!ui_exists("Panel_Options")) {
	var _panel = new UIPanel("Panel_Options", 0, 0, 550, 550, green_panel, UI_RELATIVE_TO.MIDDLE_CENTER);
	_panel.setResizable(false).setMovable(false).setTitle("Options").setTitleFormat("[fnt_UI][fa_top][fa_center][scale,3]");
	
	_panel.setTabControlVisible(true).setTabMargin(20);
	_panel.addTab(3).setTabText(0, "Game").setTabText(1, "Video").setTabText(2, "Audio").setTabText(3, "Credits");
	_panel.setTabsTextFormat("[fnt_UI][scale,2][#eeeeee]").setTabsTextFormatMouseover("[fnt_UI][scale,2]").setTabsTextFormatSelected("[fnt_UI][scale,2]");
	_panel.setTabSprites(green_button00).setTabSpritesMouseover(green_button01).setTabSpritesSelected(green_button01);
	var _children = _panel.getTabControl().getChildren();
	for (var _i=0, _n=array_length(_children); _i<_n; _i++) {
		var _button = _children[_i];
		_button.setCallback(UI_EVENT.MOUSE_ENTER, self.hover_sound);
		_button.setCallback(UI_EVENT.LEFT_CLICK, self.click_sound);
	}
	_panel.setTabOffset({x:0, y: 70});
	_panel.setVisible(false);
	
	var _button = new UIButton("Button_Options_Return", 0, -20, 400, 50, "Return", green_button00, UI_RELATIVE_TO.BOTTOM_CENTER);
	_button.setSpriteMouseover(green_button01).setSpriteClick(green_button01).setTextFormat("[fnt_UI][fa_center][fa_middle][scale,2]", true);
	_button.setCallback(UI_EVENT.MOUSE_ENTER, self.hover_sound);
	_button.setCallback(UI_EVENT.LEFT_CLICK, self.click_sound);
	_button.setCallback(UI_EVENT.LEFT_RELEASE, function() {
		ui_get("Panel_Pause").setVisible(true);
		ui_get("Panel_Options").setVisible(false);
	});
	_panel.add(_button, -1);
	
	var _fmt = "[fnt_UI][scale,2][fa_left][fa_middle]";
	
	// Game Tab
	var _base_grid = new UIGrid("Grid_Options_Game", 1, 2);
	_base_grid.setSpacingHorizontal(10).setMargins(30).setMarginTop(140).setMarginBottom(90).setColumnProportions([0.6,0.4]).setShowGridOverlay(false);
	_panel.add(_base_grid, 0);
	
	var _left_grid = new UIGrid("Grid_Options_Game_Left", 4, 1);
	_left_grid.setShowGridOverlay(false);
	_base_grid.addToCell(_left_grid, 0, 0);
	
	var _txt = new UIText("Text_Options_Game_PlayerHair", 0, 0, "Player Hairstyle", UI_RELATIVE_TO.MIDDLE_LEFT);
	_txt.setTextFormat(_fmt, true);
	_left_grid.addToCell(_txt, 0, 0);
	
	var _spinner = new UISpinner("Spinner_Options_Game_PlayerHair", 0, 0, Game.player_hair_options, green_button03, green_sliderLeft, green_sliderRight, 250, 50, Game.options.game.player_hair_index);
	_spinner.setBinding(Game.options.game, "player_hair_index");
	_spinner.getButtonText().setTextFormat("[fnt_UI][scale,2][fa_center][fa_middle]", true);
	var _button = _spinner.getButtonLeft();
	_button.setCallback(UI_EVENT.MOUSE_ENTER, self.hover_sound);
	_button.setCallback(UI_EVENT.LEFT_CLICK, self.click_sound);
	var _button = _spinner.getButtonRight();
	_button.setCallback(UI_EVENT.MOUSE_ENTER, self.hover_sound);
	_button.setCallback(UI_EVENT.LEFT_CLICK, self.click_sound);	
	_spinner.setCallback(UI_EVENT.VALUE_CHANGED, function() {
		obj_Player.hairstyle = Game.player_hair_options[Game.options.game.player_hair_index];
		obj_Player.setup_hair(obj_Player.hairstyle);
		self.update_surf();
	});
	_left_grid.addToCell(_spinner, 1, 0);
	
	var _txt = new UIText("Text_Options_Game_PlayerOutfit", 0, 0, "Player Outfit", UI_RELATIVE_TO.MIDDLE_LEFT);
	_txt.setTextFormat(_fmt, true);
	_left_grid.addToCell(_txt, 2, 0);
	
	var _spinner = new UISpinner("Spinner_Options_Game_PlayerOutfit", 0, 0, Game.player_outfit_options, green_button03, green_sliderLeft, green_sliderRight, 250, 50, Game.options.game.player_outfit_index);
	_spinner.setBinding(Game.options.game, "player_outfit_index");
	_spinner.getButtonText().setTextFormat("[fnt_UI][scale,2][fa_center][fa_middle]", true);
	var _button = _spinner.getButtonLeft();
	_button.setCallback(UI_EVENT.MOUSE_ENTER, self.hover_sound);
	_button.setCallback(UI_EVENT.LEFT_CLICK, self.click_sound);
	var _button = _spinner.getButtonRight();
	_button.setCallback(UI_EVENT.MOUSE_ENTER, self.hover_sound);
	_button.setCallback(UI_EVENT.LEFT_CLICK, self.click_sound);	
	_spinner.setCallback(UI_EVENT.VALUE_CHANGED, function() {
		obj_Player.outfit = Game.options.game.player_outfit_index;
		self.update_surf();
	});
	_left_grid.addToCell(_spinner, 3, 0);
		
	var _canvas = new UICanvas("Canvas_Options_Game_Skin", 0, 0, 250, 250, self.surf, UI_RELATIVE_TO.MIDDLE_CENTER);
	_base_grid.addToCell(_canvas, 0, 1);
	
	// Video Tab
	var _grid = new UIGrid("Grid_Options_Video", 2, 2);
	_grid.setSpacingVertical(20).setMargins(30).setMarginTop(150).setMarginBottom(100).setShowGridOverlay(false);
	_panel.add(_grid, 1);
	
	var _chk = new UICheckbox("Checkbox_Options_Video_Fullscreen", 0, 0, "Full screen", green_checkmark, undefined,, UI_RELATIVE_TO.MIDDLE_LEFT);
	_chk.setSpriteBase(checkbox_off).setInnerSpritesOffset({x: 9, y: 9});
	_chk.setBinding(self.options.video, "fullscreen");
	_chk.setCallback(UI_EVENT.VALUE_CHANGED, Camera.toggle_fullscreen);
	_chk.setTextFormatTrue(_fmt).setTextFormatFalse(_fmt).setTextFormatMouseoverTrue(_fmt).setTextFormatMouseoverFalse(_fmt);
	_grid.addToCell(_chk, 0, 0);
	
	// Audio Tab
	var _grid = new UIGrid("Grid_Options_Audio", 2, 2);
	_grid.setSpacingVertical(20).setMargins(30).setMarginTop(150).setMarginBottom(100).setShowGridOverlay(false);
	_panel.add(_grid, 2);
	
	var _chk = new UICheckbox("Checkbox_Options_Audio_Music", 0, 0, "Music", green_checkmark, undefined,, UI_RELATIVE_TO.MIDDLE_LEFT);
	_chk.setSpriteBase(checkbox_off).setInnerSpritesOffset({x: 9, y: 9});
	_chk.setBinding(self.options.audio, "music_enabled");
	_chk.setCallback(UI_EVENT.MOUSE_ENTER, self.hover_sound);
	_chk.setCallback(UI_EVENT.LEFT_CLICK, self.click_sound);
	_chk.setCallback(UI_EVENT.VALUE_CHANGED, function() {
		if (Game.options.audio.music_enabled)	audio_resume_sound(snd_Music);
		else									audio_pause_sound(snd_Music);
	});
	_chk.setTextFormatTrue(_fmt).setTextFormatFalse(_fmt).setTextFormatMouseoverTrue(_fmt).setTextFormatMouseoverFalse(_fmt);
	_grid.addToCell(_chk, 0, 0);
	
	var _chk = new UICheckbox("Checkbox_Options_Audio_Sounds", 0, 0, "Sounds", green_checkmark, undefined,, UI_RELATIVE_TO.MIDDLE_LEFT);
	_chk.setSpriteBase(checkbox_off).setInnerSpritesOffset({x: 9, y: 9});
	_chk.setBinding(self.options.audio, "sounds_enabled");
	_chk.setCallback(UI_EVENT.MOUSE_ENTER, self.hover_sound);
	_chk.setCallback(UI_EVENT.LEFT_CLICK, self.click_sound);
	_chk.setTextFormatTrue(_fmt).setTextFormatFalse(_fmt).setTextFormatMouseoverTrue(_fmt).setTextFormatMouseoverFalse(_fmt);
	_grid.addToCell(_chk, 1, 0);
	
	var _slider = new UISlider("Slider_Options_Audio_Music", 0,0 , 200, grey_sliderHorizontal, green_sliderDown, Game.options.audio.music_volume, 0, 1,,UI_RELATIVE_TO.MIDDLE_CENTER);
	_slider.setShowHandleText(false).setShowMinMaxText(false).setHandleOffset({x:0, y:-15}).setClickToSet(true).setScrollChange(0.1).setDragChange(0.1);
	_slider.setBinding(Game.options.audio, "music_volume");
	_slider.setCallback(UI_EVENT.MOUSE_ENTER, self.hover_sound);
	_slider.setCallback(UI_EVENT.LEFT_CLICK, self.click_sound);
	_slider.setCallback(UI_EVENT.VALUE_CHANGED, function() {
		audio_sound_gain(snd_Music, Game.options.audio.music_volume);
	});
	_grid.addToCell(_slider, 0, 1);
	
	var _slider = new UISlider("Slider_Options_Audio_Sounds", 0,0 , 200, grey_sliderHorizontal, green_sliderDown, Game.options.audio.sounds_volume, 0, 1,,UI_RELATIVE_TO.MIDDLE_CENTER);
	_slider.setShowHandleText(false).setShowMinMaxText(false).setHandleOffset({x:0, y:-15}).setClickToSet(true).setScrollChange(0.1).setDragChange(0.1);
	_slider.setBinding(Game.options.audio, "sounds_volume");
	_slider.setCallback(UI_EVENT.MOUSE_ENTER, self.hover_sound);
	_slider.setCallback(UI_EVENT.LEFT_CLICK, self.click_sound);
	_grid.addToCell(_slider, 1, 1);
	
	
	// Credits tab
	var _grp = new UIGroup("Group_Options_Credits", 30, _panel.getDragBarHeight()+_panel.getTabControl().getDimensions().height+50, _panel.getDimensions().width-60, 330, glass_panel);
	_panel.add(_grp, 3);
	
	var _txt = new UIText("Text_Options_Credits", 0, 20,  "[rainbow]CREDITS[/rainbow]\n[scale,1](mouse wheel to scroll)[scale,2]\n\ngooey library - manta ray\n\nScribbleDX - JujuAdams\nUI Assets - Kenney\n\nDemo game art - Daniel Diggle\nMusic - 'Make it Good' by Ketsa\nSounds - Artists in freesounds.org\n\n[wave]Thanks for scrolling![/wave]\n[spr_deco_glint_01]", UI_RELATIVE_TO.TOP_CENTER);
	_fmt = "[fnt_UI][scale,2][fa_top][fa_center]";
	_txt.setMaxWidth(_grp.getDimensions().width-40).setTextFormat(_fmt, true);
	_grp.setClipsContent(true);
	_grp.setCallback(UI_EVENT.MOUSE_WHEEL_DOWN, function() {
		var _offset_buffer = 60;
		var _height = ui_get("Group_Options_Credits").getChildrenBoundingBoxAbsolute().height;
		var _offset = ui_get("Group_Options_Credits").getScrollOffset(UI_ORIENTATION.VERTICAL);
		var _parent_height = ui_get("Group_Options_Credits").getDimensions().height;
		if (_offset >= -(_height-_parent_height + _offset_buffer))		ui_get("Group_Options_Credits").scroll(UI_ORIENTATION.VERTICAL, -1, 15);
	});
	_grp.setCallback(UI_EVENT.MOUSE_WHEEL_UP, function() {
		var _height = ui_get("Group_Options_Credits").getChildrenBoundingBoxAbsolute().height;
		var _offset = ui_get("Group_Options_Credits").getScrollOffset(UI_ORIENTATION.VERTICAL);
		var _parent_height = ui_get("Group_Options_Credits").getDimensions().height;
		if (_offset < 0)	ui_get("Group_Options_Credits").scroll(UI_ORIENTATION.VERTICAL, 1, 15);
	});
	_grp.add(_txt);
}

if (!ui_exists("Panel_TimeOfDay")) {
	var _panel = new UIPanel("Panel_TimeOfDay", -30, 30, 280, 150, glass_panel, UI_RELATIVE_TO.TOP_RIGHT);
	_panel.setResizable(false).setMovable(false).setDragBarHeight(0).setImageAlpha(0.9);
	
	var _grid = new UIGrid("Grid_TimeOfDay", 1, 3);
	_grid.setColumnProportions([0.5, 0.2, 0.3]);
	_panel.add(_grid);
	
	var _sprite = new UISprite("Sprite_TimeOfDay", 0, 0, day_and_night, 128, 128,,UI_RELATIVE_TO.MIDDLE_CENTER);
	_sprite.setUseNineSlice(false);
	_grid.addToCell(_sprite, 0, 0);
	
	var _txt = new UIText("Text_TimeOfDay", 0, 0, "", UI_RELATIVE_TO.MIDDLE_CENTER);
	var _fmt = "[scale,3][fnt_UI][fa_center]";
	_txt.setTextFormat(_fmt).setTextFormatMouseover(_fmt).setTextFormatClick(_fmt).setBinding(self, "hour");	
	_grid.addToCell(_txt, 0, 2);
		
	var _txt = new UIText("Text_AcceleratedTime", 0, 0, "", UI_RELATIVE_TO.MIDDLE_CENTER);
	var _fmt = "[scale,2][fnt_UI][fa_center]";
	_txt.setTextFormat(_fmt).setTextFormatMouseover(_fmt).setTextFormatClick(_fmt).setBinding(self, "progress_indicator");	
	_grid.addToCell(_txt, 0, 1);
}

if (!ui_exists("Panel_Money")) {
	var _panel = new UIPanel("Panel_Money", 30, 30, 280, 150, glass_panel);
	_panel.setResizable(false).setMovable(false).setDragBarHeight(0).setImageAlpha(0.9);
	
	var _grid = new UIGrid("Grid_Money", 1, 2);
	_grid.setColumnProportions([0.6,0.4]);
	_panel.add(_grid);
	
	var _txt = new UIText("Text_Money", 0, 0, "", UI_RELATIVE_TO.MIDDLE_CENTER);
	var _fmt = "[scale,3][fnt_UI][fa_right]";
	_txt.setTextFormat(_fmt).setTextFormatMouseover(_fmt).setTextFormatClick(_fmt).setBinding(obj_Player, "money");
	
	_grid.addToCell(_txt, 0, 1);
	
	var _sprite = new UISprite("Sprite_Money", 0, 0, itemdisc_01, sprite_get_width(itemdisc_01)*2, sprite_get_height(itemdisc_01)*2,,UI_RELATIVE_TO.MIDDLE_CENTER);
	_grid.addToCell(_sprite, 0, 0);
}

if (!ui_exists("Panel_Quest")) {
	var _dim = ui_get("Panel_TimeOfDay").getDimensions();
	var _y = _dim.y + _dim.height + 30;
	var _panel = new UIPanel("Panel_Quest", -30, _y, 280, 200, glass_panel, UI_RELATIVE_TO.TOP_RIGHT);
	_panel.setResizable(false).setMovable(false).setDragBarHeight(0).setImageAlpha(0.9).setTitle("Current Quest").setTitleFormat("[fnt_UI][scale,2][fa_top]");
	
	var _txt = new UIText("Text_Quest", 50, 50, "");
	var _fmt = "[fnt_UI][fa_left][fa_top]";
	_txt.setTextFormat(_fmt).setTextFormatMouseover(_fmt).setTextFormatClick(_fmt);
	_panel.add(_txt);
	
	_panel.setPreRenderCallback(function() {
		ui_get("Panel_Quest").setVisible(obj_NPC.quest != undefined);
	})
}

if (!ui_exists("Panel_Toolbar")) {
	var _num_slots = 4;
	var _slot_size = 90;
	var _margin = 10;
	var _spacing = 10;
	var _width = _num_slots * _slot_size + 2 * _margin + (_num_slots-1) * _spacing;
	var _height = _slot_size + 2 * _margin;
	
	var _panel = new UIPanel("Panel_Toolbar", 0, -30, _width, _height, glass_panel, UI_RELATIVE_TO.BOTTOM_CENTER);
	_panel.setResizable(false).setMovable(false).setDragBarHeight(0).setImageAlpha(0.9);
	
	var _grid = new UIGrid("Grid_Toolbar", 1, 4);
	_grid.setMargins(_margin).setSpacingHorizontal(_spacing);
	_panel.add(_grid);
	
	self.mark_selected = function() {
		var _sprite = obj_Player.current_tool == _button.getUserData("tool_idx") ? dt_box_9slice_c_selected : dt_box_9slice_c;
		_button.setSprite(_sprite);
	};
	
	self.set_tool = function() {
		obj_Player.current_tool = _button.getUserData("tool_idx");
	};
	
	var _button = new UIButton("Button_Toolbar_dig", 0, 0, 0, 0, "[fa_center][fa_middle][scale,3][shovel]", dt_box_9slice_c_selected, UI_RELATIVE_TO.MIDDLE_CENTER);
	_button.setInheritHeight(true).setInheritWidth(true).setSpriteClick(lt_box_9slice_c).setSpriteMouseover(lt_box_9slice_c);
	_button.setUserData("tool_idx", 0);
	_button.setPreRenderCallback(method({_button}, self.mark_selected));
	_button.setCallback(UI_EVENT.MOUSE_ENTER, self.hover_sound);
	_button.setCallback(UI_EVENT.LEFT_CLICK, self.click_sound);
	_button.setCallback(UI_EVENT.LEFT_RELEASE, method({_button}, self.set_tool));
	_grid.addToCell(_button, 0, 0);
	
	var _button = new UIButton("Button_Toolbar_watering", 0, 0, 0, 0, "[fa_center][fa_middle][scale,3][water]", dt_box_9slice_c, UI_RELATIVE_TO.MIDDLE_CENTER);
	_button.setInheritHeight(true).setInheritWidth(true).setSpriteClick(lt_box_9slice_c).setSpriteMouseover(lt_box_9slice_c);
	_button.setUserData("tool_idx", 1);
	_button.setPreRenderCallback(method({_button}, self.mark_selected));
	_button.setCallback(UI_EVENT.MOUSE_ENTER, self.hover_sound);
	_button.setCallback(UI_EVENT.LEFT_CLICK, self.click_sound);
	_button.setCallback(UI_EVENT.LEFT_RELEASE, method({_button}, self.set_tool));
	_grid.addToCell(_button, 0, 1);
	
	var _button = new UIButton("Button_Toolbar_axe", 0, 0, 0, 0, "[fa_center][fa_middle][scale,3][axe]", dt_box_9slice_c, UI_RELATIVE_TO.MIDDLE_CENTER);
	_button.setInheritHeight(true).setInheritWidth(true).setSpriteClick(lt_box_9slice_c).setSpriteMouseover(lt_box_9slice_c);
	_button.setUserData("tool_idx", 2);
	_button.setPreRenderCallback(method({_button}, self.mark_selected));
	_button.setCallback(UI_EVENT.LEFT_RELEASE, method({_button}, self.set_tool));
	_button.setCallback(UI_EVENT.MOUSE_ENTER, self.hover_sound);
	_button.setCallback(UI_EVENT.LEFT_CLICK, self.click_sound);
	_grid.addToCell(_button, 0, 2);
	
	var _button = new UIButton("Button_Toolbar_plant", 0, 0, 0, 0, "[fa_center][fa_middle][scale,3][plant]", dt_box_9slice_c, UI_RELATIVE_TO.MIDDLE_CENTER);
	_button.setInheritHeight(true).setInheritWidth(true).setSpriteClick(lt_box_9slice_c).setSpriteMouseover(lt_box_9slice_c);
	_button.setUserData("tool_idx", 3);
	_button.setPreRenderCallback(method({_button}, self.mark_selected));
	_button.setCallback(UI_EVENT.LEFT_RELEASE, method({_button}, self.set_tool));
	_button.setCallback(UI_EVENT.MOUSE_ENTER, self.hover_sound);
	_button.setCallback(UI_EVENT.LEFT_CLICK, self.click_sound);
	_grid.addToCell(_button, 0, 3);	
}

if (!ui_exists("Panel_Inventory")) {
	var _num_rows = 2;
	var _num_cols = 2;
	var _slot_size = 90;
	var _margin = 20;
	var _spacing = 15;
	var _margin_top = 60;
	var _width = _num_cols * _slot_size + 2 * _margin + (_num_cols-1) * _spacing;
	var _height = _num_rows * _slot_size + _margin_top + _margin + (_num_rows-1) * _spacing;
	
	var _panel = new UIPanel("Panel_Inventory", 0, 0, _width, _height, dt_box_9slice_c, UI_RELATIVE_TO.MIDDLE_CENTER);
	_panel.setResizable(false).setImageAlpha(0.9).setTitle("Inventory").setTitleFormat("[fnt_UI][scale,2][fa_top]").setDragBarHeight(_margin_top);
	_panel.setVisible(false);
	
	var _grid = new UIGrid("Grid_Inventory", _num_rows, _num_cols);
	_grid.setMargins(_margin).setMarginTop(_panel.getDragBarHeight()).setSpacingHorizontal(_spacing).setSpacingVertical(_spacing);
	_panel.add(_grid);
	
	for (var _row=0; _row<_num_rows; _row++) {
		for (var _col=0; _col<_num_cols; _col++) {
			_grid.getCell(_row, _col).setInteractable(true);
			_grid.getCell(_row, _col).setSprite(lt_box_9slice_c);
			var _sprite = new UISprite(string($"Sprite_Inventory_{_row}_{_col}"), 0, 0, undefined,,,,UI_RELATIVE_TO.MIDDLE_CENTER);
			_sprite.setUserData("row", _row).setUserData("col", _col);
			_sprite.setCallback(UI_EVENT.MOUSE_ENTER, method({_row, _col, _num_cols}, function() {
				Game.hover_sound();

				ui_get("Panel_Tooltip").setVisible(true);
				ui_set_focused_panel("Panel_Tooltip");
				var _idx = _row * _num_cols + _col;
				var _item = obj_Player.inventory[_idx];
				ui_get("Text_Tooltip").setText(_item.item_name, true);
			}));
			_sprite.setCallback(UI_EVENT.MOUSE_EXIT, function() {
				ui_get("Panel_Tooltip").setVisible(false);
				ui_get("Text_Tooltip").setText("", true);
			});
			_grid.getCell(_row, _col).setCallback(UI_EVENT.LEFT_CLICK, method({_row, _col, _num_cols}, function() {
				Game.click_sound();
				var _idx = _row * _num_cols + _col;
				obj_Player.currently_dragged_item = _idx;
			}));
			_grid.getCell(_row, _col).setCallback(UI_EVENT.LEFT_RELEASE, method({_row, _col, _num_cols}, function() {
				if (obj_Player.currently_dragged_item != undefined) {
					var _idx = _row * _num_cols + _col;
					var _temp = obj_Player.inventory[_idx];
					obj_Player.inventory[_idx] = obj_Player.inventory[obj_Player.currently_dragged_item];
					obj_Player.inventory[obj_Player.currently_dragged_item] = _temp;
				}
			}));
			_sprite.setDrillThroughLeftClick(true);
			_sprite.setDrillThroughLeftRelease(true);
			_grid.addToCell(_sprite, _row, _col);
			var _qty_txt = new UIText(string($"Text_Quantity_Inventory_{_row}_{_col}"), -5, -5, "", UI_RELATIVE_TO.BOTTOM_RIGHT);
			_qty_txt.setTextFormat("[fnt_UI][fa_right][fa_bottom]", true);
			_grid.addToCell(_qty_txt, _row, _col);
		}
	}
	
	_panel.setPreRenderCallback(function() {
		for (var _i=0, _n=obj_Player.inventory_max_size; _i<_n; _i++) {
			var _item = _i < array_length(obj_Player.inventory) ? obj_Player.inventory[_i] : undefined;
			var _row = _i div 2;
			var _col = _i % 2;
				
			if (_item != undefined) {
				var _sprite = sprite_exists(asset_get_index(_item.item_name)) ? asset_get_index(_item.item_name) : asset_get_index(_item.item_name+"_05");
				var _scale = 3;
				ui_get(string($"Sprite_Inventory_{_row}_{_col}")).setSprite(_sprite).setDimensions(,,sprite_get_width(_sprite) * _scale, sprite_get_height(_sprite) * _scale);				
				var _str = _item.qty == 1 ? "" : string($"({_item.qty})");
				ui_get(string($"Text_Quantity_Inventory_{_row}_{_col}")).setText(_str, true);
			}
			else {
				ui_get(string($"Sprite_Inventory_{_row}_{_col}")).setSprite(undefined).setDimensions(,,0,0);
				ui_get(string($"Text_Quantity_Inventory_{_row}_{_col}")).setText("", true);
			}
		}
	});
}

if !(ui_exists("Panel_Tooltip")) {
	var _panel = new UIPanel("Panel_Tooltip", 0, 0, 210, 80, glass_panel);
	_panel.setResizable(false).setMovable(false);
	_panel.setVisible(false);
	
	_panel.setPreRenderCallback(function() {
		ui_get("Panel_Tooltip").setDimensions(device_mouse_x_to_gui(0)+30, device_mouse_y_to_gui(0));
	});
	
	var _txt = new UIText("Text_Tooltip", 30, 0, "", UI_RELATIVE_TO.MIDDLE_LEFT);
	_txt.setTextFormat("[c_white][fnt_UI][fa_middle][fa_left][scale,2]");
	_panel.add(_txt);
}

if !(ui_exists("Panel_NPC_Textbox")) {
	var _panel = new UIPanel("Panel_NPC_Textbox", 0, 30, 500, 100, glass_panel, UI_RELATIVE_TO.TOP_CENTER);
	_panel.setResizable(false).setMovable(false);
	_panel.setVisible(false);
	
	var _grp_margin = 20;
	var _grp = new UIGroup("Group_NPC_Textbox", 0, 0, _panel.getDimensions().width - _grp_margin, 80, lt_box_9slice_c, UI_RELATIVE_TO.MIDDLE_CENTER);
	_panel.add(_grp);
	
	var _txt = new UIText("Text_NPC_Textbox", 0, 0, "", UI_RELATIVE_TO.MIDDLE_CENTER);
	_txt.setTextFormat("[fnt_UI][fa_center][fa_middle][scale,2]", true);
	_txt.setTypist(self.typist);
	_grp.add(_txt);
}

if (obj_Player.currently_dragged_item != undefined) {
	var _item = obj_Player.inventory[obj_Player.currently_dragged_item];
	if (_item != undefined) {
		var _sprite = sprite_exists(asset_get_index(_item.item_name)) ? asset_get_index(_item.item_name) : asset_get_index(_item.item_name+"_05");
		draw_sprite_ext(_sprite, 0, device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), 3, 3, 0, c_white, 0.5);
		
		if (InputReleased(INPUT_VERB.USE_TOOL)) {
			if (!ui_is_interacting()) {
				var _dir = point_direction(obj_Player.x, obj_Player.y, device_mouse_x(0), device_mouse_y(0));
				var _dx = lengthdir_x(16, _dir);
				var _dy = lengthdir_y(16, _dir);
				var _is_crop = !asset_get_index(_item.item_name);
				instance_create_layer(obj_Player.x+_dx, obj_Player.y+_dy, "lyr_Crops", obj_Item, {item_name: _item.item_name, qty: _item.qty, is_crop: _is_crop})
				obj_Player.inventory_remove(_item.item_name, _item.qty);
			}
			obj_Player.currently_dragged_item = undefined;
		}
	}
}