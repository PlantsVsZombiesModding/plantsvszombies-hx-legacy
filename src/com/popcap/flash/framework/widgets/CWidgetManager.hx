package com.popcap.flash.framework.widgets;

import com.popcap.flash.framework.AppBase;
import com.popcap.flash.framework.graphics.Graphics2D;
import openfl.geom.Point;
import openfl.ui.Keyboard;

class CWidgetManager extends CWidgetContainer {
	public static inline final WIDGETFLAGS_DRAW:Float = 4;

	public static inline final WIDGETFLAGS_UPDATE:Float = 1;

	public static inline final WIDGETFLAGS_CLIP:Float = 8;

	public static inline final WIDGETFLAGS_ALLOW_FOCUS:Float = 32;

	public static inline final WIDGETFLAGS_ALLOW_MOUSE:Float = 16;

	public static inline final WIDGETFLAGS_MARK_DIRTY:Float = 2;

	public var minDeferredOverlayPriority:Float = 0;

	public var deferredOverlayWidgets:Array<ASAny>;

	public var lastMouseX:Float = 0;

	public var lastMouseY:Float = 0;

	public var mShowFinger:Bool = false;

	public var belowModalFlagsMod:CFlagsMod;

	public var defaultTab:CWidget = null;

	public var keyDown:Array<ASAny>;

	public var popupCommandWidget:CWidget;

	public var app:AppBase;

	public var mouseIn:Bool = true;

	public var lostFocusFlagsMod:CFlagsMod;

	public var widgetFlags:Float = 0;

	public var overWidget:CWidget;

	public var lastDownWidget:CWidget;

	public var defaultBelowModalFlagsMod:CFlagsMod;

	public var baseModalWidget:CWidget;

	public var focusWidget:CWidget;

	public var lastInputUpdateCount:Float = 0;

	public var preModalInfoList:Array<ASAny>;

	var modalFlags:CModalFlags;

	public var hasFocus:Bool = true;

	public var downButtons:Float = 0;

	public function new(param1:AppBase) {
		super();
		this.modalFlags = new CModalFlags();
		this.keyDown = new Array<ASAny>();
		this.deferredOverlayWidgets = new Array<ASAny>();
		this.preModalInfoList = new Array<ASAny>();
		this.lostFocusFlagsMod = new CFlagsMod();
		this.belowModalFlagsMod = new CFlagsMod();
		this.defaultBelowModalFlagsMod = new CFlagsMod();
		// super();
		this.app = param1;
		widgetManager = this;
		this.widgetFlags = Std.int(WIDGETFLAGS_UPDATE) | Std.int(WIDGETFLAGS_DRAW) | Std.int(WIDGETFLAGS_CLIP) | Std.int(WIDGETFLAGS_ALLOW_MOUSE) | Std.int(WIDGETFLAGS_ALLOW_FOCUS);
		var _loc2_ = 0;
		while (_loc2_ < 255) {
			this.keyDown[_loc2_] = false;
			_loc2_++;
		}
	}

	public function getWidgetAt(param1:Float, param2:Float, param3:Point):CWidget {
		var _loc4_:CWidget;
		if ((_loc4_ = this.getAnyWidgetAt(param1, param2, param3)) != null && _loc4_.disabled) {
			_loc4_ = null;
		}
		return _loc4_;
	}

	public function doKeyUp(param1:UInt) {
		this.lastInputUpdateCount = updateCount;
		this.keyDown[param1] = false;
		if (param1 == Keyboard.TAB && ASCompat.toBool(this.keyDown[Keyboard.CONTROL])) {
			return;
		}
		if (this.focusWidget != null) {
			this.focusWidget.onKeyUp(param1);
		}
	}

	public function initModalFlags(param1:CModalFlags) {
		param1.isOver = this.baseModalWidget == null;
		param1.overFlags = this.getWidgetFlags();
		param1.underFlags = CFlagsMod.getModFlags(param1.overFlags, this.belowModalFlagsMod);
	}

