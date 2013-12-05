package patterns;

import universe.MessageType;

public class Multistep extends CommunicationPattern{

	public Multistep()
	{
		super();
	}
	
	public Multistep(boolean isReliable, MessageType type)
	{
		super(isReliable, type);
	}
}
