package com.popcap.flash.framework.resources.fonts;

import com.popcap.flash.framework.AppBase;
import com.popcap.flash.framework.parsers.desc.DataElement;
import com.popcap.flash.framework.parsers.desc.DescriptionParser;
import com.popcap.flash.framework.parsers.desc.ListDataElement;
import com.popcap.flash.framework.parsers.desc.SingleDataElement;
import com.popcap.flash.framework.resources.images.ImageData;
import com.popcap.flash.framework.resources.images.ImageInst;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.BitmapDataChannel;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.utils.ByteArray;

class TXTFontDescriptor implements FontDescriptor {
	var mImageClazzes:Array<ASAny>;

	var mFontClazz:Class<Dynamic>;

	var mDefines:ASDictionary<ASAny, ASAny>;

	var mData:FontData;

	public function new(fontClazz:Class<Dynamic>, imageClazzes:Array<ASAny>) {
		// super();
		this.mFontClazz = fontClazz;
		this.mImageClazzes = imageClazzes;
	}

	function cmdLayerSetPointSize(args:ListDataElement) {
		var aLayerName = ASCompat.toString(args.mElements[1].mString);
		var aLayer:FontLayer = this.mData.layerMap[aLayerName];
		var aPointSize = ASCompat.toNumber(args.mElements[2].mString);
		aLayer.mPointSize = aPointSize;
	}

	function cmdLayerSetColorMult(args:ListDataElement) {
		var aLayerName = ASCompat.toString(args.mElements[1].mString);
		var aLayer:FontLayer = this.mData.layerMap[aLayerName];
		var aColor = ASCompat.toNumber(args.mElements[2].mString);
		aLayer.mColorMult = Std.int(aColor / 255) << 24 | Std.int(aColor / 255) << 16 | Std.int(aColor / 255) << 8 | Std.int(aColor / 255);
	}

	function cmdLayerSetImageMap(args:ListDataElement) {
		var aCharCode = Math.NaN;
		var aRectDesc:ListDataElement = null;
		var aData:CharData = null;
		var aLayerName = ASCompat.toString(args.mElements[1].mString);
		var aLayer:FontLayer = this.mData.layerMap[aLayerName];
		var aCharList = this.lookup(args.mElements[2]);
		var aRectList = this.lookup(args.mElements[3]);
		var len = aCharList.mElements.length;
		for (i in 0...len) {
			aCharCode = ASCompat.toNumber(aCharList.mElements[i].mString.charCodeAt(0));
			aRectDesc = aRectList.mElements[i];
			aData = aLayer.getCharData(Std.int(aCharCode));
			aData.mImageRect = new Rectangle();
			aData.mImageRect.x = ASCompat.toNumber(aRectDesc.mElements[0]);
			aData.mImageRect.y = ASCompat.toNumber(aRectDesc.mElements[1]);
			aData.mImageRect.width = ASCompat.toNumber(aRectDesc.mElements[2]);
			aData.mImageRect.height = ASCompat.toNumber(aRectDesc.mElements[3]);
		}
	}

	function cmdLayerSetLineSpacingOffset(args:ListDataElement) {
		var aLayerName = ASCompat.toString(args.mElements[1].mString);
		var aLayer:FontLayer = this.mData.layerMap[aLayerName];
		var anOffset = ASCompat.toNumber(args.mElements[2].mString);
		aLayer.mLineSpacingOffset = anOffset;
	}

	function setLayerImage(layer:FontLayer, imgClazz:Class<Dynamic>) {
		var data:CharData = null;
		var w = Math.NaN;
		var h = Math.NaN;
		var bd:BitmapData = null;
		var src:Rectangle = null;
		var bitmap = ASCompat.dynamicAs(Type.createInstance(imgClazz, []), Bitmap);
		var destPt = new Point();
		var aStartIndex:Float = layer.mImageId.lastIndexOf("/") + 1;
		var imageName = layer.mImageId;
		var underIndex:Float = imageName.indexOf("_");
		var area = new Rectangle(0, 0, bitmap.bitmapData.width, bitmap.bitmapData.height);
		var aFontBD = new BitmapData(Std.int(area.width), Std.int(area.height), true, 4294967295);
		if (underIndex == 0 || underIndex == imageName.length - 1) {
			aFontBD.copyChannel(bitmap.bitmapData, area, destPt, BitmapDataChannel.RED, BitmapDataChannel.ALPHA);
		} else {
			aFontBD.copyPixels(bitmap.bitmapData, area, destPt);
		}
		var image = new ImageInst(new ImageData(aFontBD));
		var numChars = layer.mCharData.length;
		for (i in 0...numChars) {
			data = layer.getCharData(i);
			if (!(data.mImageRect == null || data.mImageRect.width == 0 || data.mImageRect.height == 0)) {
				w = data.mImageRect.width;
				h = data.mImageRect.height;
				bd = new BitmapData(Std.int(w), Std.int(h), true, 4294967295);
				src = data.mImageRect;
				bd.copyPixels(aFontBD, src, destPt);
				data.mImage = new ImageInst(new ImageData(bd));
			}
		}
		layer.mHeight = image.height;
	}

	function cmdDefine(args:ListDataElement) {
		var aKey = ASCompat.toString(args.mElements[1].mString);
		this.mDefines[aKey] = args.mElements[2];
	}

	function cmdSetDefaultPointSize(args:ListDataElement) {
		var aPointSize = ASCompat.toNumber(args.mElements[1].mString);
		this.mData.mPointSize = aPointSize;
	}

