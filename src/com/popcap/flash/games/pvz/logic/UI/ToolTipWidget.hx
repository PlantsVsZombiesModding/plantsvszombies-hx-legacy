package com.popcap.flash.games.pvz.logic.ui;

import com.popcap.flash.framework.graphics.Color;
import com.popcap.flash.framework.graphics.Graphics2D;
import com.popcap.flash.framework.resources.fonts.FontInst;
import com.popcap.flash.framework.resources.images.ImageInst;
import com.popcap.flash.games.pvz.PVZApp;
import com.popcap.flash.games.pvz.logic.Board;
import com.popcap.flash.games.pvz.resources.PVZFonts;

class ToolTipWidget {
	public static inline final TOOLTIP_LINE_SPACING = 2;

	public static inline final TOOLTIP_SIDE_SPACING = 5;

	public static inline final TOOLTIP_TOP_SPACING = 3;

	public var mFontBold:FontInst;

	public var mMaxBottom:Int = 0;

	public var mVisible:Bool = false;

	public var mLabel:String;

	public var mY:Int = 0;

	public var mGetsLinesWidth:Int = 0;

	public var mX:Int = 0;

	public var mMinLeft:Int = 0;

	public var mToolTipImage:ImageInst;

	public var mWidth:Int = 0;

	public var mFont:FontInst;

	public var app:PVZApp;

	public var mCenter:Bool = false;

	public var mTitle:String;

	public var mHeight:Int = 0;

	public var mBoard:Board;

	public var mWarningFlashCounter:Int = 0;

	public var mWarningText:String;

	public function new(app:PVZApp, theBoard:Board) {
		// super();
		this.app = app;
		this.mBoard = theBoard;
		this.mX = 0;
		this.mY = 0;
		this.mWidth = 0;
		this.mHeight = 0;
		this.mVisible = true;
		this.mCenter = false;
		this.mMinLeft = 0;
		this.mMaxBottom = Board.BOARD_HEIGHT;
		this.mGetsLinesWidth = 0;
		this.mWarningFlashCounter = 0;
		this.mFont = app.fontManager.getFontInst(PVZFonts.FONT_PICO129);
		this.mFont.setColor(1, 0, 0, 0);
		this.mFontBold = app.fontManager.getFontInst(PVZFonts.FONT_PIX118BOLD);
		this.mFontBold.setColor(1, 0, 0, 0);
		this.mLabel = "";
		this.mTitle = "";
		this.mWarningText = "";
	}

	public function SetWarningText(theWarningText:String) {
		if (theWarningText == "") {
			this.mWarningText = "";
		} else {
			this.mWarningText = this.app.stringManager.translateString(theWarningText);
		}
		this.CalculateSize();
	}

	public function Draw(g:Graphics2D) {
		var x = 0;
		var y = 0;
		var aFontWidth = 0;
		var aWarningColor:Color = null;
		var aLine:String = null;
		if (!this.mVisible) {
			return;
		}
		var aPosX = this.mX;
		if (this.mCenter) {
			aPosX -= Std.int(this.mWidth / 2);
		}
		if (aPosX < this.mMinLeft - g.state.affineMatrix.tx) {
			aPosX = this.mMinLeft - Std.int(g.state.affineMatrix.tx);
		} else if (aPosX + this.mWidth + g.state.affineMatrix.tx > Board.BOARD_WIDTH) {
			aPosX = Board.BOARD_WIDTH - this.mWidth - Std.int(g.state.affineMatrix.tx);
		}
		var aPosY = this.mY;
		if (aPosY < -g.state.affineMatrix.ty) {
			aPosY = Std.int(-g.state.affineMatrix.ty);
		} else if (aPosY + this.mHeight + g.state.affineMatrix.ty > this.mMaxBottom) {
			aPosY = this.mMaxBottom - this.mHeight - Std.int(g.state.affineMatrix.ty);
		}
		if (this.mX > 540) {
			aPosX += Std.int(this.mBoard.x);
		}
		g.fillRect(aPosX - 1, aPosY - 1, this.mWidth + 2, this.mHeight + 2, 4278190080);
		g.fillRect(aPosX, aPosY, this.mWidth, this.mHeight, 4294967240);
		if (this.mX > 540) {
			aPosX -= Std.int(this.mBoard.x);
		}
		aPosY += TOOLTIP_TOP_SPACING - 2;
		if (this.mTitle.length > 0) {
			g.setFont(this.mFontBold);
			aFontWidth = Std.int(this.mFontBold.stringWidth(this.mTitle));
			x = Std.int(aPosX + (this.mWidth - aFontWidth) / 2);
			y = aPosY;
			g.drawString(this.mTitle, x, y);
			aPosY += Std.int(this.mFontBold.getAscent() + TOOLTIP_LINE_SPACING);
		}
		if (this.mWarningText.length > 0) {
			g.setFont(this.mFont);
			aFontWidth = Std.int(this.mFont.stringWidth(this.mWarningText));
			x = Std.int(aPosX + (this.mWidth - aFontWidth) / 2);
			y = aPosY;
			aWarningColor = Color.RGB(1, 0, 0);
			if (this.mWarningFlashCounter > 0) {
				if (this.mWarningFlashCounter % 20 < 10) {
					aWarningColor = Color.RGB(0, 0, 0);
				}
			}
			this.mFont.setColor(aWarningColor.alpha, aWarningColor.red, aWarningColor.green, aWarningColor.blue);
			g.drawString(this.mWarningText, x, y);
			this.mFont.setColor(1, 0, 0, 0);
			aPosY += Std.int(this.mFont.getAscent() + TOOLTIP_LINE_SPACING);
		}
		var aLines = new Array<ASAny>();
		this.GetLines(aLines);
		g.setFont(this.mFont);
		var i = 0;
		while (i < aLines.length) {
			aLine = ASCompat.toString(aLines[i]);
			aFontWidth = Std.int(this.mFont.stringWidth(aLine));
			x = Std.int(aPosX + (this.mWidth - aFontWidth) / 2);
			y = aPosY;
			g.drawString(aLine, x, y);
			aPosY += Std.int(this.mFont.getAscent() + TOOLTIP_LINE_SPACING);
			i++;
		}
	}

