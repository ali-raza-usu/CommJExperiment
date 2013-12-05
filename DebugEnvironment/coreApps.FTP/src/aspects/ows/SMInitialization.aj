package aspects.ows;
import org.apache.log4j.Logger;

import application.FTPClient;
import application.FTPServer;

public aspect SMInitialization extends baseaspects.communication.Initialization {
	Logger logger = Logger.getLogger(SMInitialization.class);

	@Override
	public void defineMappng() {
		// TODO Auto-generated method stub
		
	}

}
 