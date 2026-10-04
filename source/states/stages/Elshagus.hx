package states.stages;

class Elshagus extends SauStageBase
{
	override function create():Void
	{
		add(makeSprite('stages/sau/elshagus/bg', -1000, -400, 0.8, 0.8));
		add(makeSprite('stages/sau/elshagus/boxing ring', -1000, 500));
	}
}
