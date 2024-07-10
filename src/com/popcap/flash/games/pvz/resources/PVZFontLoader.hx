package com.popcap.flash.games.pvz.resources;

import com.popcap.flash.framework.resources.fonts.ByteFontDescriptor;
import flash.utils.ByteArray;

class PVZFontLoader {
	public static final FONT_HOUSEOFTERROR16_CLASS:Class<Dynamic> = PVZFontLoader_FONT_HOUSEOFTERROR16_CLASS;

	public static final FONT_DWARVENTODCRAFT18_CLASS:Class<Dynamic> = PVZFontLoader_FONT_DWARVENTODCRAFT18_CLASS;

	public static final FONT_DWARVENTODCRAFT15_CLASS:Class<Dynamic> = PVZFontLoader_FONT_DWARVENTODCRAFT15_CLASS;

	public static final FONT_PIX118BOLD_CLASS:Class<Dynamic> = PVZFontLoader_FONT_PIX118BOLD_CLASS;

	public static final FONT_CONTINUUMBOLD14_CLASS:Class<Dynamic> = PVZFontLoader_FONT_CONTINUUMBOLD14_CLASS;

	public static final FONT_BRIANNETOD16_CLASS:Class<Dynamic> = PVZFontLoader_FONT_BRIANNETOD16_CLASS;

	public static final FONT_PICO129_CLASS:Class<Dynamic> = PVZFontLoader_FONT_PICO129_CLASS;

	public static final FONT_HOUSEOFTERROR28_CLASS:Class<Dynamic> = PVZFontLoader_FONT_HOUSEOFTERROR28_CLASS;

	public static final FONT_DWARVENTODCRAFT24_CLASS:Class<Dynamic> = PVZFontLoader_FONT_DWARVENTODCRAFT24_CLASS;

	public static final FONT_DWARVENTODCRAFT18YELLOW_CLASS:Class<Dynamic> = PVZFontLoader_FONT_DWARVENTODCRAFT18YELLOW_CLASS;

	public static final FONT_DWARVENTODCRAFT36BRIGHTGREENINSET_CLASS:Class<Dynamic> = PVZFontLoader_FONT_DWARVENTODCRAFT36BRIGHTGREENINSET_CLASS;

	public static final FONT_DWARVENTODCRAFT36GREENINSET_CLASS:Class<Dynamic> = PVZFontLoader_FONT_DWARVENTODCRAFT36GREENINSET_CLASS;

	public function new() {
		// super();
	}

	public static function init(param1:ASDictionary<ASAny, ASAny>) {
		param1[PVZFonts.FONT_BRIANNETOD16] = new ByteFontDescriptor((Type.createInstance(FONT_BRIANNETOD16_CLASS, []) : ByteArray), []);
		param1[PVZFonts.FONT_CONTINUUMBOLD14] = new ByteFontDescriptor((Type.createInstance(FONT_CONTINUUMBOLD14_CLASS, []) : ByteArray), []);
		param1[PVZFonts.FONT_DWARVENTODCRAFT15] = new ByteFontDescriptor((Type.createInstance(FONT_DWARVENTODCRAFT15_CLASS, []) : ByteArray), []);
		param1[PVZFonts.FONT_DWARVENTODCRAFT18] = new ByteFontDescriptor((Type.createInstance(FONT_DWARVENTODCRAFT18_CLASS, []) : ByteArray), []);
		param1[PVZFonts.FONT_DWARVENTODCRAFT18YELLOW] = new ByteFontDescriptor((Type.createInstance(FONT_DWARVENTODCRAFT18YELLOW_CLASS, []) : ByteArray), []);
		param1[PVZFonts.FONT_DWARVENTODCRAFT24] = new ByteFontDescriptor((Type.createInstance(FONT_DWARVENTODCRAFT24_CLASS, []) : ByteArray), []);
		param1[PVZFonts.FONT_DWARVENTODCRAFT36BRIGHTGREENINSET] = new ByteFontDescriptor((Type.createInstance(FONT_DWARVENTODCRAFT36BRIGHTGREENINSET_CLASS,
			[]) : ByteArray), []);
		param1[PVZFonts.FONT_DWARVENTODCRAFT36GREENINSET] = new ByteFontDescriptor((Type.createInstance(FONT_DWARVENTODCRAFT36GREENINSET_CLASS,
			[]) : ByteArray), []);
		param1[PVZFonts.FONT_HOUSEOFTERROR16] = new ByteFontDescriptor((Type.createInstance(FONT_HOUSEOFTERROR16_CLASS, []) : ByteArray), []);
		param1[PVZFonts.FONT_HOUSEOFTERROR28] = new ByteFontDescriptor((Type.createInstance(FONT_HOUSEOFTERROR28_CLASS, []) : ByteArray), []);
		param1[PVZFonts.FONT_PICO129] = new ByteFontDescriptor((Type.createInstance(FONT_PICO129_CLASS, []) : ByteArray), []);
		param1[PVZFonts.FONT_PIX118BOLD] = new ByteFontDescriptor((Type.createInstance(FONT_PIX118BOLD_CLASS, []) : ByteArray), []);
	}
}
