
package com.saumya.components;

import openfl.display.Graphics;
import com.saumya.components.ButtonWithRandomColor;

class ButtonWithFixedWidth extends ButtonWithRandomColor {

	private var bgColor:UInt;
	private var maxWidth:Int;
	private var isAlignCenter:Bool;

	public function new(name:String="Saumya",iHeight:Int=20,iWidth:Int=200,backgroundColor:UInt=0xFFFFFF,? isCenterAlign:Bool=false) {
		this.bgColor = backgroundColor;
		this.maxWidth = iWidth;
		this.isAlignCenter = isCenterAlign;
		// last call
		super(name,iHeight);
	}
	override private function drawBackground(w:Float,h:Float,margin:Float):Void{
		//trace(this.bgColor);
		//super.drawBackground(w,h,margin);
		
		//var widthX:Float = w + (2*margin);
		var widthX:Float = maxWidth;

		var g:Graphics = this.graphics;
		//var c:UInt = Math.round(Math.random()*this.maxColorValue);
		var c:UInt = this.bgColor;
		g.beginFill(c,1.0);
		g.drawRect(0,0,widthX,h);
		g.endFill();
		// center align
		if(isAlignCenter){
			this.textField.x = (widthX - w)/2;
		}
		
	}
}