package patterns;

import universe.MessageType;

public class CommunicationPattern {

	private boolean isReliable;
	private MessageType messageType;
	
	public CommunicationPattern()
	{}
	
	public CommunicationPattern(boolean reliable, MessageType type)
	{
		isReliable = reliable;
		this.messageType = type;
	}
	
	public boolean isReliable() {
		return isReliable;
	}

	public void setReliable(boolean isReliable) {
		this.isReliable = isReliable;
	}

	public MessageType getMessageType() {
		return messageType;
	}

	public void setMessageType(MessageType messageType) {
		this.messageType = messageType;
	}
	
	public String getReliabilityName()
	{
		if(isReliable) 
			return "reliable";
		else
			return "Unreliable";
	}
}