	public function rehupMouse() {
		var _loc1_:CWidget = null;
		var _loc2_:CWidget = null;
		if (this.lastDownWidget != null) {
			if (this.overWidget != null) {
				_loc1_ = this.getWidgetAt(this.lastMouseX, this.lastMouseY, new Point());
				if (_loc1_ != this.lastDownWidget) {
					_loc2_ = this.overWidget;
					this.overWidget = null;
					this.doMouseLeave(_loc2_);
				}
			}
		} else if (this.mouseIn) {
			this.setMousePosition(this.lastMouseX, this.lastMouseY);
		}
	}

	public function doMouseUps(param1:CWidget = null, param2:Float = 0) {
		if (param1 == null) {
			if (this.lastDownWidget != null && this.downButtons != 0) {
				this.doMouseUps(this.lastDownWidget, this.downButtons);
				this.downButtons = 0;
				this.lastDownWidget = null;
			}
			return;
		}
		param1.isDown = false;
		param1.onMouseUp(this.lastMouseX - param1.x, this.lastMouseY - param1.y);
	}

	public function doMouseExit(param1:Float, param2:Float) {
		this.lastInputUpdateCount = updateCount;
		this.mouseIn = false;
		if (this.overWidget != null) {
			this.doMouseLeave(this.overWidget);
			this.overWidget = null;
		}
	}

	public function setBaseModal(param1:CWidget, param2:CFlagsMod) {
		var _loc4_ = Math.NaN;
		this.baseModalWidget = param1;
		this.belowModalFlagsMod = param2;
		var _loc3_:CWidget = null;
		if (this.overWidget != null
			&& (Std.int(this.belowModalFlagsMod.removeFlags) & Std.int(WIDGETFLAGS_ALLOW_MOUSE)) != 0
				&& isBelow(this.overWidget, this.baseModalWidget)) {
			_loc3_ = this.overWidget;
			this.overWidget = null;
			this.doMouseLeave(_loc3_);
		}
		if (this.lastDownWidget != null
			&& (Std.int(this.belowModalFlagsMod.removeFlags) & Std.int(WIDGETFLAGS_ALLOW_MOUSE)) != 0
				&& isBelow(this.lastDownWidget, this.baseModalWidget)) {
			_loc3_ = this.lastDownWidget;
			_loc4_ = this.downButtons;
			this.downButtons = 0;
			this.lastDownWidget = null;
			this.doMouseUps(_loc3_, _loc4_);
		}
		if (this.focusWidget != null
			&& (Std.int(this.belowModalFlagsMod.removeFlags) & Std.int(WIDGETFLAGS_ALLOW_FOCUS)) != 0
				&& isBelow(this.focusWidget, this.baseModalWidget)) {
			_loc3_ = this.focusWidget;
			this.focusWidget = null;
			_loc3_.lostFocus();
		}
	}

	public function doMouseUp(param1:Float, param2:Float) {
		var _loc3_:CWidget = null;
		this.lastInputUpdateCount = updateCount;
		if (this.lastDownWidget != null && this.downButtons != 0) {
			_loc3_ = this.lastDownWidget;
			this.downButtons = 0;
			this.lastDownWidget = null;
			_loc3_.isDown = false;
			_loc3_.onMouseUp(param1 - _loc3_.x, param2 - _loc3_.y);
		}
		this.setMousePosition(param1, param2);
	}

	override public function setFocus(param1:CWidget) {
		if (param1 == this.focusWidget) {
			return;
		}
		if (this.focusWidget != null) {
			this.focusWidget.lostFocus();
		}
		if (param1 != null && param1.widgetManager == this) {
			this.focusWidget = param1;
			if (this.hasFocus && this.focusWidget != null) {
				this.focusWidget.gotFocus();
			}
		} else {
			this.focusWidget = null;
		}
	}

	public function doMouseEnter(param1:CWidget) {
		param1.isOver = true;
		param1.onMouseEnter();
		if (param1.doFinger) {
			param1.showFinger(true);
		}
	}

