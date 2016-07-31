package com.saumya.components;

import openfl.display.Sprite;
import openfl.display.Graphics;

import openfl.events.Event;
import openfl.events.TouchEvent;
import openfl.events.MouseEvent;

import motion.Actuate;
import motion.easing.Quad;
import motion.easing.Elastic;


class SelectButton extends Sprite {

	public static var TOGGLE_EVENT:String = "ToggleEvent";

	private var btn:Sprite;
	private var isOn:Bool;

	private var widthX:Float;
	private var heightX:Float;

	public function new(sizeWidth:UInt) {
		super();
		construct(sizeWidth);
	}
	private function construct(sizeWidth:UInt):Void{
		isOn = false;

		btn = new Sprite();
		this.addEventListener(MouseEvent.CLICK,onClick);
		addChild(btn);

		widthX = sizeWidth;
		heightX = sizeWidth;
		drawBackground(widthX,heightX);
	}
	private function drawBackground(w:Float,h:Float):Void{
		//var widthX:Float = w + (2*margin);
		var g:Graphics = this.graphics;
		//var c:UInt = Math.round(Math.random()*this.maxColorValue);
		var c1:UInt = 0x444444;
		g.beginFill(c1,1.0);
		g.drawRect(0,0,w,h);
		g.endFill();
		
		var c2:UInt = 0x888888;
		g.beginFill(c2,1.0);
		g.drawRect(2,2,w-4,h-4);
		g.endFill();
		
		// draw the button
		var g1:Graphics = this.btn.graphics;
		var c3:UInt = 0x00FF00;
		g1.beginFill(c3,1.0);
		g1.drawRect(4,4,w-8,h-8);
		g1.endFill();
		this.btn.alpha = 0;
	}//drawBackground
	private function onClick(e:MouseEvent){
		//trace(btn);
		// Change value
		isOn = !isOn;
		// animate
		var alphaX = 0;
		var newColor:UInt = 0xFFFFFF;
		if (isOn) {
			//newX = widthX/2;
			//newColor = 0xFFFFFF;
			alphaX = 1;
		} else{
			//newX = 0;
			//newColor = 0xCCCCCC;
			alphaX = 0;
		}
		Actuate.tween(this.btn,0.6,{ alpha:alphaX }).ease (Quad.easeOut);
		trace('isOn',isOn);
		//finally 
		dispatchEvent(new Event(ToggleButton.TOGGLE_EVENT));
	} // onClick
}