package entities;

import flixel.FlxG;
import flixel.FlxSprite;

class Platform extends FlxSprite {
	public function new(x:Float, y:Float, width:Float, height:Float) {
		super(x, y);

		this.immovable = true;

		this.makeGraphic(Math.round(width), Math.round(height));

		this.updateHitbox();
	}
}
