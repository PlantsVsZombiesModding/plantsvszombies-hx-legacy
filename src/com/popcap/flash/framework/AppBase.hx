package com.popcap.flash.framework;

import com.XMLC;
import com.popcap.flash.framework.graphics.Graphics2D;
import com.popcap.flash.framework.resources.ResourceManager;
import com.popcap.flash.framework.resources.fonts.FontManager;
import com.popcap.flash.framework.resources.images.ImageManager;
import com.popcap.flash.framework.resources.music.MusicManager;
import com.popcap.flash.framework.resources.sound.SoundManager;
import com.popcap.flash.framework.resources.strings.StringManager;
import com.popcap.flash.framework.states.CStateManager;
import com.popcap.flash.framework.states.IStateManager;
import com.popcap.flash.framework.widgets.CWidgetManager;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.display.StageQuality;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;
import openfl.filters.GlowFilter;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.net.SharedObject;
import openfl.net.URLLoader;
import openfl.net.URLRequest;
import openfl.text.TextField;
import openfl.ui.Keyboard;
import openfl.ui.Mouse;
import openfl.utils.ByteArray;

class AppBase extends Sprite {
	static inline final SHIFT_FLAG = 4;

	public static var LOW_QUALITY:Bool = true;

	static inline final ALT_FLAG = 2;

	public static inline final UPDATE_STEP_TIME:Float = 10;

	static inline final CONTROL_FLAG = 1;

	var mCodeMap:ASDictionary<ASAny, ASAny>;

	var bufferData:BitmapData;

	var mPaused:Bool = false;

	var screenGraphics:Graphics2D;

	var mCheatBindings:ASDictionary<ASAny, ASAny>;

	var _appHeight:Float = 240;

	var avgFlashTime:Float = 0;

	var mUpdatesPaused:Bool = false;

	var screenData:BitmapData;

	var mStepsPerTick:Int = 1;

	var destPt:Point;

	var mSaveData:ASObject = null;

	var canvas:Sprite;

	var fpsTime:Float = Math.NaN;

	var lastUpdateTime:Float = Math.NaN;

	var screenRect:Rectangle;

	var mPlugins:Vector<BaseAppPlugin>;

	var _resourceManager:ResourceManager;

	var _appWidth:Float = 320;

	var excessUpdateTime:Float = Math.NaN;

	var screen:Bitmap;

	var _screenHeight:Float = 240;

	var _fontManager:FontManager;

	var fpsCount:Float = Math.NaN;

	var mVersion:String = "v0.0";

	var avgUpdateTime:Float = 0;

	var mSoundManager:SoundManager;

	var mDebugInfo:TextField;

	var mAppId:String = "";

	var mUpdateHooks:Array<ASAny>;

	var _stateManager:CStateManager;

	var mShowDebugInfo:Bool = false;

	var mSaveDataSO:SharedObject = null;

	var mServiceMap:ASDictionary<ASAny, ASAny>;

	var mDoStep:Bool = false;

	var _widgetManager:CWidgetManager;

	var mCheats:ASDictionary<ASAny, ASAny>;

	var initialized:Bool = false;

	var mMusicManager:MusicManager;

	var mReferences:ASDictionary<ASAny, ASAny>;

	var mImageManager:ImageManager;

	var mDataXML:XMLC = null;

	var avgTaskTime:Float = 0;

	var lastFlashTime:Float = Math.NaN;

	var mStringManager:StringManager;

	var avgRenderTime:Float = 0;

	var _screenWidth:Float = 320;

	var mMuted:Bool = false;

