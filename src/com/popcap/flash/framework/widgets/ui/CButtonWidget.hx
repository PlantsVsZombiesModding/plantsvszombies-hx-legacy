package com.popcap.flash.framework.widgets.ui;

import com.popcap.flash.framework.graphics.Color;
import com.popcap.flash.framework.graphics.Graphics2D;
import com.popcap.flash.framework.resources.fonts.FontInst;
import com.popcap.flash.framework.resources.images.ImageData;
import com.popcap.flash.framework.resources.images.ImageInst;
import com.popcap.flash.framework.widgets.CWidget;
import com.popcap.flash.games.pvz.renderables.StringRenderable;
import flash.display.BitmapData;
import flash.geom.Rectangle;

class CButtonWidget extends CWidget {
	public static inline final BUTTON_LABEL_RIGHT:Float = 3;

	public static inline final COLOR_BKG:Float = 5;

	public static inline final BUTTON_LABEL_CENTER:Float = 2;

	public static inline final COLOR_MEDIUM_OUTLINE:Float = 4;

	public static inline final COLOR_DARK_OUTLINE:Float = 2;

	public static inline final COLOR_LABEL_HILITE:Float = 1;

	public static inline final COLOR_LABEL:Float = 0;

	public static inline final COLOR_LIGHT_OUTLINE:Float = 3;

	public static inline final BUTTON_LABEL_LEFT:Float = 1;

	var mOverImage:ImageInst;

	var mLabel:String;

	var mLabelJustify:Float = Math.NaN;

	var mOverAlpha:Float = Math.NaN;

	var mDisabledRect:Rectangle;

	var mInverted:Bool = false;

	var mBtnNoDraw:Bool = false;

	var mNormalRect:Rectangle;

	var mDownRect:Rectangle;

	var mTextImage:StringRenderable;

	var mFrameNoDraw:Bool = false;

	var mOverAlphaFadeInSpeed:Float = Math.NaN;

	var mOverAlphaSpeed:Float = Math.NaN;

	var mDisabledImage:ImageInst;

	var mUpImage:ImageInst;

	var mButtonListener:IButtonListener;

	var mFont:FontInst;

	var mOverRect:Rectangle;

	var mDownImage:ImageInst;

	var mId:Float = Math.NaN;

	public function new(id:Float, listener:IButtonListener) {
		super();
		// super();
		this.mId = id;
		this.mFont = null;
		this.mLabelJustify = BUTTON_LABEL_CENTER;
		this.mUpImage = null;
		this.mOverImage = null;
		this.mDownImage = null;
		this.mDisabledImage = null;
		this.mInverted = false;
		this.mBtnNoDraw = false;
		this.mFrameNoDraw = false;
		this.mButtonListener = listener;
		this.mNormalRect = new Rectangle(0, 0, 0, 0);
		this.mOverRect = new Rectangle(0, 0, 0, 0);
		this.mDownRect = new Rectangle(0, 0, 0, 0);
		this.mDisabledRect = new Rectangle(0, 0, 0, 0);
		hasAlpha = true;
		this.mOverAlpha = 0;
		this.mOverAlphaSpeed = 0;
		this.mOverAlphaFadeInSpeed = 0;
		this.mTextImage = new StringRenderable();
		this.setColor(Std.int(COLOR_LABEL), Color.RGB(0, 0, 0));
		this.setColor(Std.int(COLOR_LABEL_HILITE), Color.RGB(0, 0, 0));
		this.setColor(Std.int(COLOR_DARK_OUTLINE), Color.RGB(0, 0, 0));
		this.setColor(Std.int(COLOR_LIGHT_OUTLINE), Color.RGB(1, 1, 1));
		this.setColor(Std.int(COLOR_MEDIUM_OUTLINE), Color.RGB(132 / 255, 132 / 255, 132 / 255));
		this.setColor(Std.int(COLOR_BKG), Color.RGB(212 / 255, 212 / 255, 212 / 255));
		doFinger = true;
	}

