package com.popcap.flash.framework.widgets.ui;

import com.popcap.flash.framework.graphics.Color;
import com.popcap.flash.framework.graphics.Graphics2D;
import com.popcap.flash.framework.resources.images.ImageInst;
import com.popcap.flash.framework.widgets.CWidget;
import flash.geom.Point;
import flash.geom.Rectangle;

class ImageButtonWidget extends CWidget {
	public static inline final BUTTON_LABEL_RIGHT:Float = 3;

	public static inline final COLOR_BKG:Float = 5;

	public static inline final BUTTON_LABEL_CENTER:Float = 2;

	public static inline final COLOR_MEDIUM_OUTLINE:Float = 4;

	public static inline final COLOR_DARK_OUTLINE:Float = 2;

	public static inline final COLOR_LABEL_HILITE:Float = 1;

	public static inline final COLOR_LABEL:Float = 0;

	public static inline final COLOR_LIGHT_OUTLINE:Float = 3;

	public static inline final BUTTON_LABEL_LEFT:Float = 1;

	var mOverAlphaFadeInSpeed:Float = Math.NaN;

	var mDisabledRect:Rectangle;

	var mOverAlphaSpeed:Float = Math.NaN;

	public var mDisabledImage:ImageInst;

	public var mUpImage:ImageInst;

	public var mOverOffset:Point;

	public var mUpOffset:Point;

	public var mDownOffset:Point;

	var mOverRect:Rectangle;

	var mId:Float = Math.NaN;

	var mButtonListener:IButtonListener;

	public var mDownImage:ImageInst;

	public var mDisableOffset:Point;

	var mDownRect:Rectangle;

	var mNormalRect:Rectangle;

	public var mOverImage:ImageInst;

	var mOverAlpha:Float = Math.NaN;

	public function new(id:Float, listener:IButtonListener) {
		super();
		this.mUpOffset = new Point();
		this.mOverOffset = new Point();
		this.mDownOffset = new Point();
		this.mDisableOffset = new Point();
		// super();
		this.mId = id;
		this.mUpImage = null;
		this.mOverImage = null;
		this.mDownImage = null;
		this.mDisabledImage = null;
		this.mButtonListener = listener;
		this.mNormalRect = new Rectangle(0, 0, 0, 0);
		this.mOverRect = new Rectangle(0, 0, 0, 0);
		this.mDownRect = new Rectangle(0, 0, 0, 0);
		this.mDisabledRect = new Rectangle(0, 0, 0, 0);
		this.mOverAlpha = 0;
		this.mOverAlphaSpeed = 0;
		this.mOverAlphaFadeInSpeed = 0;
		doFinger = true;
	}

	override public function setDisabled(isDisabled:Bool) {
		super.setDisabled(isDisabled);
		if (this.haveButtonImage(this.mDisabledImage, this.mDisabledRect)) {
			markDirty();
		}
	}

	override public function onMouseUp(x:Float, y:Float) {
		super.onMouseUp(x, y);
		if (isOver && widgetManager.hasFocus) {
			this.mButtonListener.buttonRelease(this.mId);
		}
		markDirty();
	}

	function haveButtonImage(image:ImageInst, rect:Rectangle):Bool {
		return image != null || rect.width != 0;
	}

	override public function draw(g:Graphics2D) {
		if (width == 0 || height == 0) {
			return;
		}
		if (!isDown) {
			if (disabled) {
				g.drawImage(this.mDisabledImage, this.mDisableOffset.x, this.mDisableOffset.y);
			} else if (this.mOverAlpha > 0 && this.mOverImage != null) {
				if (this.mUpImage != null && this.mOverAlpha < 1) {
					g.drawImage(this.mUpImage, this.mUpOffset.x, this.mUpOffset.y);
				}
				g.drawImage(this.mOverImage, this.mOverOffset.x, this.mOverOffset.y);
			} else if ((isOver || isDown) && this.mOverImage != null) {
				g.drawImage(this.mOverImage, this.mOverOffset.x, this.mOverOffset.y);
			} else if (this.mUpImage != null) {
				g.drawImage(this.mUpImage, this.mUpOffset.x, this.mUpOffset.y);
			}
		} else if (this.mDownImage != null) {
			g.drawImage(this.mDownImage, this.mDownOffset.x, this.mDownOffset.y);
		} else if (this.mOverImage != null) {
			g.drawImage(this.mOverImage, this.mOverOffset.x, this.mOverOffset.y);
		} else {
			g.drawImage(this.mUpImage, this.mUpOffset.x, this.mUpOffset.y);
		}
	}

	override public function onMouseDown(x:Float, y:Float) {
		super.onMouseDown(x, y);
		this.mButtonListener.buttonPress(this.mId);
		markDirty();
	}

	override public function contains(x:Float, y:Float):Bool {
		var targetImg:ImageInst = null;
		if (isOver) {
			targetImg = this.mOverImage;
		} else if (isDown) {
			targetImg = this.mDownImage;
		} else if (disabled) {
			targetImg = this.mDisabledImage;
		} else {
			targetImg = this.mUpImage;
		}
		if (targetImg == null) {
			return false;
		}
		var localX = x - this.x;
		var localY = y - this.y;
		if (localX < 0) {
			return false;
		}
		if (localY < 0) {
			return false;
		}
		if (localX > targetImg.width - 1) {
			return false;
		}
		if (localY > targetImg.height - 1) {
			return false;
		}
		var color = targetImg.pixels.getPixel32(Std.int(localX), Std.int(localY));
		var alpha:UInt = (color & 4278190080) >> 24;
		return alpha > 0;
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
		this.mButtonListener.buttonMouseEnter(this.mId);
	}

	override public function onMouseMove(x:Float, y:Float) {
		super.onMouseMove(x, y);
		this.mButtonListener.buttonMouseMove(this.mId, x, y);
	}

	public function isButtonDown():Bool {
		return isDown && isOver && !disabled;
	}
}
