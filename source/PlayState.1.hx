package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import entities.Character;
import entities.Platform;

class PlayState extends FlxState {
	var char:Character;
	var platforms:FlxTypedGroup<Platform>;

	override function create():Void {
		super.create();

		char = new Character();
		this.add(char);
		this.camera.follow(char);

		var sqr = new FlxSprite();
		sqr.x = 200;
		sqr.makeGraphic(200, 200);
		this.add(sqr);

		platforms = new FlxTypedGroup<Platform>();
		platforms.add(new Platform(0, -200, 200, 100));

		this.add(platforms);

		FlxG.debugger.track(char);
		FlxG.debugger.track(platforms);
	}

	override function update(elapsed:Float):Void {
		super.update(elapsed);

		FlxG.collide(char, platforms, collide);

		if (FlxG.collide(char, platforms.members[0])) {
			trace("KCT");
		}
	}

	function collide(player:Dynamic, platform:Dynamic) {
		trace("oloko");
	}
}
