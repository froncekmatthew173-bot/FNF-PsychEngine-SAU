package states.stages;

import objects.Character;
import objects.Note;
import objects.StrumNote;

class Scoobcar extends SauStageBase
{
	var boyfriendReflection:Character;
	var dadReflection:Character;
	var randomOffset:Float = 0;

	override function create():Void
	{
		add(makeSprite('stages/sau/scoobcarbg', -1500, -630, 1.5, 1.5));
	}

	override function createPost():Void
	{
		boyfriendReflection = makeReflection(boyfriend, 1, 0.2, 0.45);
		addBehindBF(boyfriendReflection);
		dadReflection = makeReflection(dad, 1, 0.2, 0.48);
		addBehindDad(dadReflection);
	}

	override function stepHit():Void
	{
		super.stepHit();
		if(curStep == 1881)
		{
			FlxTween.tween(dad, {x: 5000}, 0.3);
			if(dadReflection != null) FlxTween.tween(dadReflection, {x: 5000}, 0.3);
		}
		if(curStep == 1882)
		{
			boyfriend.scale.y = 0.1;
			boyfriend.y += boyfriend.height * 0.34;
		}
		if((curStep >= 560 && curStep < 576) || (curStep >= 580 && curStep <= 588))
			randomOffset = FlxG.random.float(3000, 10000);
	}

	override function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if(boyfriendReflection != null) boyfriendReflection.alpha = boyfriend.alpha;
		if(dadReflection != null) dadReflection.alpha = dad.alpha;
		if((curStep >= 576 && curStep < 580) || curStep > 588)
			randomOffset = FlxMath.lerp(randomOffset, 0, 0.05);
	}

	override function postUpdate(elapsed:Float):Void
	{
		var playState:PlayState = PlayState.instance;
		for (note in playState.notes)
		{
			var usePlayerStrum:Bool = note.mustPress;
			var windowActive:Bool = usePlayerStrum ? (curStep >= 528 && curStep < 591) : (curStep >= 560 && curStep < 591);
			if(!windowActive) continue;

			var strums:FlxTypedGroup<StrumNote> = usePlayerStrum ? playState.playerStrums : playState.opponentStrums;
			if(note.noteData < 0 || note.noteData >= strums.length) continue;
			var strum:StrumNote = strums.members[note.noteData];
			var position:Float = Conductor.songPosition;
			if(usePlayerStrum && curStep < 560)
				position += Conductor.crochet * 24;
			else if(curStep >= 560)
				position += randomOffset;

			note.x = strum.x + (strum.width - note.width) * 0.5;
			note.y = strum.y + (note.strumTime - position) * (0.45 * playState.songSpeed);
			note.angle = strum.angle;
			if(note.isSustainNote) note.y += Note.swagWidth * 0.5;
		}
	}
}
