package commands
{
	import co.uk.bdoran.AMP.AmpCommand;
	
	public class NewPlayer extends AmpCommand{
		
		public function NewPlayer(){
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