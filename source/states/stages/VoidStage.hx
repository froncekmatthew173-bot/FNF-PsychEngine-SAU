package states.stages;

class VoidStage extends SauStageBase
{
	override function createPost():Void
	{
		var background:FlxSprite = new FlxSprite();
		background.scrollFactor.set();
		background.makeGraphic(1, 1, FlxColor.BLACK);
		background.setGraphicSize(5000);
		background.updateHitbox();
		background.screenCenter();
		insert(0, background);
	}
}
