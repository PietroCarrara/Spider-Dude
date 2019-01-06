package entities;

import flixel.FlxSprite;
import flixel.math.FlxPoint;

class Character extends FlxSprite {

	function new(?x:Float, ?y:Float) {
		super(x, y);
		this.loadGraphic("assets/images/char.png");
		this.scale = new flixel.math.FlxPoint(10, 10);
		this.updateHitbox();
	}

	override function update(dt:Float) {
		super.update(dt);
	}
}
