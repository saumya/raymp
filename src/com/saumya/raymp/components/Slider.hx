
package com.saumya.raymp.components;

import openfl.display.Sprite;

import openfl.display.Sprite;
import openfl.display.Shape;
import openfl.display.Graphics;

import openfl.geom.Point;

import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.text.TextFieldAutoSize;

import openfl.events.Event;
import openfl.events.TouchEvent;
import openfl.events.MouseEvent;

import openfl.Assets;
import openfl.Lib;

class Slider extends Sprite {

	public static var IS_BEING_DRAGGED:String = "isBeingDraggedEvent";
	public static var VALUE_CHANGED:String = "valueChangedEvent";

	private var fontHt:UInt;
	private var tValue:TextField;

	private var btnDraggable:Sprite;
	private var btnLineIndicator:Sprite;

	private var isDragging:Bool;
	

	public function new(fontHeight:Int=14) {
		super();
		this.fontHt = fontHeight;
		this.isDragging = false;

		construct();
	}//new
	private function construct():Void{
		
		var font = Assets.getFont ("fonts/OpenSans-Regular.ttf");
		var defaultFormat = new TextFormat (font.fontName, this.fontHt, 0x000000);
		defaultFormat.align = TextFormatAlign.LEFT;
		
		// text
		tValue = new TextField();
		tValue.text = "0 %";
		//tValue.autoSize = TextFieldAutoSize.LEFT;
		tValue.autoSize = TextFieldAutoSize.CENTER;
		tValue.x = 0;
		tValue.y = 0; // A little upward is actually makes it look in CENTER
		tValue.defaultTextFormat = defaultFormat;
		tValue.embedFonts = true;
		tValue.selectable = false;
		tValue.width = 220;
		this.addChild(tValue);
		//
		this.btnDraggable = new Sprite();
		this.btnLineIndicator = new Sprite();

		this.addChild(this.btnLineIndicator);
		this.addChild(this.btnDraggable);
		//
		//this.btnDraggable.addEventListener(MouseEvent.CLICK,onClick);
		this.btnDraggable.addEventListener(MouseEvent.MOUSE_DOWN,onBtnDraggable_MouseDown);
		//this.btnDraggable.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);


		drawBackground();
	}//construct
	private function drawBackground():Void{
		// whole background
		var g:Graphics = this.graphics;
		var c:UInt = 0xFFFFFF;
		g.beginFill(c,1.0);
		g.drawRect(0,0,220,40);
		g.endFill();
		// draw the buttons
		// line
		var g1:Graphics = this.btnLineIndicator.graphics;
		var c1:UInt = 0x666666;
		g1.beginFill(c1,1.0);
		g1.drawRect(0,0,200,2);
		g1.endFill();
		// draggable
		var g2:Graphics = this.btnDraggable.graphics;
		var c2:UInt = 0xCCCCCC;
		g2.beginFill(c2,1.0);
		g2.drawRect(0,0,20,20);
		g2.endFill();
		//
		this.btnLineIndicator.y = 14;
		this.btnDraggable.y = 4;
		this.tValue.y = 20;

		this.btnLineIndicator.x = btnDraggable.x = tValue.x = 10;
	}//drawBackground

	private function onClick(e:MouseEvent):Void{
		trace('click');
		if (isDragging) {
			isDragging = false;
			this.btnDraggable.stopDrag();
		}else{
			isDragging = true;
			this.btnDraggable.startDrag();
		}
	}

	private function onBtnDraggable_MouseDown(e:MouseEvent):Void{
		trace("onBtnDraggable_MouseDown");
		stage.addEventListener (MouseEvent.MOUSE_MOVE, stage_onMouseMove);
		stage.addEventListener (MouseEvent.MOUSE_UP, stage_onMouseUp);
	}
	private function stage_onMouseUp(e:MouseEvent):Void{
		trace("stage_onMouseUp");
		stage.removeEventListener (MouseEvent.MOUSE_MOVE, stage_onMouseMove);
		stage.removeEventListener (MouseEvent.MOUSE_UP, stage_onMouseUp);
		
		trace("stage_onMouseUp",tValue.text);
		var evt:Event = new Event(Slider.VALUE_CHANGED,false,false);
		dispatchEvent(evt);
	}
	private function stage_onMouseMove(e:MouseEvent):Void{
		trace("stage_onMouseMove");
		this.btnDraggable.x = e.localX;
		var min = btnLineIndicator.x;
		var max = btnLineIndicator.x + btnLineIndicator.width - btnDraggable.width;
		var current = e.localX;
		trace(this.btnDraggable.x,this.btnLineIndicator.x,this.btnLineIndicator.width);
		trace(current/max);
		var currentValueToDisplay = Math.round (current/max * 100);
		trace('percent',currentValueToDisplay);
		if(current<=min){
			btnDraggable.x = min;
			currentValueToDisplay = 0;
		}else if(current>=max){
			btnDraggable.x=max;
			currentValueToDisplay = 100;
		}
		tValue.text = currentValueToDisplay+" %";
		
		trace("stage_onMouseMove",tValue.text);
		var evt:Event = new Event(Slider.IS_BEING_DRAGGED,false,false);
		dispatchEvent(evt);
	}//stage_onMouseMove
}