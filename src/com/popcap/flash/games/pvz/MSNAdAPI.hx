package com.popcap.flash.games.pvz;

import com.popcap.flash.framework.AppBase;
import com.popcap.flash.framework.AppUtils;
import openfl.external.ExternalInterface;
import com.XMLC;

class MSNAdAPI {
	public static inline final DEFAULT_LOAD_BROADCAST_RATE:Float = 3000;

	static inline final MILLIS_PER_UPDATE:Float = 10;

	public static inline final DEFAULT_SCORE_BROADCAST_RATE:Float = 3000;

	public static inline final MIN_BROADCAST_RATE:Float = 1000;

	var mPlaying:Bool = false;

	var mNumBreaks:Float = 0;

	var mLoadBroadcastRate:Float = 3000;

	var mLoading:Bool = true;

	var mEnabled:Bool = false;

	var mScoreBroadcastRate:Float = 3000;

	var mSessionReadyCallback:ASFunction;

	var mScore:Float = 0;

	public var handleMenu:ASFunction = null;

	var mGameBreakCallback:ASFunction;

	var mGameReadyCallback:ASFunction;

	var mLoadPercent:Float = 0;

	var mAppTime:Float = 0;

	var mGameTime:Float = 0;

	var mCustomEventCallback:ASFunction;

	var mApp:AppBase;

	public function new(app:AppBase) {
		// super();
		this.mApp = app;
		this.mApp.addUpdateHook(this.update);
	}

	function onCustomReturn(sXML:String = null) {
		this.mCustomEventCallback();
		this.mCustomEventCallback = null;
	}

	function onGamePause(str:String) {
		var isPaused = this.onOffAsBoolean(str);
		this.togglePause(isPaused);
	}

	public function CustomEvent(data:XMLC, callback:ASFunction) {
		if (!this.mEnabled || !ExternalInterface.available) {
			callback();
			return;
		}
		this.mCustomEventCallback = callback;
		var xml = "<data>DeluxeDownload</data>";
		ExternalInterface.call("CustomEvent", xml);
	}

	public function init() {
		var result = false;
		this.mEnabled = AppUtils.asBoolean(this.mApp.getProperties().MSN.enabled) && ExternalInterface.available;
		// this.mLoadBroadcastRate = AppUtils.asNumber(this.mApp.getProperties().MSN.loadBroadcastRate,DEFAULT_LOAD_BROADCAST_RATE);
		this.mLoadBroadcastRate = Math.max(this.mLoadBroadcastRate, MIN_BROADCAST_RATE);
		// this.mScoreBroadcastRate = AppUtils.asNumber(this.mApp.getProperties().MSN.scoreBroadcastRate,DEFAULT_SCORE_BROADCAST_RATE);
		this.mScoreBroadcastRate = Math.max(this.mScoreBroadcastRate, MIN_BROADCAST_RATE);
		if (!this.mEnabled) {
			return;
		}
		if (ExternalInterface.available) {
			ExternalInterface.addCallback("onGameMenu", this.onGameMenu);
			ExternalInterface.addCallback("onGameMute", this.onGameMute);
			ExternalInterface.addCallback("onMuteOn", this.onMuteOn);
			ExternalInterface.addCallback("onMuteOff", this.onMuteOff);
			ExternalInterface.addCallback("onGamePause", this.onGamePause);
			ExternalInterface.addCallback("onPauseOn", this.onPauseOn);
			ExternalInterface.addCallback("onPauseOff", this.onPauseOff);
			ExternalInterface.addCallback("onGameContinue", this.onGameContinue);
			ExternalInterface.addCallback("onGameStart", this.onGameStart);
			ExternalInterface.addCallback("onSessionStart", this.onSessionStart);
			ExternalInterface.addCallback("onCustomReturn", this.onCustomReturn);
			result = ExternalInterface.call("isProxyReady");
			if (result == true) {
				ExternalInterface.call("setSWFIsReady");
			} else {
				this.mEnabled = false;
			}
		}
	}

	function togglePause(isPaused:Bool) {
		if (isPaused) {
			this.mPlaying = false;
		} else {
			this.mPlaying = true;
		}
		this.mApp.togglePause(isPaused);
	}

	function toggleMute(isMuted:Bool) {
		this.mApp.toggleMute(isMuted, true);
	}

	public function GameError(str:String) {
		if (!this.mEnabled || !ExternalInterface.available) {
			return;
		}
		ExternalInterface.call("GameError", str);
	}

	function onMuteOn() {
		this.toggleMute(true);
	}

	function onPauseOff() {
		this.togglePause(false);
	}

	function onPauseOn() {
		this.togglePause(true);
	}

