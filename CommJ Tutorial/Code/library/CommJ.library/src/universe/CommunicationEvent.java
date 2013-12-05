package universe;
import java.util.*;

public class CommunicationEvent extends Event{
	
	public CommunicationEvent()
	{
		super();
	}
	private Conversation conversation;
	
	private CommunicationChannel channelOccurs = new CommunicationChannel();
	private Message message;
	
	public Conversation getConversation() {
		return conversation;
	}

	public void setConversation(Conversation _conversation) {
		this.conversation = _conversation;
	}

	public CommunicationChannel getChannelOccurs() {
		return channelOccurs;
	}

	public void setChannelOccurs(CommunicationChannel _channelOccurs) {
		this.channelOccurs = _channelOccurs;
	}

	public Message getMessage() {
		return message;
	}

	public void setMessage(Message _message) {
		this.message = _message;
	}

	public boolean occursOn(CommunicationChannel _communicationChannel) {
		// TODO Auto-generated method stub
		return false;
	}

	public boolean involves(Message _message) {
		// TODO Auto-generated method stub
		return false;
	}


}
