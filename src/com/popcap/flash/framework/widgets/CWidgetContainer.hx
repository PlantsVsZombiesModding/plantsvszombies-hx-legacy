package com.popcap.flash.framework.widgets;

import com.popcap.flash.framework.graphics.Graphics2D;
import openfl.geom.Point;
import openfl.geom.Rectangle;

class CWidgetContainer {
	public static var depthCount:Float = 0;

	public var y:Float = 0;

	public var height:Float = 0;

	public var parent:CWidgetContainer = null;

	public var priority:Float = 0;

	public var widgets:Array<ASAny>;

	public var lastWMUpdateCount:Float = 0;

	public var width:Float = 0;

	public var widgetManager:CWidgetManager = null;

	public var updateCount:Float = 0;

	public var clip:Bool = true;

	public var dirty:Bool = false;

	public var hasAlpha:Bool = false;

	public var zOrder:Float = 0;

	public var x:Float = 0;

	public function new() {
		this.widgets = new Array<ASAny>();
		// super();
		this.x = 0;
		this.y = 0;
		this.width = 0;
		this.height = 0;
		this.parent = null;
		this.widgetManager = null;
		this.dirty = false;
		this.hasAlpha = false;
		this.clip = true;
		this.priority = 0;
		this.zOrder = 0;
	}

	public function onMouseEnter() {}

	public function markDirty(param1:CWidgetContainer = null) {
		var _loc2_ = false;
		var _loc3_ = 0;
		var _loc4_ = 0;
		var _loc5_:CWidget = null;
		if (param1 == null) {
			if (this.parent != null) {
				this.parent.markDirty(this);
			} else {
				this.dirty = true;
			}
			return;
		}
		if (param1.dirty == true) {
			return;
		}
		this.markDirty();
		param1.dirty = true;
		if (this.parent != null) {
			return;
		}
		if (param1.hasAlpha) {
			this.markDirtyFull(param1);
		} else {
			_loc2_ = false;
			_loc3_ = this.widgets.length;
			_loc4_ = 0;
			while (_loc4_ < _loc3_) {
				if ((_loc5_ = this.widgets[_loc4_]) == param1) {
					_loc2_ = true;
				} else if (_loc2_) {
					if (_loc5_.visible == true && _loc5_.intersects(param1)) {
						this.markDirty(_loc5_);
					}
				}
				_loc4_++;
			}
		}
	}

	public function sysColorChangesAll() {
		var _loc3_:CWidget = null;
		this.sysColorChanged();
		depthCount = 0;
		if (this.widgets.length > 0) {
			++depthCount;
		}
		var _loc1_ = this.widgets.length;
		var _loc2_ = 0;
		while (_loc2_ < _loc1_) {
			_loc3_ = this.widgets[_loc2_];
			_loc3_.sysColorChangesAll();
			_loc2_++;
		}
	}

	public function putInfront(param1:CWidget, param2:CWidget) {
		var _loc6_:CWidget = null;
		var _loc3_:Float = this.widgets.indexOf(param1);
		if (_loc3_ < 0) {
			return;
		}
		var _loc4_ = this.widgets.length;
		var _loc5_ = 0;
		while (_loc5_ < _loc4_) {
			if ((_loc6_ = this.widgets[_loc5_]) == param2) {
				this.widgets = this.widgets.splice(_loc5_, 0, param1);
				return;
			}
			_loc5_++;
		}
	}

	public function setFocus(param1:CWidget) {}

	public function updateAll(param1:CModalFlags) {
		var _loc4_:CWidget = null;
		if ((Std.int(param1.getFlags()) & Std.int(CWidgetManager.WIDGETFLAGS_MARK_DIRTY)) != 0) {
			this.markDirty();
		}
		if (this.widgetManager == null) {
			return;
		}
		if ((Std.int(param1.getFlags()) & Std.int(CWidgetManager.WIDGETFLAGS_UPDATE)) != 0) {
			if (this.lastWMUpdateCount != this.widgetManager.updateCount) {
				this.lastWMUpdateCount = this.widgetManager.updateCount;
				this.update();
			}
		}
		var _loc2_ = this.widgets.length;
		var _loc3_ = 0;
		while (_loc3_ < _loc2_) {
			if ((_loc4_ = this.widgets[_loc3_]) == this.widgetManager.baseModalWidget) {
				param1.isOver = true;
			}
			_loc4_.updateAll(param1);
			_loc3_++;
		}
	}

	public function addedToManager(param1:CWidgetManager) {
		var _loc4_:CWidget = null;
		var _loc2_ = this.widgets.length;
		var _loc3_ = 0;
		while (_loc3_ < _loc2_) {
			(_loc4_ = this.widgets[_loc3_]).widgetManager = param1;
			_loc4_.addedToManager(param1);
			this.markDirty();
			_loc3_++;
		}
	}

