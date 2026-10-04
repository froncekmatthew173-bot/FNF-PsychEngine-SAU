package states.stages;

class Temple extends SauStageBase
{
	var foreground:FlxSprite;

	override function create():Void
	{
		add(makeSprite('stages/sau/snake shag/Temple Background', 0, 0));
		foreground = makeSprite('stages/sau/snake shag/Temple Foreground', -326, 181);
	}

	override function createPost():Void
	{
		insertBefore(gfGroup, foreground);
	}
}