	override public function onMouseMove(x:Float, y:Float) {
		super.onMouseMove(x, y);
		this.mButtonListener.buttonMouseMove(this.mId, x, y);
	}

	function drawFrameUp(g:Graphics2D) {
		g.fillRect(0, 0, width, height, colors[Std.int(COLOR_BKG)]);
		g.fillRect(0, 0, width - 1, 1, colors[Std.int(COLOR_LIGHT_OUTLINE)]);
		g.fillRect(0, 0, 1, height - 1, colors[Std.int(COLOR_LIGHT_OUTLINE)]);
		g.fillRect(0, height - 1, width, 1, colors[Std.int(COLOR_DARK_OUTLINE)]);
		g.fillRect(width - 1, 0, 1, height, colors[Std.int(COLOR_DARK_OUTLINE)]);
		g.fillRect(1, height - 2, width - 2, 1, colors[Std.int(COLOR_MEDIUM_OUTLINE)]);
		g.fillRect(width - 2, 1, 1, height - 2, colors[Std.int(COLOR_MEDIUM_OUTLINE)]);
		var aColor:Color = colors[Std.int(COLOR_LABEL)];
		this.mTextImage.setColor(aColor.alpha, aColor.red, aColor.green, aColor.blue);
		this.mTextImage.draw(g);
	}

	@:flash.property @:isVar public var font(get, set):FontInst;

	public function set_font(value:FontInst):FontInst {
		this.mFont = value;
		this.mTextImage.font = value;

		this.refreshFrameImages();
		return value;
	}

	override public function setColor(index:Int, color:Color) {
		super.setColor(index, color);

		var aColor:Color = colors[Std.int(COLOR_LABEL)];
		this.mTextImage.setColor(aColor.alpha, aColor.red, aColor.green, aColor.blue);
	}

	function drawFrameDisabled(g:Graphics2D) {
		g.fillRect(0, 0, width, height, colors[Std.int(COLOR_BKG)]);
		g.fillRect(0, 0, width - 1, 1, colors[Std.int(COLOR_LIGHT_OUTLINE)]);
		g.fillRect(0, 0, 1, height - 1, colors[Std.int(COLOR_LIGHT_OUTLINE)]);
		g.fillRect(0, height - 1, width, 1, colors[Std.int(COLOR_DARK_OUTLINE)]);
		g.fillRect(width - 1, 0, 1, height, colors[Std.int(COLOR_DARK_OUTLINE)]);
		g.fillRect(1, height - 2, width - 2, 1, colors[Std.int(COLOR_MEDIUM_OUTLINE)]);
		g.fillRect(width - 2, 1, 1, height - 2, colors[Std.int(COLOR_MEDIUM_OUTLINE)]);
		var aColor:Color = colors[Std.int(COLOR_LABEL)];

		this.mTextImage.setColor(aColor.alpha, aColor.red, aColor.green, aColor.blue);
		this.mTextImage.draw(g);
	}

	override public function resize(x:Float, y:Float, width:Float, height:Float) {
		super.resize(x, y, width, height);

		this.mTextImage.setBounds(0, 0, width, height);
		this.refreshFrameImages();
	}

	public function isButtonDown():Bool {
		return isDown && isOver && !disabled;
	}