	public function new(param1:String) {
		super();
		this.mPlugins = new Vector<BaseAppPlugin>();
		this.mServiceMap = new ASDictionary<ASAny, ASAny>(false);
		this.mReferences = new ASDictionary<ASAny, ASAny>(true);
		this.mCheats = new ASDictionary<ASAny, ASAny>(true);
		this.mCheatBindings = new ASDictionary<ASAny, ASAny>();
		this.mUpdateHooks = new Array<ASAny>();
		// super();
		if (param1 == null || param1.length == 0) {
			throw new ArgumentError("You must specify an application id.");
		}
		this.mAppId = param1;
		this.registerCheat("toggleDebug", this.toggleDebug);
		this.registerCheat("globalPause", this.globalPause);
		this.registerCheat("stepUpdates", this.stepUpdates);
		this.registerCheat("resumeUpdates", this.resumeUpdates);
		this.registerCheat("slowerUpdates", this.slowerUpdates);
		this.registerCheat("fasterUpdates", this.fasterUpdates);
	}

	public static function log(param1:String, param2:String = "Loading") {
		var _loc3_ = new Error("This method should only be called within a CONFIG::DEBUG block!");
		trace(_loc3_.getStackTrace());
		throw _loc3_;
	}

	function handleStringsLoaded(param1:Event) {
		var _loc2_ = new URLLoader();
		var _loc3_ = new URLRequest("data.xml");
		_loc2_.addEventListener(Event.COMPLETE, this.handleDataLoaded);
		_loc2_.load(_loc3_);
	}

	function handleMouseUp(param1:MouseEvent) {
		this._widgetManager.doMouseUp(param1.stageX, param1.stageY);
	}

	function handleMouseMove(param1:MouseEvent) {
		this._widgetManager.doMouseMove(param1.stageX, param1.stageY);
	}

	public function togglePause(param1:Bool) {
		if (param1 == true) {
			this.mPaused = true;
			this.musicManager.pauseMusic();
			this.soundManager.pauseAll();
		} else {
			this.mPaused = false;
			this.musicManager.resumeMusic();
			this.soundManager.resumeAll();
		}
	}

	function advanceFrame() {}

	public function addUpdateHook(param1:ASFunction) {
		this.mUpdateHooks.push(param1);
	}

