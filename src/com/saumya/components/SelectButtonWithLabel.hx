package com.saumya.components;

import openfl.display.Sprite;
import openfl.display.Graphics;

import openfl.text.TextField;
import openfl.text.TextFieldType;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.text.TextFieldAutoSize;

import openfl.events.Event;
import openfl.events.TouchEvent;
import openfl.events.MouseEvent;

import openfl.Assets;
import openfl.Lib;

import motion.Actuate;
import motion.easing.Quad;
import motion.easing.Elastic;


class SelectButtonWithLabel extends Sprite {

	public static var TOGGLE_EVENT:String = "ToggleEvent";

	private var btn:Sprite;
	private var isOn:Bool;

	//private var widthX:Float;
	//private var heightX:Float;

	private var label:TextField;
	private var fontHeight:UInt;
	private var isLabelOnLeft:Bool;

	private var aLabels:Array<String>;

	public function new(checkBoxSize:UInt,uFontHeight:UInt,isLabelOnLeft:Bool, labels:Array<String>,labelWidth:Float) {
		super();
		construct(checkBoxSize,uFontHeight,isLabelOnLeft,labels,labelWidth);
	}
	private function construct(sizeWidth:UInt,uFontHeight:UInt,isLabelOnLeft:Bool,labels:Array<String>,labelWidth:Float):Void{
		isOn = false;
		//this.fontHeight = sizeWidth-4;
		this.fontHeight = uFontHeight;
		this.isLabelOnLeft = isLabelOnLeft;
		this.aLabels = labels;

		btn = new Sprite();
		this.addEventListener(MouseEvent.CLICK,onClick);
		addChild(btn);
		
		var font = Assets.getFont ("fonts/OpenSans-Regular.ttf");
		var defaultFormat = new TextFormat (font.fontName, this.fontHeight, 0x000000);
		defaultFormat.align = TextFormatAlign.LEFT;

		label = new TextField();
		label.text = this.aLabels[1];
		label.autoSize = TextFieldAutoSize.LEFT;
		//label.width = 200;
		//label.type = TextFieldType.INPUT;
		label.defaultTextFormat = defaultFormat;
		label.embedFonts = true;
		label.selectable = true;
		label.border = false;
		label.multiline = false;
		label.selectable = false;
		label.x = sizeWidth + 4;
		label.y = (-1)*(this.fontHeight/4);
		addChild(label);

		//position
		var posX:Float = 0;
		if(isLabelOnLeft){
			//posX = label.x+label.width+4; // 4 : distance between label and button
			//posX = 100; // Just a default
			posX = labelWidth;
			label.x = 0;
			btn.x = posX;
		}

		drawBackground(sizeWidth,sizeWidth,posX);
	}
	private function drawBackground(w:Float,h:Float,xPos:Float):Void{
		// This could be done better. Fix this once its workable

		var g:Graphics = this.graphics;
		
		var c1:UInt = 0x444444;
		g.beginFill(c1,1.0);
		g.drawRect(xPos,0,w,h);
		//g.drawCircle(xPos+h/2,0,h);
		g.endFill();
		
		var c2:UInt = 0x888888;
		g.beginFill(c2,1.0);
		g.drawRect(xPos+2,2,w-4,h-4);
		//g.drawCircle(xPos+h/2,0,h-4);
		g.endFill();
		
		// draw the button
		var g1:Graphics = this.btn.graphics;
		var c3:UInt = 0x00FF00;
		g1.beginFill(c3,1.0);
		g1.drawRect(4,4,w-8,h-8);
		//g1.drawCircle(10,0,w-8);
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
			label.text = this.aLabels[0];
		} else{
			//newX = 0;
			//newColor = 0xCCCCCC;
			alphaX = 0;
			label.text = this.aLabels[1];
		}
		Actuate.tween(this.btn,0.6,{ alpha:alphaX }).ease (Quad.easeOut);
		trace('isOn',isOn);
		//finally 
		dispatchEvent(new Event(ToggleButton.TOGGLE_EVENT));
	} // onClick
}