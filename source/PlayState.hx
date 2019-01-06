package;

import flixel.FlxState;
import entities.Character;

class PlayState extends FlxState {
	var char:Character;

	override public function create():Void {
		super.create();

		char = new Character();
		this.add(char);
		this.camera.follow(char);
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
	}
}