	override public function draw(g:Graphics2D) {
		if (this.mBtnNoDraw) {
			return;
		}
		if (width == 0 || height == 0) {
			return;
		}
		var down = this.isButtonDown();
		if (this.mUpImage == null && this.mDownImage == null) {
			this.refreshFrameImages();
		}
		if (!isDown) {
			if (disabled) {
				g.drawImage(this.mDisabledImage, 0, 0);
			} else if (this.mOverAlpha > 0 && this.haveButtonImage(this.mOverImage, this.mOverRect)) {
				if (this.haveButtonImage(this.mUpImage, this.mNormalRect) && this.mOverAlpha < 1) {
					g.drawImage(this.mUpImage, 0, 0);
				}
				g.drawImage(this.mOverImage, 0, 0);
			} else if ((isOver || isDown) && this.haveButtonImage(this.mOverImage, this.mOverRect)) {
				g.drawImage(this.mOverImage, 0, 0);
			} else if (this.haveButtonImage(this.mUpImage, this.mNormalRect)) {
				g.drawImage(this.mUpImage, 0, 0);
			}
		} else if (this.haveButtonImage(this.mDownImage, this.mDownRect)) {
			g.drawImage(this.mDownImage, 0, 0);
		} else if (this.haveButtonImage(this.mOverImage, this.mOverRect)) {
			g.drawImage(this.mOverImage, 0, 0);
		} else {
			g.drawImage(this.mUpImage, 0, 0);
		}
	}

	function haveButtonImage(image:ImageInst, rect:Rectangle):Bool {
		return image != null || rect.width != 0;
	}

	function drawFrameDown(g:Graphics2D) {
		g.fillRect(0, 0, width, height, colors[Std.int(COLOR_BKG)]);
		g.fillRect(0, 0, width - 1, 1, colors[Std.int(COLOR_DARK_OUTLINE)]);
		g.fillRect(0, 0, 1, height - 1, colors[Std.int(COLOR_DARK_OUTLINE)]);
		g.fillRect(0, height - 1, width, 1, colors[Std.int(COLOR_LIGHT_OUTLINE)]);
		g.fillRect(width - 1, 0, 1, height, colors[Std.int(COLOR_LIGHT_OUTLINE)]);
		g.fillRect(1, 1, width - 3, 1, colors[Std.int(COLOR_MEDIUM_OUTLINE)]);
		g.fillRect(1, 1, 1, height - 3, colors[Std.int(COLOR_MEDIUM_OUTLINE)]);
		g.translate(1, 1);
		var aColor:Color = colors[Std.int(COLOR_LABEL_HILITE)];
		this.mTextImage.setColor(aColor.alpha, aColor.red, aColor.green, aColor.blue);
		this.mTextImage.draw(g);
	}

	function get_font():FontInst {
		return this.mFont;
	}

	override public function onMouseDown(x:Float, y:Float) {
		super.onMouseDown(x, y);

		this.mButtonListener.buttonPress(this.mId);
		markDirty();
	}

	override public function onMouseUp(x:Float, y:Float) {
		super.onMouseUp(x, y);
		if (isOver && widgetManager.hasFocus) {
			this.mButtonListener.buttonRelease(this.mId);
		}
		markDirty();
	}

	override public function onMouseLeave() {
		super.onMouseLeave();
		if (this.mOverAlphaSpeed == 0 && this.mOverAlpha > 0) {
			this.mOverAlpha = 0;
		} else if (this.mOverAlphaSpeed > 0 && this.mOverAlpha == 0) {
			this.mOverAlpha = 1;
		}
		if (isDown
			|| this.haveButtonImage(this.mOverImage, this.mOverRect)
			|| colors[Std.int(COLOR_LABEL_HILITE)] != colors[Std.int(COLOR_LABEL)]) {
			markDirty();
		}
		this.mButtonListener.buttonMouseLeave(this.mId);
	}

	override public function update() {
		super.update();
		markDirty();
		if (isDown && isOver) {
			this.mButtonListener.buttonDownTick(this.mId);
		}
		if (!isDown && !isOver && this.mOverAlpha > 0) {
			if (this.mOverAlphaSpeed > 0) {
				this.mOverAlpha -= this.mOverAlphaSpeed;
				if (this.mOverAlpha < 0) {
					this.mOverAlpha = 0;
				}
			} else {
				this.mOverAlpha = 0;
			}
			markDirty();
		} else if (isOver && this.mOverAlphaFadeInSpeed > 0 && this.mOverAlpha < 1) {
			this.mOverAlpha += this.mOverAlphaFadeInSpeed;
			if (this.mOverAlpha > 1) {
				this.mOverAlpha = 1;
			}

			markDirty();
		}
	}

