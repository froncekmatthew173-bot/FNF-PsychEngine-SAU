package states.stages;

class Woods extends SauStageBase
{
	override function create():Void
	{
		add(makeSprite('stages/sau/bg_webiando', -1000, -300, 2.3, 2.3));
	}
}