	public function FlashWarning() {
		this.mWarningFlashCounter = 70;
	}

	public function CalculateSize() {
		var aWidth = 0;
		var aLines = new Array<ASAny>();
		var aMaxWidth = Std.int(this.mFontBold.stringWidth(this.mTitle));
		var aWarningWidth = Std.int(this.mFont.stringWidth(this.mWarningText));
		aMaxWidth = Std.int(Math.max(aWarningWidth, aMaxWidth));
		this.mGetsLinesWidth = Std.int(Math.max(130, aMaxWidth - 30));
		this.GetLines(aLines);
		var i = 0;
		while (i < aLines.length) {
			aWidth = Std.int(this.mFont.stringWidth(aLines[i]));
			aMaxWidth = Std.int(Math.max(aMaxWidth, aWidth));
			i++;
		}
		var aHeight = TOOLTIP_TOP_SPACING * 2;
		if (this.mTitle.length > 0) {
			aHeight += Std.int(this.mFont.getAscent() + TOOLTIP_LINE_SPACING);
		}
		if (this.mWarningText.length > 0) {
			aHeight += Std.int(this.mFont.getAscent() + TOOLTIP_LINE_SPACING);
		}
		aHeight += Std.int(this.mFont.getAscent() * aLines.length);
		aHeight += TOOLTIP_LINE_SPACING * (aLines.length - 1);
		aMaxWidth += TOOLTIP_SIDE_SPACING * 2;
		this.mWidth = aMaxWidth;

		this.mHeight = aHeight;
	}

	public function SetLabel(theLabel:String) {
		if (theLabel == "") {
			this.mLabel = "";
		} else {
			this.mLabel = this.app.stringManager.translateString(theLabel);
		}

		this.CalculateSize();
	}

	public function Update() {
		if (this.mWarningFlashCounter > 0) {
			--this.mWarningFlashCounter;
		}
	}

	public function GetLines(theLines:Array<ASAny>) {
		var aWord:String = null;
		var aWidth = Math.NaN;
		if (this.mLabel == "") {
			return;
		}
		var aIndexStart = 0;
		var aIndexCur = 0;
		var aCurWidth = 0;
		var theWords:Array<ASAny> = (cast this.mLabel.split(" "));
		var numWords = theWords.length;
		var aSpaceWidth = this.mFont.stringWidth(" ");
		var aLineNumber = 0;
		var aLineWidth:Float = 0;
		var aLineFragment = "";
		for (i in 0...numWords) {
			aWord = ASCompat.toString(theWords[i]);
			aWidth = this.mFont.stringWidth(aWord);
			if (aLineWidth + aWidth < this.mGetsLinesWidth) {
				if (aLineFragment.length == 0) {
					aLineFragment = aWord;
				} else {
					aLineFragment = aLineFragment + " " + aWord;
				}
				aLineWidth += aWidth;
			} else {
				theLines[aLineNumber] = aLineFragment;
				aLineNumber += 1;
				aLineFragment = aWord;
				aLineWidth = aWidth;
			}
			aLineWidth += aSpaceWidth;
		}

		theLines[aLineNumber] = aLineFragment;
	}

	public function SetTitle(theTitle:String) {
		if (theTitle == "") {
			this.mTitle = "";
		} else {
			this.mTitle = this.app.stringManager.translateString(theTitle);
		}
		this.CalculateSize();
	}
}
