package com.popcap.flash.framework.resources.fonts;

import com.popcap.flash.framework.resources.images.ImageInst;
import flash.geom.Point;
import flash.geom.Rectangle;

class CharData {
	public var mKerningOffsets:ASDictionary<ASAny, ASAny>;

	public var mOrder:Float = Math.NaN;

	public var mImage:ImageInst;

	public var mOffset:Point;

	public var mCharCode:Float = Math.NaN;

	public var mWidth:Float = Math.NaN;

	public var mImageRect:Rectangle;

	public function new() {
		// super();
		this.mCharCode = -1;
		this.mImageRect = new Rectangle();
		this.mOffset = new Point();
		this.mKerningOffsets = new ASDictionary<ASAny, ASAny>();
		this.mWidth = 0;
		this.mOrder = 0;
		this.mImage = null;
	}
}
