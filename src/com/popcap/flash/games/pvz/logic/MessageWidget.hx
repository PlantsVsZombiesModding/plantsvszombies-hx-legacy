package com.popcap.flash.games.pvz.logic;

import com.popcap.flash.framework.graphics.Graphics2D;
import com.popcap.flash.framework.resources.fonts.FontInst;
import com.popcap.flash.framework.resources.images.ImageData;
import com.popcap.flash.framework.resources.images.ImageInst;
import com.popcap.flash.framework.resources.reanimator.Reanimation;
import com.popcap.flash.games.pvz.PVZApp;
import com.popcap.flash.games.pvz.renderables.ImageRenderable;
import com.popcap.flash.games.pvz.renderables.StringRenderable;
import com.popcap.flash.games.pvz.resources.PVZFonts;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;

class MessageWidget {
	public static inline final MESSAGE_STYLE_HINT_TALL_UNLOCKMESSAGE = 9;

	public static inline final MESSAGE_STYLE_TUTORIAL_LATER_STAY = 4;

	public static inline final MESSAGE_STYLE_TUTORIAL_LEVEL1 = 0;

	public static inline final MESSAGE_STYLE_TUTORIAL_LEVEL2 = 2;

	public static inline final MESSAGE_STYLE_HINT_STAY = 7;

	public static inline final MESSAGE_STYLE_TUTORIAL_LATER = 3;

	public static inline final MESSAGE_STYLE_HINT_FAST = 6;

	public static inline final MESSAGE_STYLE_OFF = -1;

	public static inline final MESSAGE_STYLE_BIG_MIDDLE = 11;

	public static inline final MESSAGE_STYLE_HUGE_WAVE = 14;

	public static inline final MESSAGE_STYLE_BIG_MIDDLE_FAST = 12;

	public static inline final MIN_MESSAGE_TIME = 100;

	public static inline final MESSAGE_STYLE_HINT_TALL_LONG = 10;

	public static inline final MESSAGE_STYLE_HINT_LONG = 5;

	public static inline final MESSAGE_STYLE_TUTORIAL_LEVEL1_STAY = 1;

	public static inline final SLIDE_OFF_TIME = 100;

	public static inline final MESSAGE_STYLE_HOUSE_NAME = 13;

	public static inline final MESSAGE_STYLE_HINT_TALL_FAST = 8;

	public var mLabel:String;

	public var mDisplayTime:Int = 0;

	public var mMessageStyleNext:Int = 0;

	public var mReanim:Reanimation;

	public var mLabelNext:String;

	public var app:PVZApp;

	public var mFont:FontInst;

	public var mBounds:Rectangle;

	public var mDuration:Int = 0;

	public var mBoxRenderable:ImageRenderable;

	public var mMessageStyle:Int = 0;

	public var mBoard:Board;

	public var mText:StringRenderable;

	public var mSupplementalText:StringRenderable;

	public var mSlideOffTime:Int = 0;

	public function new(app:PVZApp, theBoard:Board) {
		// super();
		this.app = app;
		this.mBoard = theBoard;
		this.mDuration = 0;
		this.mLabel = null;
		this.mMessageStyle = MESSAGE_STYLE_OFF;
		this.mLabelNext = null;
		this.mMessageStyleNext = MESSAGE_STYLE_OFF;
		this.mSlideOffTime = SLIDE_OFF_TIME;
		this.mFont = app.fontManager.getFontInst(PVZFonts.FONT_HOUSEOFTERROR28);
		this.mFont.setColor(1, 1, 1, 1);
		this.mFont.scale = 0.8;
		this.mText = new StringRenderable(Board.RENDER_LAYER_ABOVE_UI + 1);
		this.mText.setBounds(0, 0, 1, 1);
		this.mText.font = this.mFont;
		this.mText.text = " ";
		this.mText.x = 0;
		this.mText.y = 0;
		this.mSupplementalText = new StringRenderable(Board.RENDER_LAYER_ABOVE_UI + 1);
		this.mSupplementalText.setBounds(0, 0, 1, 1);
		this.mSupplementalText.font = app.fontManager.getFontInst(PVZFonts.FONT_HOUSEOFTERROR16);
		this.mSupplementalText.text = "";
		this.mSupplementalText.x = 0;
		this.mSupplementalText.y = 0;
		this.mBoard.mRenderManager.add(this.mText);
		this.mBoard.mRenderManager.add(this.mSupplementalText);
		var anImage = this.MakeGreyBox(100);
		anImage.x = 0;
		anImage.y = 270;
		this.mBoxRenderable = new ImageRenderable(anImage, Board.RENDER_LAYER_ABOVE_UI);
		this.mBoard.mRenderManager.add(this.mBoxRenderable);
	}

	public function MakeGreyBox(height:Int):ImageInst {
		var h = height;
		var w = 540;
		var aBufferedImage = new ImageInst(new ImageData(new BitmapData(w, h, true, 0)));
		var bufferG = aBufferedImage.graphics;
		bufferG.fillRect(0, 0, w, h, 2281701376);
		return aBufferedImage;
	}

