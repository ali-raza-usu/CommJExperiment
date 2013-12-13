package aspects;

import org.apache.log4j.Logger;
import application.FTPClient;

public aspect SMInitialization extends baseaspects.communication.Initialization {
	Logger logger = Logger.getLogger(SMInitialization.class);

	@Override
	public void defineMappng() {
		addMapping(FTPClient.class, Client_SM.class);
	}
}
 