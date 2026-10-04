package states.stages;

import flixel.addons.display.FlxRuntimeShader;
import flixel.FlxBasic;
import flixel.tweens.FlxTween;
import objects.Character;
import openfl.utils.Assets;
import openfl.utils.AssetType;

class SauStageBase extends BaseStage
{
	function makeSprite(image:String, x:Float, y:Float, scaleX:Float = 1, scaleY:Float = 1, scrollX:Float = 1, scrollY:Float = 1, animated:Bool = false):FlxSprite
	{
		var sprite:FlxSprite = new FlxSprite(x, y);
		if(animated)
			sprite.frames = Paths.getAtlas(image);
		else
			sprite.loadGraphic(Paths.image(image));
		sprite.scale.set(scaleX, scaleY);
		sprite.updateHitbox();
		sprite.scrollFactor.set(scrollX, scrollY);
		sprite.antialiasing = ClientPrefs.data.antialiasing;
		return sprite;
	}

	function loadShader(name:String):FlxRuntimeShader
	{
		var vertexPath:String = Paths.shaderVertex(name, 'shared');
		var fragmentPath:String = Paths.shaderFragment(name, 'shared');
		var vertexSource:String = readShaderSource(vertexPath);
		var fragmentSource:String = readShaderSource(fragmentPath);
		return new FlxRuntimeShader(fragmentSource, vertexSource);
	}

	function readShaderSource(path:String):String
	{
		#if MODS_ALLOWED
		if(FileSystem.exists(path)) return File.getContent(path);
		#end
		return Assets.exists(path, AssetType.TEXT) ? Assets.getText(path) : null;
	}

	function setShaderValue(shader:FlxRuntimeShader, uniform:String, value:Dynamic):Void
	{
		var entry:Dynamic = Reflect.field(shader.data, uniform);
		if(entry != null) entry.value = value;
	}

	function applyCharacterShader(character:Character, satin:Array<Float>, shadow:Array<Float>, angle:Float, distance:Float):FlxRuntimeShader
	{
		var shader:FlxRuntimeShader = loadShader('RTXLighting');
		setShaderValue(shader, 'overlayColor', [0.0, 0.0, 0.0, 1.0]);
		setShaderValue(shader, 'satinColor', satin);
		setShaderValue(shader, 'innerShadowColor', shadow);
		setShaderValue(shader, 'innerShadowAngle', angle * Math.PI / 180);
		setShaderValue(shader, 'innerShadowDistance', distance);
		character.shader = shader;
		return shader;
	}

	function applySkew(sprite:FlxSprite, xDegrees:Float = 0, yDegrees:Float = 0):FlxRuntimeShader
	{
		var vertexPath:String = Paths.shaderVertex('stageSkew', 'shared');
		var shader:FlxRuntimeShader = new FlxRuntimeShader(null, readShaderSource(vertexPath));
		setShaderValue(shader, 'skewX', Math.tan(xDegrees * Math.PI / 180));
		setShaderValue(shader, 'skewY', Math.tan(yDegrees * Math.PI / 180));
		sprite.shader = shader;
		return shader;
	}

	function makeReflection(source:Character, alpha:Float, scaleY:Float, yOffset:Float, ?xOffset:Float = 0, ?skewXDegrees:Float = 0):Character
	{
		var reflection:Character = new Character(source.x, source.y, source.curCharacter, source.isPlayer);
		reflection.color = 0xFF000000;
		reflection.alpha = alpha;
		reflection.scale.y = scaleY;
		reflection.y += reflection.height * yOffset;
		reflection.cameraPosition[1] -= reflection.height * yOffset;
		reflection.x -= reflection.width * xOffset;
		reflection.cameraPosition[0] += reflection.width * xOffset;
		if(skewXDegrees != 0) applySkew(reflection, skewXDegrees);
		return reflection;
	}

	function insertBefore(target:FlxBasic, sprite:FlxSprite):Void
	{
		var targetIndex:Int = members.indexOf(target);
		insert(targetIndex < 0 ? members.length : targetIndex, sprite);
	}
}