	public function getWidgetAtHelper(param1:Float, param2:Float, param3:Float, param4:Point):CWidget {
		var _loc7_:CWidget = null;
		var _loc8_:CWidget = null;
		var _loc5_:Int;
		var _loc6_ = (_loc5_ = this.widgets.length) - 1;
		while (_loc6_ >= 0) {
			if ((_loc7_ = this.widgets[_loc6_]).visible) {
				if ((_loc8_ = _loc7_.getWidgetAtHelper(param1, param2, param3, param4)) != null) {
					return _loc8_;
				}
				if (_loc7_.contains(param1, param2)) {
					param4.x = param1 - _loc7_.x;
					param4.y = param2 - _loc7_.y;
					return _loc7_;
				}
			}
			_loc6_--;
		}
		return null;
	}

	public function markAllDirty() {
		var _loc3_:CWidget = null;
		this.markDirty();
		var _loc1_ = this.widgets.length;
		var _loc2_ = 0;
		while (_loc2_ < _loc1_) {
			_loc3_ = this.widgets[_loc2_];
			_loc3_.dirty = true;
			_loc3_.markAllDirty();
			_loc2_++;
		}
	}

	public function removedFromManager(param1:CWidgetManager) {
		var _loc4_:CWidget = null;
		var _loc2_ = this.widgets.length;
		var _loc3_ = 0;
		while (_loc3_ < _loc2_) {
			_loc4_ = this.widgets[_loc3_];
			param1.disableWidget(_loc4_);
			_loc4_.removedFromManager(param1);
			_loc4_.widgetManager = null;
			_loc3_++;
		}
		if (param1.popupCommandWidget == this) {
			param1.popupCommandWidget = null;
		}
	}

	public function putBehind(param1:CWidget, param2:CWidget) {
		var _loc6_:CWidget = null;
		var _loc3_:Float = this.widgets.indexOf(param1);
		if (_loc3_ < 0) {
			return;
		}
		var _loc4_ = this.widgets.length;
		var _loc5_ = 0;
		while (_loc5_ < _loc4_) {
			if ((_loc6_ = this.widgets[_loc5_]) == param2) {
				this.widgets = this.widgets.splice(_loc5_ + 1, 0, param1);
				return;
			}
			_loc5_++;
		}
	}

	public function isBelow(param1:CWidget, param2:CWidget):Bool {
		return this.isBelowHelper(param1, param2);
	}

	public function intersects(param1:CWidgetContainer):Bool {
		return this.getRect().intersects(param1.getRect());
	}

	public function isBelowHelper(param1:CWidget, param2:CWidget):Bool {
		var _loc5_:CWidget = null;
		var _loc6_ = false;
		var _loc3_ = this.widgets.length;
		var _loc4_ = 0;
		while (_loc4_ < _loc3_) {
			if ((_loc5_ = this.widgets[_loc4_]) == param1) {
				return true;
			}
			if (_loc5_ == param2) {
				return false;
			}
			if (_loc6_ = _loc5_.isBelowHelper(param1, param2)) {
				return true;
			}
			_loc4_++;
		}
		return false;
	}

	public function bringToBack(param1:CWidget) {
		var _loc2_:Float = this.widgets.indexOf(param1);
		if (_loc2_ < 0) {
			return;
		}
		this.widgets = this.widgets.splice(Std.int(_loc2_), 1);
		this.widgets.push(param1);
		param1.orderInManagerChanged();
	}

	public function drawAll(param1:CModalFlags, param2:Graphics2D) {
		var _loc5_:CWidget = null;
		if (this.priority > this.widgetManager.minDeferredOverlayPriority) {
			this.widgetManager.flushDeferredOverlayWidgets(param2, this.priority);
		}
		if (this.clip && ASCompat.toBool(Std.int(param1.getFlags()) & Std.int(CWidgetManager.WIDGETFLAGS_CLIP))) {}
		if (this.widgets.length == 0) {
			if ((Std.int(param1.getFlags()) & Std.int(CWidgetManager.WIDGETFLAGS_DRAW)) != 0) {
				this.draw(param2);
			}
			return;
		}
		if ((Std.int(param1.getFlags()) & Std.int(CWidgetManager.WIDGETFLAGS_DRAW)) != 0) {
			param2.pushState();
			this.draw(param2);
			param2.popState();
		}
		var _loc3_ = this.widgets.length;
		var _loc4_ = 0;
		while (_loc4_ < _loc3_) {
			if ((_loc5_ = this.widgets[_loc4_]).visible == true) {
				param2.pushState();
				param2.translate(_loc5_.x, _loc5_.y);
				_loc5_.drawAll(param1, param2);
				param2.popState();
				_loc5_.dirty = false;
			}
			_loc4_++;
		}
	}

