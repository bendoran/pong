package commands
{
	import co.uk.bdoran.AMP.AmpCommand;
	
	public class PlayerLeft extends AmpCommand{
		
		public function PlayerLeft(){
			this.args = { 
				player : AmpCommand.AMP_INTEGER
			};
			this.response = {
				success : AmpCommand.AMP_BOOLEAN
			};
			this.requiresAnswer = false;
		}
		
	}
}