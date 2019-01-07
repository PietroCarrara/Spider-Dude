package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import entities.Character;

class PlayState extends FlxState {
	var char:Character;

	override public function create():Void {
		super.create();

		char = new Character();
		this.add(char);
		this.camera.follow(char);

		var sqr = new FlxSprite();
		sqr.x = 200;
		sqr.makeGraphic(200, 200);
		this.add(sqr);

		this.camera.follow(sqr);
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
	}
}
