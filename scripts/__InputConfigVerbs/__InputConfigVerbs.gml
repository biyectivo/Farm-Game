function __InputConfigVerbs()
{
    enum INPUT_VERB
    {
        //Add your own verbs here!
        UP,
        DOWN,
        LEFT,
        RIGHT,
        USE_TOOL,
		NEXT_TOOL,
		PREV_TOOL,
		INTERACT_PICKUP,
		INVENTORY,
		FULLSCREEN,
		TIME_SPEEDUP,
        PAUSE,
    }
    
    enum INPUT_CLUSTER
    {
        //Add your own clusters here!
        //Clusters are used for two-dimensional checkers (InputDirection() etc.)
        NAVIGATION,
    }
    
    
    InputDefineVerb(INPUT_VERB.UP,					"up",					[vk_up,    "W"],			[-gp_axislv, gp_padu]);
    InputDefineVerb(INPUT_VERB.DOWN,				"down",					[vk_down,  "S"],			[ gp_axislv, gp_padd]);
    InputDefineVerb(INPUT_VERB.LEFT,				"left",					[vk_left,  "A"],			[-gp_axislh, gp_padl]);
    InputDefineVerb(INPUT_VERB.RIGHT,				"right",				[vk_right, "D"],			[ gp_axislh, gp_padr]);
    InputDefineVerb(INPUT_VERB.USE_TOOL,			"use",					[mb_left,  "E"],			[gp_face1, gp_face3]);
    InputDefineVerb(INPUT_VERB.NEXT_TOOL,			"next_tool",			[mb_wheel_down, vk_tab],	[gp_shoulderr, gp_shoulderrb]);
    InputDefineVerb(INPUT_VERB.PREV_TOOL,			"prev_tool",			[mb_wheel_up],				[gp_shoulderl, gp_shoulderlb]);
    InputDefineVerb(INPUT_VERB.INTERACT_PICKUP,		"interact_pickup",		[mb_right, "R"],			[gp_face2, gp_face4]);
    InputDefineVerb(INPUT_VERB.INVENTORY,			"inventory",			["I"],						[gp_select]);
    InputDefineVerb(INPUT_VERB.FULLSCREEN,			"fullscreen",			["F"],						[]);
    InputDefineVerb(INPUT_VERB.PAUSE,				"pause",				[vk_escape],				[gp_start]);
    InputDefineVerb(INPUT_VERB.TIME_SPEEDUP,		"speedup",				[vk_space],					[gp_stickl, gp_stickr]);
    
    
    //Define a cluster of verbs for moving around
    InputDefineCluster(INPUT_CLUSTER.NAVIGATION, INPUT_VERB.UP, INPUT_VERB.RIGHT, INPUT_VERB.DOWN, INPUT_VERB.LEFT);
}
