package baseaspects.communication;

import org.apache.log4j.Logger;

import baseaspects.communication.Initialization;

public aspect CommJInitialization extends Initialization {
	Logger logger = Logger.getLogger(CommJInitialization.class);

	@Override
	public void defineMappng() {
	}
}