	public function SetLabel(newLabel:String, newStyle:Int) {
		var anImage:ImageInst = null;
		this.mText.text = "";
		this.mSupplementalText.text = "";
		if (this.mText.getIsDisposable()) {
			this.mBoard.mRenderManager.add(this.mText);
		}
		if (this.mSupplementalText.getIsDisposable()) {
			this.mBoard.mRenderManager.add(this.mSupplementalText);
		}
		if (newLabel.length >= 3 && newLabel.charAt(0) == "[") {
			this.mLabel = this.app.stringManager.translateString(newLabel);
		} else {
			this.mLabel = newLabel;
		}
		this.mMessageStyle = newStyle;
		switch (this.mMessageStyle) {
			case MESSAGE_STYLE_HINT_LONG | MESSAGE_STYLE_BIG_MIDDLE | MESSAGE_STYLE_HINT_TALL_LONG:
				this.mDuration = 1500;

			case MESSAGE_STYLE_HINT_TALL_UNLOCKMESSAGE:
				this.mDuration = 500;

			case MESSAGE_STYLE_HINT_FAST | MESSAGE_STYLE_HINT_TALL_FAST | MESSAGE_STYLE_BIG_MIDDLE_FAST | MESSAGE_STYLE_TUTORIAL_LEVEL1 |
				MESSAGE_STYLE_TUTORIAL_LEVEL2 | MESSAGE_STYLE_TUTORIAL_LATER:
				this.mDuration = 500;

			case MESSAGE_STYLE_HINT_STAY | MESSAGE_STYLE_TUTORIAL_LEVEL1_STAY | MESSAGE_STYLE_TUTORIAL_LATER_STAY:
				this.mDuration = 10000;

			case MESSAGE_STYLE_HOUSE_NAME:
				this.mDuration = 250;

			case MESSAGE_STYLE_HUGE_WAVE:
				this.mDuration = 750;
		}
		this.mDisplayTime = this.mDuration;
		this.mBounds = new Rectangle(0, 0, 540, 405);
		switch (this.mMessageStyle) {
			case MESSAGE_STYLE_BIG_MIDDLE:
				this.mBounds.y = 170;
				this.mBounds.height = 100;
				this.mFont.scale = 0.8;
				this.mText.justification = StringRenderable.JUSTIFY_CENTER;

			case MESSAGE_STYLE_TUTORIAL_LEVEL1 | MESSAGE_STYLE_TUTORIAL_LEVEL1_STAY | MESSAGE_STYLE_TUTORIAL_LEVEL2 | MESSAGE_STYLE_TUTORIAL_LATER |
				MESSAGE_STYLE_TUTORIAL_LATER_STAY:
				this.mBounds.y = 270;
				this.mBounds.height = 100;
				this.mFont.scale = 0.8;
				this.mText.justification = StringRenderable.JUSTIFY_CENTER;

			case MESSAGE_STYLE_HINT_STAY | MESSAGE_STYLE_HINT_FAST:
				this.mBounds.y = 350;
				this.mBounds.height = 50;
				this.mFont.scale = 0.8;
				this.mText.justification = StringRenderable.JUSTIFY_CENTER;

			case MESSAGE_STYLE_HOUSE_NAME:
				this.mBounds.y = 300;
				this.mBounds.height = 55;
				this.mFont.scale = 0.8;

			case MESSAGE_STYLE_HUGE_WAVE:
				this.mBounds.x = 0;
				this.mBounds.width = 540;
				this.mFont.scale = 0.8;
				this.mText.justification = StringRenderable.JUSTIFY_CENTER;
		}
		var aGreyBoxHeight = 0;
		switch (this.mMessageStyle) {
			case MESSAGE_STYLE_TUTORIAL_LEVEL1 | MESSAGE_STYLE_TUTORIAL_LEVEL1_STAY | MESSAGE_STYLE_TUTORIAL_LEVEL2 | MESSAGE_STYLE_TUTORIAL_LATER |
				MESSAGE_STYLE_TUTORIAL_LATER_STAY | MESSAGE_STYLE_BIG_MIDDLE:
				aGreyBoxHeight = 100;

			case MESSAGE_STYLE_HINT_STAY | MESSAGE_STYLE_HINT_FAST:
				aGreyBoxHeight = 50;
		}
		if (aGreyBoxHeight > 0 && this.mBoxRenderable.getIsDisposable()) {
			anImage = this.MakeGreyBox(aGreyBoxHeight);
			anImage.x = 0;
			anImage.y = this.mBounds.y;
			this.mBoxRenderable.dead = false;
			this.mBoxRenderable = new ImageRenderable(anImage, Board.RENDER_LAYER_ABOVE_UI);
			this.mBoard.mRenderManager.add(this.mBoxRenderable);
		} else if (aGreyBoxHeight == 0) {
			this.mBoxRenderable.dead = true;
		}
		this.mText.setBounds(this.mBounds.x, this.mBounds.y, this.mBounds.width, this.mBounds.height);
		this.mSupplementalText.setBounds(this.mBounds.x, this.mBounds.y + 40, 540, 40);
		this.mSupplementalText.dead = false;
		this.mSupplementalText.font = this.app.fontManager.getFontInst(PVZFonts.FONT_HOUSEOFTERROR16);
		this.mText.dead = false;
		this.mText.font = this.mFont;
		this.mText.text = this.mLabel;
	}

