package;

import flixel.FlxG;
import flixel.FlxCamera;
import flixel.math.FlxPoint;

// Class to abstract away the diferences between mouse input
// and touch input
class TouchInput {
    #if MOBILE
    #else
	public static function getTouch(?cam:FlxCamera):Touch {
		if (FlxG.mouse.pressed || FlxG.mouse.justReleased) {
			var res = new Touch();
			res.position = FlxG.mouse.getWorldPosition(cam);
			res.justPressed = FlxG.mouse.justPressed;
			res.justReleased = FlxG.mouse.justReleased;
			return res;
		}

		return null;
	}
    #end
}

class Touch {
	public var position:FlxPoint;
	public var justPressed:Bool;
	public var justReleased:Bool;

	public function new() {}
}
