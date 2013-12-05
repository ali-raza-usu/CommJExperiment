package patterns;

import universe.MessageType;

public class OneWayMulticast extends CommunicationPattern{

	public OneWayMulticast()
	{
		super();
	}
	
	public OneWayMulticast(boolean isReliable, MessageType type)
	{
		super(isReliable, type);
	}

}