	public function resumeBroadcast() {
		this.mPlaying = true;
	}

	public function ScoreSubmit() {
		if (!this.mEnabled || !ExternalInterface.available) {
			return;
		}
		var xml:ASAny = "<game><score>" + this.mScore + "</score><time>" + Std.int(this.mGameTime / 1000) + "</time></game>";
		ExternalInterface.call("ScoreSubmit", xml);
	}

	public function GameBreak(levelCompleted:Float, callback:ASFunction) {
		this.mPlaying = false;
		this.mNumBreaks += 1;
		if (!this.mEnabled || !ExternalInterface.available) {
			this.mPlaying = true;
			callback();
			return;
		}
		this.mGameBreakCallback = callback;
		var xml:ASAny = "<data><breakpoint>" + this.mNumBreaks + "</breakpoint></data>";
		ExternalInterface.call("GameBreak", xml);
	}

	public function GameReady(mode:Float, level:Float, callback:ASFunction) {
		this.mGameTime = 0;
		if (!this.mEnabled || !ExternalInterface.available) {
			this.mGameTime = 0;
			this.mPlaying = true;
			callback();
			return;
		}
		this.mGameReadyCallback = callback;
		var xml:ASAny = "<data><mode>" + mode + "</mode><startlevel>" + level + "</startlevel></data>";
		ExternalInterface.call("GameReady", xml);
	}

	function onMuteOff() {
		this.toggleMute(false);
	}

	function onGameMute(str:String) {
		this.toggleMute(this.onOffAsBoolean(str));
	}

	public function setLoadPercent(loadPercent:Float) {
		this.mLoadPercent = loadPercent < 0 ? 0 : loadPercent;
		this.mLoadPercent = this.mLoadPercent > 100 ? 100 : this.mLoadPercent;
		this.mLoadPercent = Std.int(this.mLoadPercent);
	}

	function onGameContinue(sXML:String = null) {
		this.mPlaying = true;
		this.mGameBreakCallback();
		this.mGameBreakCallback = null;
	}

	@:flash.property @:isVar public var enabled(get, never):Bool;

	public function get_enabled():Bool {
		return this.mEnabled;
	}

	public function SessionReady(callback:ASFunction) {
		this.mLoading = false;
		var xml:ASAny = "<data><percentcomplete>" + this.mLoadPercent + "</percentcomplete></data>";
		if (!this.mEnabled || !ExternalInterface.available) {
			callback();
			return;
		}
		this.mSessionReadyCallback = callback;
		ExternalInterface.call("LoadBroadcast", xml);
		ExternalInterface.call("SessionReady", "<data></data>");
	}

	public function setScore(score:Float) {
		this.mScore = score;
	}

	function onOffAsBoolean(str:String):Bool {
		if (str == "on") {
			return true;
		}
		return false;
	}

	public function GameEnd() {
		this.mPlaying = false;
		if (!this.mEnabled || !ExternalInterface.available) {
			return;
		}
		ExternalInterface.call("GameEnd", "<gamedata></gamedata>");
	}

	public function pauseBroadcast() {
		this.mPlaying = false;
	}

	function onGameStart() {
		this.mGameTime = 0;
		this.mPlaying = true;
		this.mGameReadyCallback();
		this.mGameReadyCallback = null;
	}

	function onSessionStart() {
		this.mSessionReadyCallback();
		this.mSessionReadyCallback = null;
	}

	public function update() {
		var xml:ASAny = null;
		var isLoadBroadcastTime:ASAny = false;
		var isTime:ASAny = false;
		if (!this.mEnabled) {
			return;
		}
		this.mAppTime += MILLIS_PER_UPDATE;
		if (this.mLoading) {
			isLoadBroadcastTime = this.mAppTime % this.mLoadBroadcastRate == 0;
			if (isLoadBroadcastTime) {
				xml = "<data><percentcomplete>" + this.mLoadPercent + "</percentcomplete></data>";
				if (ExternalInterface.available) {
					ExternalInterface.call("LoadBroadcast", xml);
				}
			}
		}
		if (this.mPlaying && !this.mApp.isPaused) {
			this.mGameTime += MILLIS_PER_UPDATE;
			isTime = this.mGameTime % this.mScoreBroadcastRate == 0;
			if (isTime) {
				xml = "<game><score>" + this.mScore + "</score><time>" + Std.int(this.mGameTime / 1000) + "</time></game>";
				if (ExternalInterface.available) {
					ExternalInterface.call("ScoreBroadcast", xml);
				}
			}
		}
	}

	function onGameMenu() {
		this.mPlaying = false;
		if (this.handleMenu != null) {
			this.handleMenu();
		}
	}
}
