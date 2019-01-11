package entities;

import flixel.FlxG;
import flixel.FlxSprite;

class Platform extends FlxSprite {
	// The highest platform created
	private static var highest:Platform;

	public var isHighest(get, never):Bool;

	public function new(x:Float, y:Float, width:Float, height:Float) {
		super(x, y);

		if (highest == null || highest.y > this.y) {
			highest = this;
		}

		this.immovable = true;

		this.makeGraphic(Math.round(width), Math.round(height));

		this.updateHitbox();
	}

	function get_isHighest():Bool {
		return this == highest;
	}

	public static function clearHighest() {
		highest = null;
	}
}
