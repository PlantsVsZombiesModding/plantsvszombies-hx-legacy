package com.popcap.flash.games.pvz.renderables;

import com.popcap.flash.framework.graphics.Graphics2D;
import com.popcap.flash.framework.render.Renderable;
import com.popcap.flash.framework.resources.fonts.FontInst;
import com.popcap.flash.framework.resources.images.ImageInst;
import com.popcap.flash.framework.utils.Utils;
import openfl.geom.Rectangle;

class StringRenderable implements Renderable {
	public static inline final JUSTIFY_CENTER = "center";

	public static inline final JUSTIFY_LEFT = "left";

	public static inline final JUSTIFY_RIGHT = "right";

	var mTextImage:ImageInst;

	var mImageRed:Float = 1;

	var mBounds:Rectangle;

	var mTextBounds:Rectangle;

	var mImageAlpha:Float = 1;

	var mLines:Array<ASAny>;

	var mDepth:Float = Math.NaN;

	var mFont:FontInst;

	var mJustify:String = "center";

	var mImageBlue:Float = 1;

	var mDead:Bool = false;

	var mImageGreen:Float = 1;

	var mText:String;

	public function new(depth:Float = 0) {
		// super();
		this.mDepth = depth;
		this.mBounds = new Rectangle();
		this.mTextBounds = new Rectangle();
		this.mDead = false;
		this.mLines = new Array<ASAny>();
	}

	@:flash.property @:isVar public var dead(never, set):Bool;

	public function set_dead(value:Bool):Bool {
		return this.mDead = value;
	}

	public function draw(g:Graphics2D) {
		if (this.mFont == null) {
			return;
		}
		if (this.mTextImage == null) {
			return;
		}
		g.blitImage(this.mTextImage, this.mTextBounds.x, this.mTextBounds.y);
	}

	public function getDepth():Float {
		return this.mDepth;
	}

	public function update() {}

	@:flash.property @:isVar public var text(never, set):String;

	public function set_text(value:String):String {
		this.mText = value;

		this.redrawText();
		return value;
	}

	public function setColor(a:Float, r:Float, g:Float, b:Float) {
		this.mImageAlpha = a;
		this.mImageRed = r;
		this.mImageGreen = g;
		this.mImageBlue = b;
		if (this.mTextImage != null) {
			this.mTextImage.setColor(a, r, g, b);

			this.mTextImage.useColor = true;
		}
	}

	@:flash.property @:isVar public var font(never, set):FontInst;

	public function set_font(value:FontInst):FontInst {
		this.mFont = value;
		this.redrawText();
		return value;
	}

	function redrawText() {
		var justification = Utils.JUSTIFY_CENTER;
		if (this.mJustify == JUSTIFY_LEFT) {
			justification = Utils.JUSTIFY_LEFT;
		} else if (this.mJustify == JUSTIFY_RIGHT) {
			justification = Utils.JUSTIFY_RIGHT;
		}
		this.mTextImage = Utils.createStringImage(this.mText, this.mFont, this.mBounds, justification);
		if (this.mTextImage == null) {
			return;
		}
		this.mTextBounds.x = 0;

		this.mTextBounds.y = 0;
		this.mTextBounds.width = this.mTextImage.width;
		this.mTextBounds.height = this.mTextImage.height;
		Utils.align(this.mTextBounds, this.mBounds, justification, Utils.ALIGN_CENTER);
	}

	public function getIsDisposable():Bool {
		return this.mDead;
	}

	@:flash.property @:isVar public var justification(never, set):String;

	public function set_justification(value:String):String {
		this.mJustify = value;

		this.redrawText();
		return value;
	}

	@:flash.property @:isVar public var x(never, set):Float;

	public function set_x(value:Float):Float {
		return this.mBounds.x = value;
	}

	@:flash.property @:isVar public var y(never, set):Float;

	public function set_y(value:Float):Float {
		return this.mBounds.y = value;
	}

	public function setBounds(x:Float, y:Float, width:Float, height:Float) {
		this.mBounds.x = x;
		this.mBounds.y = y;

		this.mBounds.width = width;
		this.mBounds.height = height;
		this.redrawText();
	}

	public function getIsVisible():Bool {
		return true;
	}

	public function toString():String {
		return "String@" + this.mDepth;
	}
}
