package com;

import com.XMLC_Version;
import com.XMLC_Cheats;

/*
	this class exists for one reason,
	cant export if xml is referenced,
	if the class has XML in it, it just wont convert the file. 
	so it'll say it doesnt exist.
	kind of bullshitty but whatever.
 */
class XMLC {
	public var version:XMLC_Version;
	public var cheats:XMLC_Cheats;

	public var MSN:XMLC_Cheats;

	public var x:Float = 0;
	public var y:Float = 0;

	public var kx:Float = 0;
	public var ky:Float = 0;

	public var sx:Float = 0;
	public var sy:Float = 0;

	public var f:Float = 0;

	public var a:Float = 0;

	public var i:Float = 0;

	public var fps:Float = 0;

	public var track:Array<ASAny>;
	public var t:Array<ASAny>;
	public var name:String = "";

	public var upsell:Bool = false;

	public function new(p1:Float) {
		cheats = new XMLC_Cheats();
		version = new XMLC_Version();
		MSN = new XMLC_Cheats();
	}

	public function copy():ASAny {
		return this;
	}
}
