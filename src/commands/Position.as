package commands
{
	import co.uk.bdoran.AMP.AmpCommand;
	
	public class Position extends AmpCommand{
		
		public function Position(){
			this.args = { 
				x : AmpCommand.AMP_INTEGER,
				y : AmpCommand.AMP_INTEGER
			};
			this.response = {
				success : AmpCommand.AMP_BOOLEAN
			};
			this.requiresAnswer = false;
		}
		
	}
}