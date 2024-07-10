package com.popcap.flash.framework.resources.images;

import openfl.display.BitmapData;

class ImageData {
	public var cels:Array<ASAny>;

	public var cols:Float = Math.NaN;

	public var rows:Float = Math.NaN;

	public var celWidth:Float = Math.NaN;

	public var celHeight:Float = Math.NaN;

	public function new(param1:BitmapData = null, param2:Float = 1, param3:Float = 1) {
		// super();
		this.cels = [param1];
		this.rows = param2;
		this.cols = param3;
	}

	public function toString():String {
		return "Data [" + this.rows + "x" + this.cols + ", " + this.cels + "]";
	}
}