	public function deferOverlay(param1:CWidget, param2:Float) {
		var _loc3_:ASObject = new ASObject();
		_loc3_.widget = param1;
		_loc3_.priority = param2;
		this.deferredOverlayWidgets.push(_loc3_);
		if (param2 < this.minDeferredOverlayPriority) {
			this.minDeferredOverlayPriority = param2;
		}
	}

	public function flushDeferredOverlayWidgets(param1:Graphics2D, param2:Float) {
		var _loc3_ = Math.NaN;
		var _loc4_ = 0;
		var _loc5_ = 0;
		var _loc6_:ASObject = null;
		var _loc7_:CWidget = null;
		var _loc8_ = Math.NaN;
		do {
			_loc3_ = ASCompat.MAX_FLOAT;
			_loc4_ = this.deferredOverlayWidgets.length;
			_loc5_ = 0;
			while (_loc5_ < _loc4_) {
				_loc7_ = (_loc6_ = this.deferredOverlayWidgets[_loc5_]).widget;
				if (_loc6_.widget != null) {
					if ((_loc8_ = ASCompat.toNumber(_loc6_.priority)) == this.minDeferredOverlayPriority) {
						param1.pushState();
						param1.translate(_loc7_.x, _loc7_.y);
						_loc7_.drawOverlay(param1, _loc8_);
						param1.popState();
						_loc6_.widget = null;
					} else if (_loc8_ < _loc3_) {
						_loc3_ = _loc8_;
					}
				}
				_loc5_++;
			}
			this.minDeferredOverlayPriority = _loc3_;
			if (_loc3_ == ASCompat.MAX_FLOAT) {
				this.deferredOverlayWidgets = new Array<ASAny>();
				break;
			}
		} while (_loc3_ < param2);
	}

	public function setPopupCommandWidget(param1:CWidget) {
		this.popupCommandWidget = param1;
		addWidget(this.popupCommandWidget);
	}

	public function updateFrame():Bool {
		this.initModalFlags(this.modalFlags);
		++updateCount;
		lastWMUpdateCount = updateCount;
		updateAll(this.modalFlags);
		return dirty;
	}

	public function doMouseWheel(param1:Float) {
		this.lastInputUpdateCount = updateCount;
		if (this.focusWidget != null) {
			this.focusWidget.onMouseWheel(param1);
		}
	}

	public function doMouseDrag(param1:Float, param2:Float) {
		var _loc3_:CWidget = null;
		var _loc4_:Point = null;
		var _loc5_:Point = null;
		this.lastInputUpdateCount = updateCount;
		this.mouseIn = true;
		this.lastMouseX = param1;
		this.lastMouseY = param2;
		if (this.overWidget != null && this.overWidget != this.lastDownWidget) {
			_loc3_ = this.overWidget;
			this.overWidget = null;
			this.doMouseLeave(_loc3_);
		}
		if (this.lastDownWidget != null) {
			_loc4_ = this.lastDownWidget.getAbsPos();
			_loc5_ = new Point(param1 - _loc4_.x, param2 - _loc4_.y);
			this.lastDownWidget.onMouseDrag(_loc5_.x, _loc5_.y);
			_loc3_ = this.getWidgetAt(param1, param2, new Point());
			if (_loc3_ == this.lastDownWidget && _loc3_ != null) {
				if (this.overWidget == null) {
					this.overWidget = this.lastDownWidget;
					this.doMouseEnter(this.overWidget);
				}
			} else if (this.overWidget != null) {
				_loc3_ = this.overWidget;
				this.overWidget = null;
				this.doMouseLeave(_loc3_);
			}
		}
	}

	public function lostFocus() {
		var _loc1_ = Math.NaN;
		if (this.hasFocus) {
			this.downButtons = 0;
			_loc1_ = 0;
			while (_loc1_ < this.keyDown.length) {
				if (this.keyDown[Std.int(_loc1_)]) {
					onKeyUp(Std.int(_loc1_));
				}
				this.hasFocus = false;
				if (this.focusWidget != null) {
					this.focusWidget.lostFocus();
				}
				_loc1_++;
			}
		}
	}

