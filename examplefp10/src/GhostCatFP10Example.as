package 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	import ghostcat.community.physics.PhysicsItem;
	import ghostcat.community.physics.PhysicsManager;
	import ghostcat.community.physics.PhysicsUtil;
	import ghostcat.display.GBase;
	import ghostcat.display.bitmap.PixelItem;
	import ghostcat.display.residual.ResidualScreen;
	import ghostcat.util.display.ColorConvertUtil;
	
	[SWF(width="400",height="400",frameRate="60",backgroundColor="0xFFFFFF")]
	
	public class GhostCatFP10Example extends GBase
	{
		public var s:ResidualScreen;
		public var p:PhysicsManager;
		public var c:Number = 0;
		public var field:BitmapData = new BitmapData(200,200);
		
		public function GhostCatFP10Example()
		{
			//创建位图显示
			s = new ResidualScreen(200,200,false,0);
			s.scaleX = s.scaleY = 2;
			s.blurSpeed = 20;//扩散速度
//			s.fadeSpeed = 0.98;
			addChild(s);
			
			//创建物理
			p = new PhysicsManager(onTick);
			p.gravity = new Point(0,50);//重力
			
			this.refreshInterval = 5;
		}
		
		private function onTick(v:PhysicsItem,inv:int):void
		{
			//落下屏幕则删除
			if (v.y > 500)
			{
				s.removeObject(v.target);
				p.remove(v.target);
			}
		}
		
		protected override function updateDisplayList() : void
		{
//			field.perlinNoise(100,100,5,getTimer(),false,true,BitmapDataChannel.RED | BitmapDataChannel.GREEN);
//			PhysicsUtil.field(p,field);
			PhysicsUtil.attract2(p,new Point(s.mouseX,s.mouseY),10);
			
			c = (c < 0xFF) ? (c + 0.3) : 0;
			
			//新建点
			var item:PixelItem = new PixelItem(100,200,ColorConvertUtil.fromHSL(0xFF000000 + (c << 16) + 0xFF80));
			s.addObject(item);//加入显示
			p.add(item);//加入物理
			p.setVelocity(item,new Point((Math.random() - 0.5)*50,-100 + (Math.random() - 0.5)*20));//给予初速度
		}
	}
}