	public function init() {
		if (this.initialized) {
			return;
		}
		this.mCodeMap = new ASDictionary<ASAny, ASAny>();
		this.mCodeMap["UP"] = Keyboard.UP;
		this.mCodeMap["DOWN"] = Keyboard.DOWN;
		this.mCodeMap["LEFT"] = Keyboard.LEFT;
		this.mCodeMap["RIGHT"] = Keyboard.RIGHT;
		this.mCodeMap["SHIFT"] = Keyboard.SHIFT;
		this.mCodeMap["CONTROL"] = Keyboard.CONTROL;
		this.mCodeMap["TAB"] = Keyboard.TAB;
		this.mCodeMap["CAPS_LOCK"] = Keyboard.CAPS_LOCK;
		this.mCodeMap["ENTER"] = Keyboard.ENTER;
		this.mCodeMap["ESCAPE"] = Keyboard.ESCAPE;
		this.mCodeMap["END"] = Keyboard.END;
		this.mCodeMap["HOME"] = Keyboard.HOME;
		this.mCodeMap["INSERT"] = Keyboard.INSERT;
		this.mCodeMap["PAGE_UP"] = Keyboard.PAGE_UP;
		this.mCodeMap["PAGE_DOWN"] = Keyboard.PAGE_DOWN;
		this.mCodeMap["DELETE"] = Keyboard.DELETE;
		this.mCodeMap["F1"] = Keyboard.F1;
		this.mCodeMap["F2"] = Keyboard.F2;
		this.mCodeMap["F3"] = Keyboard.F3;
		this.mCodeMap["F4"] = Keyboard.F4;
		this.mCodeMap["F5"] = Keyboard.F5;
		this.mCodeMap["F6"] = Keyboard.F6;
		this.mCodeMap["F7"] = Keyboard.F7;
		this.mCodeMap["F8"] = Keyboard.F8;
		this.mCodeMap["F9"] = Keyboard.F9;
		this.mCodeMap["F11"] = Keyboard.F11;
		this.mCodeMap["F12"] = Keyboard.F12;
		this.mCodeMap["F13"] = Keyboard.F13;
		this.mCodeMap["F14"] = Keyboard.F14;
		this.mCodeMap["F15"] = Keyboard.F15;
		this.mCodeMap["NUMPAD_0"] = Keyboard.NUMPAD_0;
		this.mCodeMap["NUMPAD_1"] = Keyboard.NUMPAD_1;
		this.mCodeMap["NUMPAD_2"] = Keyboard.NUMPAD_2;
		this.mCodeMap["NUMPAD_3"] = Keyboard.NUMPAD_3;
		this.mCodeMap["NUMPAD_4"] = Keyboard.NUMPAD_4;
		this.mCodeMap["NUMPAD_5"] = Keyboard.NUMPAD_5;
		this.mCodeMap["NUMPAD_6"] = Keyboard.NUMPAD_6;
		this.mCodeMap["NUMPAD_7"] = Keyboard.NUMPAD_7;
		this.mCodeMap["NUMPAD_8"] = Keyboard.NUMPAD_8;
		this.mCodeMap["NUMPAD_9"] = Keyboard.NUMPAD_9;
		this.mCodeMap["NUMPAD_MULTIPLY"] = Keyboard.NUMPAD_MULTIPLY;
		this.mCodeMap["NUMPAD_ADD"] = Keyboard.NUMPAD_ADD;
		this.mCodeMap["NUMPAD_ENTER"] = Keyboard.NUMPAD_ENTER;
		this.mCodeMap["NUMPAD_SUBTRACT"] = Keyboard.NUMPAD_SUBTRACT;
		this.mCodeMap["NUMPAD_DECIMAL"] = Keyboard.NUMPAD_DECIMAL;
		this.mCodeMap["NUMPAD_DIVIDE"] = Keyboard.NUMPAD_DIVIDE;
		this.mCodeMap["0"] = 48;
		this.mCodeMap["1"] = 49;
		this.mCodeMap["2"] = 50;
		this.mCodeMap["3"] = 51;
		this.mCodeMap["4"] = 52;
		this.mCodeMap["5"] = 53;
		this.mCodeMap["6"] = 54;
		this.mCodeMap["7"] = 55;
		this.mCodeMap["8"] = 56;
		this.mCodeMap["9"] = 57;
		this.mCodeMap["A"] = 65;
		this.mCodeMap["B"] = 66;
		this.mCodeMap["C"] = 67;
		this.mCodeMap["D"] = 68;
		this.mCodeMap["E"] = 69;
		this.mCodeMap["F"] = 70;
		this.mCodeMap["G"] = 71;
		this.mCodeMap["H"] = 72;
		this.mCodeMap["I"] = 73;
		this.mCodeMap["J"] = 74;
		this.mCodeMap["K"] = 75;
		this.mCodeMap["L"] = 76;
		this.mCodeMap["M"] = 77;
		this.mCodeMap["N"] = 78;
		this.mCodeMap["O"] = 79;
		this.mCodeMap["P"] = 80;
		this.mCodeMap["Q"] = 81;
		this.mCodeMap["R"] = 82;
		this.mCodeMap["S"] = 83;
		this.mCodeMap["T"] = 84;
		this.mCodeMap["U"] = 85;
		this.mCodeMap["V"] = 86;
		this.mCodeMap["W"] = 87;
		this.mCodeMap["X"] = 88;
		this.mCodeMap["Y"] = 89;
		this.mCodeMap["Z"] = 90;
		this.mCodeMap[";"] = 186;
		this.mCodeMap[":"] = 186;
		this.mCodeMap["="] = 187;
		this.mCodeMap["+"] = 187;
		this.mCodeMap["-"] = 189;
		this.mCodeMap["_"] = 189;
		this.mCodeMap["/"] = 191;
		this.mCodeMap["?"] = 191;
		this.mCodeMap["`"] = 192;
		this.mCodeMap["~"] = 192;
		this.mCodeMap["["] = 219;
		this.mCodeMap["{"] = 219;
		this.mCodeMap["\\"] = 220;
		this.mCodeMap["|"] = 220;
		this.mCodeMap["]"] = 221;
		this.mCodeMap["}"] = 221;
		this.mCodeMap["\'"] = 222;
		this.mCodeMap[","] = 188;
		this.mCodeMap["<"] = 188;
		this.mCodeMap["."] = 190;
		this.mCodeMap[">"] = 190;
		stage.frameRate = 1000;
		stage.quality = StageQuality.BEST;
		stage.addEventListener(MouseEvent.MOUSE_DOWN, this.handleMouseDown);
		stage.addEventListener(MouseEvent.MOUSE_UP, this.handleMouseUp);
		stage.addEventListener(MouseEvent.MOUSE_MOVE, this.handleMouseMove);
		stage.addEventListener(MouseEvent.MOUSE_WHEEL, this.handleMouseWheel);
		stage.addEventListener(MouseEvent.MOUSE_OUT, this.handleMouseOut);
		stage.addEventListener(MouseEvent.MOUSE_OVER, this.handleMouseOver);
		stage.addEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);
		stage.addEventListener(KeyboardEvent.KEY_DOWN, this.handleKeyDown);
		this.screenRect = new Rectangle(0, 0, this._screenWidth, this._screenHeight);
		this.destPt = new Point(0, 0);
		this.bufferData = new BitmapData(Std.int(this._screenWidth), Std.int(this._screenHeight), false);
		this.screenData = new BitmapData(Std.int(this._screenWidth), Std.int(this._screenHeight), false);
		this.screen = new Bitmap(this.screenData);
		this.screenGraphics = new Graphics2D(this.bufferData);
		this._widgetManager = new CWidgetManager(this);
		this._resourceManager = new ResourceManager(this);
		this._stateManager = new CStateManager();
		this.mMusicManager = new MusicManager(this);
		this.mImageManager = new ImageManager(this);
		this.mSoundManager = new SoundManager(this);
		this._fontManager = new FontManager(this);
		this.mStringManager = new StringManager(this);
		this.canvas = new Sprite();
		this.canvas.useHandCursor = false;
		this.canvas.buttonMode = true;
		this.canvas.tabEnabled = false;
		this.canvas.addChild(this.screen);
		this.canvas.width = this._appWidth;
		this.canvas.height = this._appHeight;
		addChild(this.canvas);
		this.mDebugInfo = new TextField();
		this.mDebugInfo.textColor = 16777215;
		this.mDebugInfo.filters = [new GlowFilter(0, 1, 4, 4, 10)];
		this.mDebugInfo.selectable = false;
		this.mDebugInfo.width = 540;
		this.mDebugInfo.height = 20;
		this.mDebugInfo.y = 385;
		this.fpsCount = 0;
		this.initialized = true;
		this.load();
	}

	function handleKeyUp(param1:KeyboardEvent) {
		this._widgetManager.doKeyUp(param1.keyCode);
	}

	function globalPause() {
		this.togglePause(!this.mPaused);
	}

	function handleMouseWheel(param1:MouseEvent) {
		this._widgetManager.doMouseWheel(param1.delta);
	}

	@:flash.property @:isVar public var appWidth(get, set):Float;

	public function get_appWidth():Float {
		return this._appWidth;
	}

	function handleFrame(param1:Event) {
		var _loc2_:BaseAppPlugin = null;
		var _loc3_ = Math.NaN;
		var _loc4_ = Math.NaN;
		stage.quality = StageQuality.BEST;
		for (_tmp_ in this.mPlugins) {
			_loc2_ = _tmp_;
			if (!_loc2_.isLoaded()) {
				return;
			}
		}
		_loc3_ = flash.Lib.getTimer();
		_loc4_ = _loc3_ - this.lastUpdateTime;
		this.lastUpdateTime = flash.Lib.getTimer();
		this.avgFlashTime += _loc3_ - this.lastFlashTime;
		this.excessUpdateTime += _loc4_;
		if (this.mShowDebugInfo) {
			this.fpsTime += _loc4_;
			while (this.fpsTime >= 1000) {
				this.fpsTime -= 1000;
				if (this.fpsCount > 0) {
					this.avgUpdateTime = Math.fround(this.avgUpdateTime / this.fpsCount);
					this.avgRenderTime = Math.fround(this.avgRenderTime / this.fpsCount);
					this.avgTaskTime = Math.fround(this.avgTaskTime / this.fpsCount);
					this.avgFlashTime = Math.fround(this.avgFlashTime / this.fpsCount);
				}
				this.mDebugInfo.text = this.mVersion + " ";
				this.mDebugInfo.appendText("[FPS: " + this.fpsCount);
				this.mDebugInfo.appendText("] [Avg. Update Time: " + this.avgUpdateTime);
				this.mDebugInfo.appendText("] [Avg. Render Time: " + this.avgRenderTime);
				this.mDebugInfo.appendText("] [Avg. Task Time: " + this.avgTaskTime);
				this.mDebugInfo.appendText("] [Avg. Flash Time: " + this.avgFlashTime + "]");
				if (this.fpsCount > 0) {
					this.avgUpdateTime = 0;
					this.avgRenderTime = 0;
					this.avgTaskTime = 0;
					this.avgFlashTime = 0;
				}
				this.fpsCount = 0;
			}
		}
		var _loc5_:Float = flash.Lib.getTimer();
		while (this.excessUpdateTime >= UPDATE_STEP_TIME) {
			this.updateStep();
			this.excessUpdateTime -= UPDATE_STEP_TIME;
		}
		this.avgUpdateTime += flash.Lib.getTimer() - _loc5_;
		_loc5_ = flash.Lib.getTimer();
		this.renderStep();
		this.avgRenderTime += flash.Lib.getTimer() - _loc5_;
		++this.fpsCount;
		this.lastFlashTime = flash.Lib.getTimer();
		if (this.canvas.useHandCursor != this.widgetManager.mShowFinger) {
			this.canvas.useHandCursor = this.widgetManager.mShowFinger;
			Mouse.hide();

			Mouse.show();
		}
	}

	public function removeUpdateHook(param1:ASFunction) {
		var _loc2_ = this.mUpdateHooks.indexOf(param1);
		if (_loc2_ >= 0) {
			this.mUpdateHooks.splice(_loc2_, 1);
		}
	}

	function updateStep() {
		var _loc2_ = 0;
		var _loc3_:ASFunction = null;
		if (this.mUpdatesPaused && !this.mDoStep) {
			return;
		}
		this.mDoStep = false;
		var _loc1_ = 0;
		while (_loc1_ < this.mStepsPerTick) {
			_loc2_ = 0;
			while (_loc2_ < this.mUpdateHooks.length) {
				_loc3_ = this.mUpdateHooks[_loc2_];
				_loc3_();
				_loc2_++;
			}
			this.musicManager.update();
			this._stateManager.update();

			_loc1_++;
		}
	}

	public function getProperties():XMLC {
		return this.mDataXML;
	}

	function getSO():SharedObject {
		if (this.mSaveDataSO == null) {
			this.mSaveDataSO = SharedObject.getLocal(this.mAppId);
		}
		return this.mSaveDataSO;
	}

	public function getSaveData():ASObject {
		var _loc1_:SharedObject = null;
		var _loc2_:ByteArray = null;
		if (this.mSaveData != null) {
			return this.mSaveData;
		}
		if (!this.canLoadData()) {
			this.mSaveData = new ASObject();
		} else {
			_loc1_ = this.getSO();
			_loc2_ = new ByteArray();
			_loc2_.writeObject(_loc1_.data.saveData);
			_loc2_.position = 0;
			this.mSaveData = _loc2_.readObject();
			if (this.mSaveData == null) {
				this.mSaveData = new ASObject();
			}
		}
		return this.mSaveData;
	}

	public function setSaveData(param1:ASObject) {
		this.mSaveData = param1;
		if (!this.canSaveData()) {
			return;
		}
		var _loc2_ = this.getSO();
		var _loc3_ = new ByteArray();
		_loc3_.writeObject(this.mSaveData);
		_loc3_.position = 0;
		_loc2_.data.saveData = _loc3_.readObject();
		_loc2_.setProperty("saveData", param1);
		_loc2_.flush();
	}

	function set_appWidth(param1:Float):Float {
		if (this.initialized) {
			return param1;
		}
		if (param1 <= 0) {
			throw new ArgumentError("Application width must be >= 1");
		}

		return this._appWidth = param1;
	}

	@:flash.property @:isVar public var appHeight(get, set):Float;

	public function set_appHeight(param1:Float):Float {
		if (this.initialized) {
			return param1;
		}
		if (param1 <= 0) {
			throw new ArgumentError("Application height must be >= 1");
		}
		return this._appHeight = param1;
	}

	function handleKeyDown(param1:KeyboardEvent) {
		var _loc3_:ASAny = 0;
		var _loc4_:String = null;
		var _loc5_:ASFunction = null;
		var _loc2_ = AppUtils.asBoolean(this.getProperties().cheats.enabled);
		if (_loc2_) {
			_loc3_ = param1.keyCode << 3;
			if (param1.ctrlKey) {
				_loc3_ |= CONTROL_FLAG;
			}
			if (param1.altKey) {
				_loc3_ |= ALT_FLAG;
			}
			if (param1.shiftKey) {
				_loc3_ |= SHIFT_FLAG;
			}
			if ((_loc4_ = ASCompat.toString(this.mCheatBindings[_loc3_])) != null) {
				if ((_loc5_ = this.mCheats[_loc4_]) != null) {
					_loc5_();
				}
			}
		}
		this._widgetManager.doKeyDown(param1.keyCode);
		this._widgetManager.doKeyChar(param1.charCode);
	}

	@:flash.property @:isVar public var stringManager(get, never):StringManager;

	public function get_stringManager():StringManager {
		return this.mStringManager;
	}

	function toggleDebug() {
		this.mShowDebugInfo = !this.mShowDebugInfo;
		if (this.mShowDebugInfo) {
			this.mDebugInfo.text = "Calculating...";
			addChild(this.mDebugInfo);
		} else {
			removeChild(this.mDebugInfo);
		}
	}

	@:flash.property @:isVar public var isMuted(get, never):Bool;

	public function get_isMuted():Bool {
		return this.mMuted;
	}

	public function start() {
		this.mVersion = "v" + this.mDataXML.version.major + "." + this.mDataXML.version.minor;
		var _loc1_ = 0; // int(this.mDataXML.cheats.bind.length());
		var _loc2_ = 0;
		while (_loc2_ < _loc1_) {
			this.addBinding(this.mDataXML.cheats.bind[_loc2_]);
			_loc2_++;
		}

		this.fpsTime = 0;

		this.excessUpdateTime = 0;
		this.lastUpdateTime = flash.Lib.getTimer();
		this.lastFlashTime = this.lastUpdateTime;
		addEventListener(Event.ENTER_FRAME, this.handleFrame);
	}

	@:flash.property @:isVar public var screenHeight(get, set):Float;

	public function set_screenHeight(param1:Float):Float {
		if (this.initialized) {
			return param1;
		}
		if (param1 <= 0) {
			throw new ArgumentError("Screen height must be >= 1");
		}
		return this._screenHeight = param1;
	}

	public function getServiceReferences(param1:String):Vector<IAppServiceReference> {
		var _loc4_:BaseAppServiceRegistration = null;
		var _loc5_:IAppServiceReference = null;
		var _loc2_ = new Vector<IAppServiceReference>();
		var _loc3_:Array<ASAny> = this.mServiceMap[param1];
		if (_loc3_ == null) {
			return _loc2_;
		}
		for (_tmp_ in _loc3_) {
			_loc4_ = _tmp_;
			_loc5_ = _loc4_.getReference();
			this.mReferences[_loc5_] = _loc4_.getService();
			_loc2_.push(_loc5_);
		}
		return _loc2_;
	}

	public function getPlugins():Vector<IAppPlugin> {
		return this.mPlugins.slice();
	}

	@:flash.property @:isVar public var fontManager(get, never):FontManager;

	public function get_fontManager():FontManager {
		return this._fontManager;
	}

	function slowerUpdates() {
		this.mStepsPerTick = Std.int(Math.max(1, this.mStepsPerTick - 1));
	}

	public function getService(param1:IAppServiceReference):ASObject {
		return this.mReferences[param1];
	}

	function fasterUpdates() {
		this.mStepsPerTick = Std.int(Math.min(30, this.mStepsPerTick + 1));
	}

	function renderStep() {
		this.screenGraphics.reset();
		this._stateManager.draw(this.screenGraphics);
		this.screenData.lock();
		this.screenData.copyPixels(this.bufferData, this.screenRect, this.destPt);
		this.screenData.unlock();
	}

	@:flash.property @:isVar public var screenWidth(get, set):Float;

	public function set_screenWidth(param1:Float):Float {
		if (this.initialized) {
			return param1;
		}
		if (param1 <= 0) {
			throw new ArgumentError("Screen width must be >= 1");
		}
		return this._screenWidth = param1;
	}

	public function toggleMute(param1:Bool) {
		if (param1 == true) {
			this.mMuted = true;

			this.musicManager.mute();
			this.soundManager.mute();
		} else {
			this.mMuted = false;
			this.musicManager.unmute();
			this.soundManager.unmute();
		}
	}

	public function shutdown() {
		removeChild(this.canvas);
		this.canvas.removeChild(this.screen);
		this.canvas = null;
		this.screen = null;
		this.screenData.dispose();
		this.screenData = null;
		this._resourceManager = null;
		this._widgetManager = null;
		this.initialized = false;
	}

	function handleDataLoaded(param1:Event) {
		var _loc6_:XMLC = null;
		var _loc7_:BaseAppPlugin = null;
		var _loc2_ = ASCompat.dynamicAs(param1.target, URLLoader);
		_loc2_.removeEventListener(Event.COMPLETE, this.handleDataLoaded);
		var _loc3_ = new XMLC(param1.target.data);
		this.mDataXML = _loc3_;
		var _loc4_ = 0; // int(_loc3_.Plugins.Plugin.length());
		var _loc5_ = 0;

		while (_loc5_ < _loc4_) {
			// _loc6_ = _loc3_.Plugins.Plugin[_loc5_];
			_loc7_ = new BaseAppPlugin(this, _loc6_);
			this.mPlugins.push(_loc7_);
			_loc7_.load();
			_loc5_++;
		}
		this.start();
	}

	public function registerService(param1:BaseAppPlugin, param2:Vector<String>, param3:ASObject, param4:XMLC):IAppServiceRegistration {
		var _loc6_:String = null;
		var _loc7_:Vector<BaseAppServiceRegistration> = null;
		var _loc5_ = new BaseAppServiceRegistration(this, param1, param2, param3, param4);
		for (_tmp_ in param2) {
			_loc6_ = _tmp_;

			if ((_loc7_ = this.mServiceMap[_loc6_]) == null) {
				_loc7_ = new Vector<BaseAppServiceRegistration>();
			}
			if (_loc7_.indexOf(param3) < 0) {
				_loc7_.push(_loc5_);
			}
		}
		return _loc5_;
	}

	@:flash.property @:isVar public var soundManager(get, never):SoundManager;

	public function get_soundManager():SoundManager {
		return this.mSoundManager;
	}

	public function canLoadData():Bool {
		return true; // AppUtils.asBoolean(this.mDataXML.saveData.canLoad,true);
	}

	function addBinding(param1:XMLC) {
		/*
			var _loc6_:String = null;
			var _loc7_:String = null;
			var _loc2_:String = param1.@keyCombo;
			var _loc3_:int = int(this.mCodeMap[_loc2_]);
			if(_loc3_ > 0)
			{
						this.mCheatBindings[_loc3_ << 3] = param1.toString();
						return;
			}
			var _loc4_:Array = _loc2_.split("+");
			var _loc5_:* = 0;
			for each(_loc6_ in _loc4_)
			{
						if((_loc7_ = String(_loc6_.toUpperCase())) == "CONTROL")
						{
						   _loc5_ |= CONTROL_FLAG;
						}
						else if(_loc7_ == "ALT")
						{
						   _loc5_ |= ALT_FLAG;
						}
						else if(_loc7_ == "SHIFT")
						{
						   _loc5_ |= SHIFT_FLAG;
						}
						else
						{
						   _loc3_ = int(this.mCodeMap[_loc7_]);
						   if(_loc3_ == 0)
						   {
							  return;
						   }
						}
			}
			this.mCheatBindings[_loc3_ << 3 | _loc5_] = param1.toString();
		 */
	}

	function get_appHeight():Float {
		return this._appHeight;
	}

	function handleMouseDown(param1:MouseEvent) {
		this._widgetManager.doMouseDown(param1.stageX, param1.stageY);
	}

	function get_screenHeight():Float {
		return this._screenHeight;
	}

	function handleMouseOut(param1:MouseEvent) {}

	function get_screenWidth():Float {
		return this._screenWidth;
	}

	@:flash.property @:isVar public var resourceManager(get, never):ResourceManager;

	public function get_resourceManager():ResourceManager {
		return this._resourceManager;
	}

	@:flash.property @:isVar public var widgetManager(get, never):CWidgetManager;

	public function get_widgetManager():CWidgetManager {
		return this._widgetManager;
	}

	@:flash.property @:isVar public var musicManager(get, never):MusicManager;

	public function get_musicManager():MusicManager {
		return this.mMusicManager;
	}

	function stepUpdates() {
		if (this.mUpdatesPaused == true) {
			this.mDoStep = true;
		}
		this.mUpdatesPaused = true;
	}

	@:flash.property @:isVar public var imageManager(get, never):ImageManager;

	public function get_imageManager():ImageManager {
		return this.mImageManager;
	}

	public function canSaveData():Bool {
		return true; // AppUtils.asBoolean(this.mDataXML.saveData.canSave,true);
	}

	function resumeUpdates() {
		this.mUpdatesPaused = false;
	}

	@:flash.property @:isVar public var stateManager(get, never):IStateManager;

	public function get_stateManager():IStateManager {
		return this._stateManager;
	}

	function handleMouseOver(param1:MouseEvent) {
		this._widgetManager.onMouseEnter();
	}

	function load() {
		this.stringManager.addEventListener(Event.COMPLETE, this.handleStringsLoaded);
		this.stringManager.loadStrings("properties/externalStrings.txt");
	}

	public function registerCheat(param1:String, param2:ASFunction) {
		this.mCheats[param1] = param2;
	}

	@:flash.property @:isVar public var isPaused(get, never):Bool;

	public function get_isPaused():Bool {
		return this.mPaused;
	}

	public function ungetService(param1:IAppServiceReference) {
		throw new Error("Unimplemented stub method.");
	}
}