	public function ClearLabel() {
		this.mDuration = 0;
		this.mText.text = "";
		this.mText.dead = true;
		this.mSupplementalText.text = "";
		this.mSupplementalText.dead = true;
		this.mBoxRenderable.dead = true;
	}

	public function Update() {
		if (this.mBoard == null || this.mBoard.mPaused) {
			return;
		}
		if (this.mDuration > 0 && this.mDuration < 10000) {
			--this.mDuration;
			if (this.mDuration == 0) {
				this.mMessageStyle = MESSAGE_STYLE_OFF;
				if (this.mMessageStyleNext != MESSAGE_STYLE_OFF) {
					this.SetLabel(this.mLabelNext, this.mMessageStyleNext);
					this.mMessageStyleNext = MESSAGE_STYLE_OFF;
				}
			}
		}
	}

	public function Draw(g:Graphics2D) {
		var aColor = Math.NaN;
		var aFontSize = Math.NaN;
		var aSubStr:String = null;
		var aNumWavesPerFlag = 0;
		var aFlags = 0;
		var aFlagStr:String = null;
		if (this.mDuration <= 0) {
			this.mText.dead = true;
			this.mSupplementalText.dead = true;
			this.mBoxRenderable.dead = true;
			return;
		}
		if (this.mMessageStyle == MESSAGE_STYLE_HINT_STAY || this.mMessageStyle == MESSAGE_STYLE_HINT_FAST) {
			this.mSupplementalText.dead = true;
		}
		if (this.mMessageStyle == MESSAGE_STYLE_HOUSE_NAME || this.mMessageStyle == MESSAGE_STYLE_HUGE_WAVE) {}
		var aFlashing = 255;
		var aFadeOut = false;
		var aGreyBoxHeight = 0;
		var aTextOffsetY = 0;
		if (this.mMessageStyle == MESSAGE_STYLE_HOUSE_NAME && this.mBoard.mGameScene == Board.SCENE_LEVEL_INTRO) {
			this.mBounds.x = 25 - this.mBoard.x;
			this.mText.setBounds(this.mBounds.x, this.mBounds.y, this.mBounds.width, this.mBounds.height);
			this.mSupplementalText.setBounds(this.mBounds.x, this.mBounds.y + 40, 540, 40);
		}
		switch (this.mMessageStyle) {
			case MESSAGE_STYLE_TUTORIAL_LEVEL1 | MESSAGE_STYLE_TUTORIAL_LEVEL1_STAY | MESSAGE_STYLE_TUTORIAL_LEVEL2 | MESSAGE_STYLE_TUTORIAL_LATER |
				MESSAGE_STYLE_TUTORIAL_LATER_STAY:
				aGreyBoxHeight = 100;
				aFlashing = 192;
				aColor = TodCommon.TodAnimateCurve(75, 0, this.mBoard.mMainCounter % 75, aFlashing, 255, TodCommon.CURVE_BOUNCE_SLOW_MIDDLE);
				this.mText.setColor(aColor / 255, 253 / 255, 245 / 255, 123 / 255);

			case MESSAGE_STYLE_HINT_STAY | MESSAGE_STYLE_HINT_FAST:
				aGreyBoxHeight = 50;
				this.mText.setColor(1, 1, 1, 1);

			case MESSAGE_STYLE_HOUSE_NAME:
				aColor = TodCommon.ClampInt(this.mDuration * 15, 0, 255);
				this.mText.setColor(aColor / 255, 1, 1, 1);

			case MESSAGE_STYLE_HUGE_WAVE:
				aFontSize = TodCommon.TodAnimateCurveFloat(0, 750, this.mDuration, 0, 30, TodCommon.CURVE_EASE_IN);
				if (aFontSize <= 1) {
					aFontSize = 1;
				}
				this.mText.setColor(1, 1, 0, 0);
		}
		if (this.mMessageStyle == MESSAGE_STYLE_HOUSE_NAME) {
			aSubStr = "";
			if (this.app.IsSurvivalMode() && this.mBoard.mChallenge.mSurvivalStage > 0) {
				aNumWavesPerFlag = this.mBoard.GetNumWavesPerFlag();
				aFlags = Std.int(this.mBoard.mChallenge.mSurvivalStage * this.mBoard.GetNumWavesPerSurvivalStage() / aNumWavesPerFlag);
				aFlagStr = this.mBoard.Pluralize(aFlags, "[ONE_FLAG]", "[COUNT_FLAGS]");
				aSubStr = this.app.stringManager.translateString("[FLAGS_COMPLETED]").split("{FLAGS}").join(aFlagStr);
			}
			if (aSubStr.length > 0) {
				this.mSupplementalText.text = aSubStr;
				this.mSupplementalText.setColor(aColor / 255, 224 / 255, 187 / 255, 98 / 255);
			}
		} else {
			this.mSupplementalText.text = "";
		}
	}
}