	function cmdCreateLayer(args:ListDataElement) {
		var aLayerName = ASCompat.toString(args.mElements[1].mString);
		var aLayer = new FontLayer();
		aLayer.mLayerName = aLayerName;
		this.mData.layerList.push(aLayer);
		this.mData.layerMap[aLayerName] = aLayer;
	}

	function cmdLayerSetCharOffsets(args:ListDataElement) {
		var aCharCode = Math.NaN;
		var aOffsetDesc:ListDataElement = null;
		var aData:CharData = null;
		var aLayerName = ASCompat.toString(args.mElements[1].mString);
		var aLayer:FontLayer = this.mData.layerMap[aLayerName];
		var aCharList = this.lookup(args.mElements[2]);
		var aOffsetList = this.lookup(args.mElements[3]);
		var len = aCharList.mElements.length;
		for (i in 0...len) {
			aCharCode = ASCompat.toNumber(aCharList.mElements[i].mString.charCodeAt(0));
			aOffsetDesc = aOffsetList.mElements[i];
			aData = aLayer.getCharData(Std.int(aCharCode));
			aData.mOffset.x = ASCompat.toNumber(aOffsetDesc.mElements[0]);
			aData.mOffset.y = ASCompat.toNumber(aOffsetDesc.mElements[1]);
		}
	}

	function cmdLayerSetAscent(args:ListDataElement) {
		var aLayerName = ASCompat.toString(args.mElements[1].mString);
		var aLayer:FontLayer = this.mData.layerMap[aLayerName];
		var anAscent = ASCompat.toNumber(args.mElements[2].mString);
		aLayer.mAscent = anAscent;
	}

	function cmdLayerSetAscentPadding(args:ListDataElement) {
		var aLayerName = ASCompat.toString(args.mElements[1].mString);
		var aLayer:FontLayer = this.mData.layerMap[aLayerName];
		var anAscent = ASCompat.toNumber(args.mElements[2].mString);
		aLayer.mAscentPadding = anAscent;
	}

	function cmdLayerSetImage(args:ListDataElement) {
		var aLayerName = ASCompat.toString(args.mElements[1].mString);
		var aFilename = ASCompat.toString(args.mElements[2].mString);
		var aLayer:FontLayer = this.mData.layerMap[aLayerName];
		aLayer.mImageId = aFilename;
	}

	function lookup(elem:DataElement):ListDataElement {
		var list:ListDataElement = null;
		if (Std.isOfType(elem, SingleDataElement)) {
			list = this.mDefines[cast(elem, SingleDataElement).mString];
		} else {
			if (!Std.isOfType(elem, ListDataElement)) {
				throw new Error("Unable to lookup list using element " + elem);
			}
			list = cast(elem, ListDataElement);
		}
		return list;
	}

	public function createFontData(app:AppBase):FontData {
		var command:ListDataElement = null;
		var cmdName:String = null;
		var cmdFunc:ASFunction = null;
		var imgClazz:Class<Dynamic> = null;
		var aLayer:FontLayer = null;
		this.mDefines = new ASDictionary<ASAny, ASAny>();
		this.mData = new FontData();
		var aByteArray:ByteArray = Type.createInstance(this.mFontClazz, []);
		var aFile = aByteArray.readUTFBytes(aByteArray.length);
		var parser = new DescriptionParser();
		var commands = parser.parse(aFile);
		var aNumCommands = commands.length;
		for (i in 0...aNumCommands) {
			command = commands[i];
			cmdName = ASCompat.toString(command.mElements[0].mString);
			cmdFunc = (this : ASAny)["cmd" + cmdName];
			if (cmdFunc == null) {
				throw new Error("No command mapped to \'" + cmdName + "\'");
			}
			cmdFunc(command);
		}
		var aNumLayers = this.mData.layerList.length;
		for (j in 0...aNumLayers) {
			imgClazz = this.mImageClazzes[j];
			aLayer = this.mData.layerList[j];
			this.setLayerImage(aLayer, imgClazz);
		}
		return this.mData;
	}

	function cmdLayerSetCharWidths(args:ListDataElement) {
		var aCharCode = Math.NaN;
		var aWidth = Math.NaN;
		var aData:CharData = null;
		var aLayerName = ASCompat.toString(args.mElements[1].mString);
		var aLayer:FontLayer = this.mData.layerMap[aLayerName];
		var aCharList = this.lookup(args.mElements[2]);
		var aWidthList = this.lookup(args.mElements[3]);
		var len = aCharList.mElements.length;
		for (i in 0...len) {
			aCharCode = ASCompat.toNumber(aCharList.mElements[i].mString.charCodeAt(0));
			aWidth = ASCompat.toNumber(aWidthList.mElements[i].mString);
			aData = aLayer.getCharData(Std.int(aCharCode));
			aData.mWidth = aWidth;
		}
	}

	function cmdLayerSetKerningPairs(args:ListDataElement) {
		var pair:SingleDataElement = null;
		var left:String = null;
		var right:String = null;
		var anOffset = Math.NaN;
		var aCharData:CharData = null;
		var aLayerName = ASCompat.toString(args.mElements[1].mString);
		var aLayer:FontLayer = this.mData.layerMap[aLayerName];
		var aPairsList = this.lookup(args.mElements[2]);
		var anOffsetList = this.lookup(args.mElements[3]);
		var aNumPairs = aPairsList.mElements.length;
		for (i in 0...aNumPairs) {
			pair = aPairsList.mElements[i];
			left = pair.mString.charAt(0);
			right = pair.mString.charAt(1);
			anOffset = ASCompat.toNumber(Std.string(anOffsetList.mElements[i]));
			aCharData = aLayer.getCharData(left.charCodeAt(0));
			aCharData.mKerningOffsets[right] = anOffset;
		}
	}
}
