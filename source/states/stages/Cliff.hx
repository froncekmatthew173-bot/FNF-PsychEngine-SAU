package states.stages;

class Cliff extends SauStageBase
{
	override function create():Void
	{
		add(makeSprite('stages/sau/shag12/bg', -1200, -600, 1.5, 1.5, 0.05, 0.05));
		add(makeSprite('stages/sau/shag12/sea', -1200, 600, 1.5, 1.5, 0.1, 0.1));
		add(makeSprite('stages/sau/shag12/ground', -1200, 800, 2, 2));
	}
}
