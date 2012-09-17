package
{
	import flash.display.Sprite;
	import flash.geom.Point;

	public class Player extends Sprite{
		
		public var playerName : String;
		public var position : Point = new Point( 0, 0 );
		public var id : int;
		
		public function Player( name : String ){
			this.name = name;
			this.draw();
		}
		
		private function draw() : void{
			this.graphics.beginFill( 0x00FF00 );
			this.graphics.beginFill( Math.random() * 0xFFFFFF );
			this.graphics.drawEllipse( 0, 0, 20, 20 );
			this.graphics.endFill();
		}
	}
}