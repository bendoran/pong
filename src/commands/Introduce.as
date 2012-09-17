package commands
{
	import co.uk.bdoran.AMP.AmpCommand;
	
	public class Introduce extends AmpCommand{
		
		public function Introduce(){
			this.args = { 
				name : AmpCommand.AMP_STRING,
				x : AmpCommand.AMP_INTEGER,
				y : AmpCommand.AMP_INTEGER
			};
			this.response = {
				playerId : AmpCommand.AMP_INTEGER
			};
		}
		
	}
}