	public function addBaseModal(param1:CWidget, param2:CFlagsMod) {
		var _loc3_ = new CPreModalInfo();
		_loc3_.baseModalWidget = param1;
		_loc3_.prevBaseModalWidget = this.baseModalWidget;
		_loc3_.prevFocusWidget = this.focusWidget;
		_loc3_.prevBelowModalFlagsMod = this.belowModalFlagsMod;
		this.preModalInfoList.push(_loc3_);
		this.setBaseModal(param1, param2);
	}

	public function doMouseDown(param1:Float, param2:Float) {
		this.lastInputUpdateCount = updateCount;
		this.downButtons = 1;
		this.setMousePosition(param1, param2);
		var _loc3_ = new Point();
		var _loc4_ = this.getWidgetAt(param1, param2, _loc3_);
		if (this.lastDownWidget != null) {
			_loc4_ = this.lastDownWidget;
		}
		this.lastDownWidget = _loc4_;
		if (_loc4_ != null) {
			if (_loc4_.wantsFocus) {
				this.setFocus(_loc4_);
			}
			_loc4_.isDown = true;
			_loc4_.onMouseDown(_loc3_.x, _loc3_.y);
		}
	}

	public function gotFocus() {
		if (!this.hasFocus) {
			this.hasFocus = true;
			if (this.focusWidget != null) {
				this.focusWidget.gotFocus();
			}
		}
	}

	public function showFinger(param1:Bool, param2:CWidget) {
		if (this.overWidget == param2 || this.overWidget == null) {
			this.mShowFinger = param1;
		}
	}

	public function removeBaseModal(param1:CWidget) {
		var _loc3_:CPreModalInfo = null;
		var _loc4_ = false;
		if (this.preModalInfoList.length == 0) {
			throw new Error("Empty modal list.");
		}
		var _loc2_ = true;
		while (this.preModalInfoList.length > 0) {
			_loc3_ = this.preModalInfoList[this.preModalInfoList.length - 1];
			if (_loc2_ && _loc3_.baseModalWidget != param1) {
				return;
			}
			_loc4_ = _loc3_.prevBaseModalWidget != null || this.preModalInfoList.length == 1;
			this.setBaseModal(_loc3_.prevBaseModalWidget, _loc3_.prevBelowModalFlagsMod);
			if (this.focusWidget == null) {
				this.focusWidget = _loc3_.prevFocusWidget;
				if (this.focusWidget != null) {
					this.focusWidget.gotFocus();
				}
			}
			this.preModalInfoList.pop();
			if (_loc4_) {
				break;
			}
			_loc2_ = false;
		}
	}

	public function doKeyChar(param1:UInt) {
		this.lastInputUpdateCount = updateCount;
		if (param1 == Keyboard.TAB) {
			if (this.keyDown[Keyboard.CONTROL]) {
				if (this.defaultTab != null) {
					this.defaultTab.onKeyChar(param1);
				}
				return;
			}
		}
		if (this.focusWidget != null) {
			this.focusWidget.onKeyChar(param1);
		}
	}

	override public function disableWidget(param1:CWidget) {
		var _loc2_:CWidget = null;
		if (this.overWidget == param1) {
			_loc2_ = this.overWidget;
			this.overWidget = null;
			this.doMouseLeave(_loc2_);
		}
		if (this.lastDownWidget == param1) {
			_loc2_ = this.lastDownWidget;
			this.lastDownWidget = null;
			this.doMouseUps(_loc2_, this.downButtons);
			this.downButtons = 0;
		}
		if (this.focusWidget == param1) {
			_loc2_ = this.focusWidget;
			this.focusWidget = null;
			_loc2_.lostFocus();
		}
		if (this.baseModalWidget == param1) {
			this.baseModalWidget = null;
		}
	}

