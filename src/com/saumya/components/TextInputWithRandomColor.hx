
package com.saumya.components;

import openfl.display.Sprite;

import openfl.display.Sprite;
import openfl.display.Shape;
import openfl.display.Graphics;

import openfl.geom.Point;

import openfl.text.TextField;
import openfl.text.TextFieldType;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.text.TextFieldAutoSize;

import openfl.events.Event;

import openfl.Assets;
import openfl.Lib;


class TextInputWithRandomColor extends Sprite {

	private var maxColorValue:UInt;
	private var buttonLabel:String;
	private var fontHeight:UInt;
	private var componentWidth:UInt;

	private var horizontalMargin:UInt;

	private var textField:TextField;

	public function new(name:String="Saumya",h:Int=20,w:UInt=220) {
		super();
		this.maxColorValue = 256*256*256;
		this.buttonLabel = name;
		this.fontHeight = h;
		this.componentWidth = w;

		this.horizontalMargin = Math.round(this.fontHeight/10) ;

		this.textField = new TextField();
		//this.textField.addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
		
		construct();
	} //new
	private function construct():Void{
		
		//var font = Assets.getFont ("fonts/Archistico_Simple.ttf");
		var font = Assets.getFont ("fonts/OpenSans-Regular.ttf");

		var defaultFormat = new TextFormat (font.fontName, this.fontHeight, 0x000000);
		defaultFormat.align = TextFormatAlign.LEFT;
		// text
		//var t:TextField = new TextField();
		var t:TextField = this.textField;
		t.text = this.buttonLabel;
		
		// Either autosize or width
		//t.autoSize = TextFieldAutoSize.LEFT;
		t.autoSize = TextFieldAutoSize.NONE;
		t.width = componentWidth;

		t.type = TextFieldType.INPUT;
		//t.type = TextFieldType.DYNAMIC;
		
		t.height = fontHeight * (1.5);
		t.x = 0+this.horizontalMargin;
		t.y = -(this.fontHeight/10); // A little upward is actually makes it look in CENTER
		t.defaultTextFormat = defaultFormat;
		t.embedFonts = true;
		t.selectable = true;
		t.border = false;
		//t.maxChars = 10;
		//t.length = 10;
		t.multiline = false;
		


		this.drawBackground(t.width,t.height,this.horizontalMargin);
		this.addChild(t);
	}//construct
	private function drawBackground(w:Float,h:Float,margin:Float):Void{
		var widthX:Float = w + (2*margin);
		var g:Graphics = this.graphics;
		var c:UInt = Math.round(Math.random()*this.maxColorValue);
		g.beginFill(c,0.5);
		g.drawRect(0,0,widthX,h);
		g.endFill();

		drawUnderline(widthX,h);
	}//drawBackground
	private function drawUnderline(widthX:Float,h:Float){
		var g:Graphics = this.graphics;
		var yH:Float = (h-2);
		g.lineStyle(1,0x000000,1.0);
		g.moveTo(0,yH);
		g.lineTo(widthX,yH);
	}

	private function onAddedToStage(e:Event){
		trace("TextInputWithRandomColor:onAddedToStage:");
		trace(this.textField.length);

		this.textField.width = this.textField.length;
	}//onAddedToStage
}