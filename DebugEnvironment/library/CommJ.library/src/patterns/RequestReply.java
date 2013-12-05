package patterns;

import universe.MessageType;

public class RequestReply extends CommunicationPattern{

	public RequestReply()
	{
		super();
	}
	
	public RequestReply(boolean isReliable, MessageType type)
	{
		super(isReliable, type);
	}
}