	public function removePopupCommandWidget() {
		var _loc1_:CWidget = null;
		if (this.popupCommandWidget != null) {
			_loc1_ = this.popupCommandWidget;
			this.popupCommandWidget = null;
			removeWidget(_loc1_);
		}
	}

	public function doKeyDown(param1:UInt) {
		this.lastInputUpdateCount = updateCount;
		this.keyDown[param1] = true;
		if (this.focusWidget != null) {
			this.focusWidget.onKeyDown(param1);
		}
	}

	public function drawScreen(param1:Graphics2D) {
		this.initModalFlags(this.modalFlags);
		var _loc2_ = false;
		var _loc3_:Float = 0;
		var _loc4_ = false;
		var _loc5_ = false;
		var _loc6_:Float = 0;
		var _loc7_:CWidget = null;
		var _loc8_ = widgets.length;
		_loc6_ = 0;
		while (_loc6_ < _loc8_) {
			if ((_loc7_ = widgets[Std.int(_loc6_)]).dirty) {
				_loc3_++;
			}
			_loc6_++;
		}
		this.minDeferredOverlayPriority = ASCompat.MAX_FLOAT;
		this.deferredOverlayWidgets = new Array<ASAny>();
		if (_loc3_ > 0) {
			param1.pushState();
			_loc8_ = widgets.length;
			_loc6_ = 0;
			while (_loc6_ < _loc8_) {
				if ((_loc7_ = widgets[Std.int(_loc6_)]) == widgetManager.baseModalWidget) {
					this.modalFlags.isOver = true;
				}
				if (_loc7_.dirty && _loc7_.visible) {
					param1.pushState();
					param1.translate(_loc7_.x, _loc7_.y);
					_loc7_.drawAll(this.modalFlags, param1);
					param1.popState();
					_loc3_++;
					_loc2_ = true;
				}
				_loc6_++;
			}
			param1.popState();
		}
		this.flushDeferredOverlayWidgets(param1, ASCompat.MAX_FLOAT);
	}

	public function setMousePosition(param1:Float, param2:Float) {
		var _loc7_:CWidget = null;
		var _loc3_ = this.lastMouseX;
		var _loc4_ = this.lastMouseY;
		this.lastMouseX = param1;
		this.lastMouseY = param2;
		var _loc5_ = new Point(0, 0);
		var _loc6_:CWidget;
		if ((_loc6_ = this.getWidgetAt(param1, param2, _loc5_)) != this.overWidget) {
			_loc7_ = this.overWidget;
			this.overWidget = null;
			if (_loc7_ != null) {
				this.doMouseLeave(_loc7_);
			}
			this.overWidget = _loc6_;
			if (_loc6_ != null) {
				this.doMouseEnter(_loc6_);
				_loc6_.onMouseMove(_loc5_.x, _loc5_.y);
			}
		} else if (_loc3_ != param1 || _loc4_ != param2) {
			if (_loc6_ != null) {
				_loc6_.onMouseMove(_loc5_.x, _loc5_.y);
			}
		}
	}

	public function remapMouse(param1:Float, param2:Float) {}

	public function doMouseMove(param1:Float, param2:Float) {
		this.lastInputUpdateCount = updateCount;
		if (this.downButtons != 0) {
			this.doMouseDrag(param1, param2);
		}
		this.mouseIn = true;
		this.setMousePosition(param1, param2);
	}

	public function getAnyWidgetAt(param1:Float, param2:Float, param3:Point):CWidget {
		return getWidgetAtHelper(param1, param2, this.getWidgetFlags(), param3);
	}

	public function getWidgetFlags():Float {
		return this.hasFocus ? this.widgetFlags : CFlagsMod.getModFlags(this.widgetFlags, this.lostFocusFlagsMod);
	}

	public function doMouseLeave(param1:CWidget) {
		param1.isOver = false;
		param1.onMouseLeave();
		if (param1.doFinger) {
			param1.showFinger(false);
		}
	}
}
