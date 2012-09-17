package{
	
	import co.uk.bdoran.AMP.AMP;
	import co.uk.bdoran.AMP.AMPEvent;
	
	import commands.GetPlayers;
	import commands.Introduce;
	import commands.NewPlayer;
	import commands.PlayerLeft;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Main extends Sprite{
		
		private var amp:AMP;
		private var me : Player;
		private var players : Array;
		
		public function Main(){
			me = new Player( "Ben" );
			this.addChild( me );
			me.x = randRange( 0, 500 );
			me.y = randRange( 0, 500 );
			players = new Array();
			
			amp = new AMP( "127.0.0.1", 6000 );
			amp.addEventListener( AMPEvent.AMP_CONNECTED, ampConnectedHandler ); 
		}
		
		protected function ampConnectedHandler( event:AMPEvent ) : void {
			//Set up some commmands
			amp.setResponder( NewPlayer, newPlayer );	
			amp.setResponder( PlayerLeft, playerLeft );	
			
			//Introduce the player to the server
			amp.callRemote( Introduce, { name: me.name, x : me.position.x, y : me.position.y }, function( object : Object ) : void{
				me.id = object.id;
				trace("Registed with server, got player ID:", me.id );
			});
			
			//Call to recieve all current players
			amp.callRemote( GetPlayers, null );
		}
		
		protected function newPlayer( object : Object ) : void{
			trace("A new player has entered:", object.player );
			var newPlayer : Player = new Player( object.player );
			newPlayer.id = object.player;
			newPlayer.x = randRange( 0, 500 );
			newPlayer.y = randRange( 0, 500 );
			this.addChild( newPlayer );
			players.push( newPlayer );
		}
		
		protected function playerLeft( object : Object ) : void{
			trace("A new player has left:", object.player );
			for each( var player : Player in this.players ){
				if( player.id == object.player ){
					if( this.contains( player ) ){
						this.removeChild( player );
					}
				}
			}
		}
		
		private function randRange(minNum:Number, maxNum:Number):Number {
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
	}
}