package aspects.owr;
import org.apache.log4j.Logger;

import application.Client;
import application.Server;

public aspect SMInitialization extends baseaspects.communication.Initialization {
	Logger logger = Logger.getLogger(SMInitialization.class);

	@Override
	public void defineMappng() {
	}
}
 