	public function sysColorChanged() {}

	public function onMouseUp(param1:Float, param2:Float) {}

	public function onKeyDown(param1:UInt) {}

	public function markDirtyFull(param1:CWidgetContainer = null) {
		var _loc7_:Rectangle = null;
		if (param1 == null) {
			if (this.parent != null) {
				this.parent.markDirtyFull(this);
			} else {
				this.dirty = true;
			}
			return;
		}
		this.markDirtyFull();
		param1.dirty = true;
		if (this.parent != null) {
			return;
		}
		var _loc2_:Float = this.widgets.indexOf(param1);
		if (_loc2_ == -1) {
			return;
		}
		var _loc3_ = Std.int(_loc2_);
		var _loc4_ = 0;
		var _loc5_:CWidget = null;
		_loc3_ = 0;
		while (_loc3_ >= 0) {
			_loc4_ = _loc3_;
			while (_loc4_ >= 0) {
				if ((_loc5_ = this.widgets[_loc4_]).visible == true) {
					if (!_loc5_.hasTransparencies && !_loc5_.hasAlpha) {
						_loc7_ = new Rectangle(_loc5_.x, _loc5_.y, _loc5_.width, _loc5_.height).intersection(new Rectangle(0, 0, this.width, this.height));
						if (_loc5_.contains(_loc7_.x, _loc7_.y)
							&& _loc5_.contains(_loc7_.x + _loc7_.width - 1, _loc7_.y + _loc7_.height - 1)) {
							_loc5_.markDirty();
							break;
						}
					}
				}
				_loc4_ += -1;
			}
			_loc3_ = _loc4_;
			_loc3_ += -1;
		}
		_loc3_ = Std.int(_loc2_);
		var _loc6_ = this.widgets.length;
		while (_loc3_ < _loc6_) {
			if ((_loc5_ = this.widgets[_loc3_]).visible && _loc5_.intersects(param1)) {
				_loc5_.markDirty();
			}
			_loc3_++;
		}
	}

	public function draw(param1:Graphics2D) {}

	public function addWidget(param1:CWidget) {
		if (param1.parent == this) {
			return;
		}
		if (param1.parent != null) {
			param1.parent.removeWidget(param1);
		}
		this.widgets.push(param1);
		param1.widgetManager = this.widgetManager;
		param1.parent = this;
		if (this.widgetManager != null) {
			param1.addedToManager(this.widgetManager);
			param1.markDirtyFull();
			this.widgetManager.rehupMouse();
		}
		this.markDirty();
	}

	public function onKeyUp(param1:UInt) {}

	public function disableWidget(param1:CWidget) {}

	public function onMouseLeave() {}

	public function onMouseDown(param1:Float, param2:Float) {}

	public function update() {
		++this.updateCount;
	}

	public function getRect():Rectangle {
		return new Rectangle(this.x, this.y, this.width, this.height);
	}

	public function onMouseDrag(param1:Float, param2:Float) {}

	public function insertWidgetHelper(param1:CWidget) {
		var _loc4_:CWidget = null;
		var _loc2_ = this.widgets.length;
		var _loc3_ = 0;
		while (_loc3_ < _loc2_) {
			_loc4_ = this.widgets[_loc3_];
			if (param1.zOrder < _loc4_.zOrder) {
				this.widgets = this.widgets.splice(_loc3_, 0, param1);
				return;
			}
			_loc3_++;
		}
	}

	public function removeWidget(param1:CWidget) {
		if (param1.parent != this) {
			return;
		}
		param1.widgetRemovedHelper();
		param1.parent = null;
		var _loc2_:Float = this.widgets.indexOf(param1);
		this.widgets.splice(Std.int(_loc2_), 1);
	}

	public function removeAllWidgets(param1:Bool = true) {
		var _loc2_:CWidget = null;
		while (this.widgets.length > 0) {
			_loc2_ = this.widgets.shift();
			if (param1) {
				_loc2_.removeAllWidgets(param1);
			}
		}
	}

	public function onMouseWheel(param1:Float) {}

	public function onKeyChar(param1:UInt) {}

	public function onMouseMove(param1:Float, param2:Float) {}

	public function bringToFront(param1:CWidget) {
		var _loc2_:Float = this.widgets.indexOf(param1);
		if (_loc2_ < 0) {
			return;
		}
		this.widgets = this.widgets.splice(Std.int(_loc2_), 1);
		this.widgets.unshift(param1);
		param1.orderInManagerChanged();
	}

	public function hasWidget(param1:CWidget):Bool {
		return param1.parent == this;
	}

	public function getAbsPos():Point {
		var _loc1_ = new Point(this.x, this.y);
		if (this.parent != null) {
			_loc1_.add(this.parent.getAbsPos());
		}
		return _loc1_;
	}
}
