package ghostcat.operation.effect
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	import ghostcat.operation.TweenOper;
	import ghostcat.parse.display.DrawParse;
	
	/**
	 * 缓存位图并从一个固定位置缩放，类似操作系统任务栏的展开效果 
	 * @author flashyiyi
	 * 
	 */
	public class ZoomFromRectEffect extends TweenOper
	{
		private var sourceTarget:*;
		private var bitmap:Bitmap;
		
		public override function get target() : *
		{
			return sourceTarget;
		}
		
		public override function set target(v:*) : void
		{
			sourceTarget = v;
		}
		
		public function ZoomFromRectEffect(target:*=null, rect:Rectangle=null, duration:int=100, easing:Function = null, invert:Boolean=true)
		{
			this.bitmap = new Bitmap();
			this.target = target;
			
			super(bitmap, duration, {x:rect.x,y:rect.y,width:rect.width,height:rect.height,ease:easing}, invert);
		}
		
		public override function execute() : void
		{
			//缩放时缓存位图
			var temp:Bitmap = new DrawParse(sourceTarget).createBitmap();
			this.bitmap.x = temp.x;
			this.bitmap.y = temp.y;
			this.bitmap.bitmapData = temp.bitmapData;
			this.sourceTarget.visible = false;
			
			(this.sourceTarget as DisplayObject).parent.addChild(bitmap);
			
			super.execute();
			
		}
		
		public override function result(event:*=null) : void
		{
			(this.sourceTarget as DisplayObject).parent.removeChild(bitmap);
			this.bitmap.bitmapData.dispose();
			this.bitmap.bitmapData = null;
			this.sourceTarget.visible = true;
			
			super.result(event);
		}
	}
}