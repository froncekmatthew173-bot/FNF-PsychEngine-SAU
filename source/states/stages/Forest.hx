package states.stages;

import flixel.addons.display.FlxRuntimeShader;
import objects.Character;

class Forest extends SauStageBase
{
	var bfReflection:Character;

	override function create():Void
	{
		add(makeSprite('stages/sau/yomama/bg', -1000, -700, 1, 1, 0.01, 0.01));
		add(makeSprite('stages/sau/yomama/castle', 250, 0, 1, 1, 0.1, 0.1));
		add(makeSprite('stages/sau/yomama/groundback', -1500, 400, 1, 1, 0.75, 0.75));
		add(makeSprite('stages/sau/yomama/groundfront', -1500, 650));
		add(makeSprite('stages/sau/yomama/bgstuff', -1600, -470));
	}

	override function createPost():Void
	{
		var dadShader:FlxRuntimeShader = applyCharacterShader(dad, [0.9, 0.9, 0.9, 1], [0.7, 0.7, 0.7, 0.3], -90, 25);
		setShaderValue(dadShader, 'satinColor', [0.9, 0.9, 0.9, 1]);
		applyCharacterShader(boyfriend, [0.8, 0.8, 0.8, 1], [0.7, 0.7, 0.7, 0.3], -90, 25);

		bfReflection = makeReflection(boyfriend, 0.4, -0.5, 0.8);
		addBehindBF(bfReflection);
		var dadReflection:Character = makeReflection(dad, 0.4, -0.5, 0.69);
		addBehindDad(dadReflection);
	}

	override function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if(bfReflection != null)
			bfReflection.alpha = boyfriend.alpha * 0.4;
	}
}
