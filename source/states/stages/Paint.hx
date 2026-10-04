package states.stages;

import flixel.addons.display.FlxRuntimeShader;
import flixel.math.FlxPoint;
import flixel.util.FlxSpriteUtil;
import objects.Character;
import openfl.display.BitmapData;
import openfl.filters.BitmapFilter;
import openfl.filters.ShaderFilter;

class Paint extends SauStageBase
{
	var background:FlxSprite;
	var paintArea:FlxSprite;
	var colorBox:FlxSprite;
	public var selectionBox:FlxSprite;
	public var selectionBoxHUD:FlxSprite;
	public var optionBox:FlxSprite;
	var paletteShader:FlxRuntimeShader;
	var mosaicShader:FlxRuntimeShader;
	var colorIndex:Int = 0;
	var drawColor:Int = 0xFF000000;
	var isDrawing:Bool = false;
	var lastMousePos:FlxPoint;
	var undoList:Array<BitmapData> = [];
	var redoList:Array<BitmapData> = [];
	var colors:Array<Int> = [0xFF000000, 0xFFFF0000, 0xFF0000FF, 0xFF00FF00, 0xFFFF00FF, 0xFFFFFF00, 0xFF00FFFF, 0xFFFFFFFF];
	public var invert:FlxRuntimeShader;
	var previousGameFilters:Null<Array<BitmapFilter>>;
	var previousHudFilters:Null<Array<BitmapFilter>>;
	var previousMouseVisible:Bool;

	override function create():Void
	{
		add(makeSprite('stages/sau/png shag/Bliss', -2200, -1100, 6, 6));
		background = makeSprite('stages/sau/png shag/PNGShagBG1', -1200, -100);
		add(background);
	}

	override function createPost():Void
	{
		previousGameFilters = camGame.filters;
		previousHudFilters = camHUD.filters;
		previousMouseVisible = FlxG.mouse.visible;
		paletteShader = loadShader('palette');
		setShaderValue(paletteShader, 'strength', 1.0);
		setShaderValue(paletteShader, 'paletteSize', 9.0);
		mosaicShader = loadShader('mosaic');
		setShaderValue(mosaicShader, 'strength', 1.0);
		invert = loadShader('invert');
		setShaderValue(invert, 'strength', 0.0);
		applyPaintFilters(camGame);
		applyPaintFilters(camHUD);

		paintArea = new FlxSprite(-1200, 120);
		paintArea.makeGraphic(2820, 1250, FlxColor.WHITE, true);
		var insertionIndex:Int = members.indexOf(background) + 1;
		insert(insertionIndex, paintArea);

		colorBox = new FlxSprite(-1200 + 967, -100 + 94);
		colorBox.makeGraphic(42, 42, FlxColor.WHITE, true);
		colorBox.color = drawColor;
		insert(insertionIndex + 1, colorBox);

		selectionBox = new FlxSprite().loadGraphic(Paths.image('stages/sau/png shag/paintSelection'));
		selectionBox.visible = false;
		selectionBox.alpha = 0;
		selectionBox.screenCenter();
		selectionBox.setGraphicSize(1, 1);
		selectionBox.updateHitbox();
		add(selectionBox);

		selectionBoxHUD = new FlxSprite().loadGraphic(Paths.image('stages/sau/png shag/paintSelection'));
		selectionBoxHUD.visible = false;
		selectionBoxHUD.alpha = 0;
		selectionBoxHUD.cameras = [camHUD];
		selectionBoxHUD.screenCenter();
		selectionBoxHUD.setGraphicSize(1, 1);
		selectionBoxHUD.updateHitbox();
		add(selectionBoxHUD);

		optionBox = new FlxSprite(400, 200);
		optionBox.visible = false;
		add(optionBox);
		FlxG.mouse.visible = true;
	}

	function applyPaintFilters(camera:FlxCamera):Void
	{
		var filters:Array<BitmapFilter> = camera.filters == null ? [] : camera.filters.copy();
		filters.push(new ShaderFilter(paletteShader));
		filters.push(new ShaderFilter(mosaicShader));
		filters.push(new ShaderFilter(invert));
		camera.filters = filters;
	}

	override function destroy():Void
	{
		if(camGame != null) camGame.filters = previousGameFilters;
		if(camHUD != null) camHUD.filters = previousHudFilters;
		FlxG.mouse.visible = previousMouseVisible;
		for (bitmap in undoList) bitmap.dispose();
		for (bitmap in redoList) bitmap.dispose();
		undoList = [];
		redoList = [];
		super.destroy();
	}

	public function tweenSelectionToCharacter(character:Character, duration:Float, ease:Dynamic):Void
	{
		selectionBox.visible = true;
		selectionBoxHUD.visible = false;
		selectionBox.alpha = 1;
		selectionBox.x = character.x;
		selectionBox.y = character.y;
		FlxTween.tween(selectionBox, {width: character.frameWidth, height: character.frameHeight}, duration, {ease: ease});
	}

	public function tweenSelectionToScreen(duration:Float, ease:Dynamic):Void
	{
		selectionBox.visible = false;
		selectionBoxHUD.visible = true;
		selectionBoxHUD.alpha = 1;
		FlxTween.tween(selectionBoxHUD, {x: 0, y: 0, width: FlxG.width, height: FlxG.height}, duration, {ease: ease});
	}

	public function showOptionBox(name:String):Void
	{
		optionBox.loadGraphic(Paths.image('stages/sau/png shag/paintOption' + name));
		optionBox.visible = true;
		optionBox.alpha = 1;
	}

	public function hideOptionBox():Void
	{
		FlxTween.tween(optionBox, {alpha: 0}, 0.5);
	}

	override function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if(paintArea == null) return;

		if(FlxG.mouse.wheel != 0)
		{
			colorIndex = (colorIndex + FlxG.mouse.wheel) % colors.length;
			if(colorIndex < 0) colorIndex += colors.length;
			drawColor = colors[colorIndex];
			colorBox.color = drawColor;
		}

		if(FlxG.mouse.overlaps(paintArea))
		{
			if(FlxG.mouse.justPressed)
			{
				isDrawing = true;
				undoList.insert(0, paintArea.pixels.clone());
				while(undoList.length > 25) undoList.pop();
				for (bitmap in redoList) bitmap.dispose();
				redoList = [];
			}
			if(isDrawing)
			{
				var point:FlxPoint = FlxG.mouse.getWorldPosition();
				point.x -= paintArea.x;
				point.y -= paintArea.y;
				point.x = Math.floor(point.x);
				point.y = Math.floor(point.y);
				if(lastMousePos != null)
					FlxSpriteUtil.drawLine(paintArea, point.x, point.y, lastMousePos.x, lastMousePos.y, {color: drawColor, thickness: 10});
				lastMousePos = point.clone();
			}
		}
		if(FlxG.mouse.justReleased)
		{
			isDrawing = false;
			lastMousePos = null;
		}

		if(FlxG.keys.pressed.CONTROL && FlxG.keys.justPressed.Z && undoList.length > 0)
		{
			redoList.insert(0, paintArea.pixels.clone());
			paintArea.pixels = undoList.shift();
		}
		else if(FlxG.keys.pressed.CONTROL && FlxG.keys.justPressed.Y && redoList.length > 0)
		{
			undoList.insert(0, paintArea.pixels.clone());
			paintArea.pixels = redoList.shift();
		}
	}
}
