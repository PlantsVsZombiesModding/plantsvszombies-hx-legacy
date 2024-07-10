package com.popcap.flash.framework.utils;

import com.popcap.flash.framework.resources.fonts.FontInst;
import com.popcap.flash.framework.resources.images.ImageData;
import com.popcap.flash.framework.resources.images.ImageInst;
import flash.display.BitmapData;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;

class Utils {
	public static inline final ALIGN_LEFT:Float = -1;

	public static inline final ALIGN_RIGHT:Float = 1;

	public static inline final ALIGN_BOTTOM:Float = 1;

	public static inline final JUSTIFY_RIGHT:Float = 1;

	public static inline final ALIGN_CENTER:Float = 0;

	public static inline final ALIGN_NONE:Float = -2;

	public static inline final JUSTIFY_CENTER:Float = 0;

	public static inline final ALIGN_TOP:Float = -1;

	public static inline final JUSTIFY_LEFT:Float = -1;

	public function new() {
		// super();
	}

	static function splitText(str:String, font:FontInst, bounds:Rectangle):Array<ASAny> {
		var aLine:String = null;
		var aLineWidth = Math.NaN;
		var aLineFragment:String = null;
		var words:Array<ASAny> = null;
		var aNumWords = 0;
		var j = 0;
		var aWord:String = null;
		var aWidth = Math.NaN;
		var results = new Array<ASAny>();
		if (bounds.width == 0 || bounds.height == 0) {
			return results;
		}
		if (str == null || str.length == 0) {
			return results;
		}
		var aSpaceWidth = font.stringWidth(" ");
		var aLineNumber = 0;
		var lines:Array<ASAny> = (cast new compat.RegExp("[\\n\\r]+").split(str));
		var aNumLines = lines.length;
		for (i in 0...aNumLines) {
			aLine = ASCompat.toString(lines[i]);
			aLineWidth = 0;
			aLineFragment = "";
			words = (cast new compat.RegExp("[ \\t]+").split(aLine));
			aNumWords = words.length;
			for (_tmp_ in 0...aNumWords) {
				j = _tmp_;
				aWord = ASCompat.toString(words[j]);
				aWidth = font.stringWidth(aWord);
				if (aLineWidth + aWidth < bounds.width) {
					if (aLineFragment.length == 0) {
						aLineFragment = aWord;
					} else {
						aLineFragment = aLineFragment + " " + aWord;
					}
					aLineWidth += aWidth;
				} else {
					results[aLineNumber] = aLineFragment;
					aLineNumber += 1;
					aLineFragment = aWord;
					aLineWidth = aWidth;
				}
				aLineWidth += aSpaceWidth;
			}
			results[aLineNumber] = aLineFragment;
			aLineNumber += 1;
			aLineFragment = "";
			aLineWidth = 0;
		}
		return results;
	}

	public static function createStringImage(str:String, font:FontInst, bounds:Rectangle, justification:Float):ImageInst {
		var aLine:String = null;
		var aLineWidth = Math.NaN;
		var x = Math.NaN;
		var y = Math.NaN;
		var lines = splitText(str, font, bounds);
		if (lines.length == 0) {
			return null;
		}
		var aImgWidth:Float = 0;
		var aImgHeight:Float = 0;
		var i = 0;
		var aNumLines = lines.length;
		var i:ASAny = 0;
		while (i < aNumLines) {
			aLine = ASCompat.toString(lines[i]);
			aLineWidth = font.stringImageWidth(aLine);
			aImgWidth = aImgWidth < aLineWidth ? aLineWidth : aImgWidth;
			i++;
		}
		if (aImgWidth == 0) {
			return null;
		}
		aImgHeight = font.getHeight();
		aImgHeight += (aNumLines - 1) * (font.getAscent() + font.getLineSpacing());
		if (aImgHeight == 0) {
			return null;
		}
		var textImage = new ImageInst(new ImageData(new BitmapData(Std.int(aImgWidth), Std.int(aImgHeight), true, 0)));
		var g = textImage.graphics;
		g.setFont(font);
		var i:ASAny = 0;
		while (i < aNumLines) {
			aLine = ASCompat.toString(lines[i]);
			x = 0;
			y = 0;
			if (justification == JUSTIFY_LEFT) {
				x = 0;
			} else if (justification == JUSTIFY_RIGHT) {
				x = aImgWidth - font.stringWidth(aLine);
			} else {
				x = (Std.int(aImgWidth) >> 1) - (Std.int(font.stringWidth(aLine)) >> 1);
			}
			y = i * (font.getAscent() + font.getLineSpacing());
			g.drawString(aLine, x, y);
			i++;
		}
		return textImage;
	}

	public static function align(targetBounds:Rectangle, anchorBounds:Rectangle, hAlign:Float = 0, vAlign:Float = 0) {
		if (hAlign == ALIGN_LEFT) {
			targetBounds.left = anchorBounds.left;
		} else if (hAlign == ALIGN_RIGHT) {
			targetBounds.right = anchorBounds.right;
		} else if (hAlign == ALIGN_CENTER) {
			targetBounds.x = anchorBounds.x + anchorBounds.width / 2 - targetBounds.width / 2;
		}
		if (vAlign == ALIGN_TOP) {
			targetBounds.top = anchorBounds.top;
		} else if (vAlign == ALIGN_BOTTOM) {
			targetBounds.bottom = anchorBounds.bottom;
		} else if (vAlign == ALIGN_CENTER) {
			targetBounds.y = anchorBounds.y + anchorBounds.height / 2 - targetBounds.height / 2;
		}
	}

	public static function createMergedImage(images:Array<ASAny>, sourceRects:Array<ASAny>, destPoints:Array<ASAny>):ImageInst {
		var img:ImageInst = null;
		var src:Rectangle = null;
		var dest:Point = null;
		var l = 0;
		var r = 0;
		var t = 0;
		var b = 0;
		var matrix = new Matrix();
		var bounds = new Rectangle();
		var len = images.length;
		for (i in 0...len) {
			src = sourceRects[i];
			dest = destPoints[i];
			l = Std.int(dest.x);
			r = Std.int(dest.x + src.width);
			t = Std.int(dest.y);
			b = Std.int(dest.y + src.height);
			bounds.left = l < bounds.left ? l : bounds.left;
			bounds.right = r > bounds.right ? r : bounds.right;
			bounds.top = t < bounds.top ? t : bounds.top;
			bounds.bottom = b > bounds.bottom ? b : bounds.bottom;
		}
		var merged = new BitmapData(Std.int(bounds.width), Std.int(bounds.height), true, 0);
		for (k in 0...len) {
			img = images[k];
			src = sourceRects[k];
			dest = destPoints[k];
			dest.x -= bounds.x;
			dest.y -= bounds.y;
			merged.copyPixels(img.pixels, src, dest);
		}
		return new ImageInst(new ImageData(merged));
	}

	public static function getDigits(input:Int):Vector<Int> {
		var str = Std.string(input);
		var digits = new Vector<Int>();
		var len = str.length;
		for (i in (0...len).reverse()) {
			digits.push(ASCompat.toInt(str.charAt(i)));
		}

		return digits;
	}
}