	@:flash.property @:isVar public var label(get, set):String;

	public function set_label(value:String):String {
		this.mLabel = value;
		this.mTextImage.text = value;
		this.refreshFrameImages();
		return value;
	}

	function refreshFrameImages() {
		if (width == 0 || height == 0) {
			return;
		}
		this.mUpImage = new ImageInst(new ImageData(new BitmapData(Std.int(width), Std.int(height), true, 0)));
		var gUp = new Graphics2D(this.mUpImage.pixels);
		this.drawFrameUp(gUp);
		this.mOverImage = new ImageInst(new ImageData(new BitmapData(Std.int(width), Std.int(height), true, 0)));
		var gOver = new Graphics2D(this.mOverImage.pixels);
		this.drawFrameOver(gOver);
		this.mDownImage = new ImageInst(new ImageData(new BitmapData(Std.int(width), Std.int(height), true, 0)));
		var gDown = new Graphics2D(this.mDownImage.pixels);

		this.drawFrameDown(gDown);
		this.mDisabledImage = new ImageInst(new ImageData(new BitmapData(Std.int(width), Std.int(height), true, 0)));
		var gDisabled = new Graphics2D(this.mDisabledImage.pixels);
		this.drawFrameDisabled(gDisabled);
	}

	override public function setColors(theColors:Array<ASAny>) {
		super.setColors(theColors);
		var aColor:Color = colors[Std.int(COLOR_LABEL)];
		this.mTextImage.setColor(aColor.alpha, aColor.red, aColor.green, aColor.blue);
	}

	function get_label():String {
		return this.mLabel;
	}

	override public function onMouseEnter() {
		super.onMouseEnter();
		if (this.mOverAlphaFadeInSpeed == 0 && this.mOverAlpha > 0) {
			this.mOverAlpha = 0;
		}
		if (isDown
			|| this.haveButtonImage(this.mOverImage, this.mOverRect)
			|| colors[Std.int(COLOR_LABEL_HILITE)] != colors[Std.int(COLOR_LABEL)]) {
			markDirty();
		}
		var aColor:Color = colors[Std.int(COLOR_LABEL_HILITE)];
		this.mTextImage.setColor(aColor.alpha, aColor.red, aColor.green, aColor.blue);
		this.mButtonListener.buttonMouseEnter(this.mId);
	}

	function drawFrameOver(g:Graphics2D) {
		g.fillRect(0, 0, width, height, colors[Std.int(COLOR_BKG)]);
		g.fillRect(0, 0, width - 1, 1, colors[Std.int(COLOR_LIGHT_OUTLINE)]);
		g.fillRect(0, 0, 1, height - 1, colors[Std.int(COLOR_LIGHT_OUTLINE)]);
		g.fillRect(0, height - 1, width, 1, colors[Std.int(COLOR_DARK_OUTLINE)]);
		g.fillRect(width - 1, 0, 1, height, colors[Std.int(COLOR_DARK_OUTLINE)]);
		g.fillRect(1, height - 2, width - 2, 1, colors[Std.int(COLOR_MEDIUM_OUTLINE)]);

		g.fillRect(width - 2, 1, 1, height - 2, colors[Std.int(COLOR_MEDIUM_OUTLINE)]);
		var aColor:Color = colors[Std.int(COLOR_LABEL_HILITE)];
		this.mTextImage.setColor(aColor.alpha, aColor.red, aColor.green, aColor.blue);
		this.mTextImage.draw(g);
	}

	override public function setDisabled(isDisabled:Bool) {
		super.setDisabled(isDisabled);
		if (this.haveButtonImage(this.mDisabledImage, this.mDisabledRect)) {
			markDirty();
		}
	}
}
