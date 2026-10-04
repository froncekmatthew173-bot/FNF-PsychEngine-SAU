package states.stages;

class Cave extends SauStageBase
{
	override function create():Void
	{
		add(makeSprite('bgs/Weed/Weed sky', -333, -469, 1.2, 1.2, 0.1, 0.1));
		add(makeSprite('bgs/Weed/Weed moon', -417, -392, 1.2, 1.2, 0.1, 0.1));
		add(makeSprite('bgs/Weed/Weed background', -299, -448, 1.2, 1.2));
		add(makeSprite('bgs/Weed/Weed foreground', -299, -448, 1.2, 1.2));
	}

	override function createPost():Void
	{
		for (strum in PlayState.instance.opponentStrums)
			strum.visible = false;
	}
}
