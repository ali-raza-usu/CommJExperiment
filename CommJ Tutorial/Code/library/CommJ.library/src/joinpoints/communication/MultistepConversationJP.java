package joinpoints.communication;

import universe.Conversation;
import universe.MessageType;
import universe.Protocol;
import utilities.TimeSpan;
import utilities.statemachine.StateMachine;

public class MultistepConversationJP extends CommunicationEventJP
{
	private int messageId;
	private StateMachine stateMachine = null;		
	private byte[] bytes;
	
	public MultistepConversationJP() {
		 super.setConversation(getConversation());	
	}

	 public MultistepConversationJP(int _messageId, Conversation _conversation, Protocol _protocol, MessageType _messageType, byte[] _data, StateMachine _stateMachine) {
		this.messageId = _messageId;			
		super.setConversation(_conversation);
		super.setProtocol(_protocol);
		this.setMessageType(_messageType);
		setStateMachine(_stateMachine);
		this.bytes = _data;
	}

	 
	 public MultistepConversationJP(CommunicationEventJP _comJp)
	 {
		 super(_comJp);
		 this.bytes = _comJp.getBytes();
	 }
	public int getMessageId() {
		return messageId;
	}

	public void setMessageId(int _messageId) {
		this.messageId = _messageId;
	}

	@Override
	public void setBytes(byte[] _bytes)
	{
		super.setBytes(_bytes);
	}	

	public byte[] getMessageBytes() {
		return bytes;
	}

	public void setMessageBytes(byte[] _bytes) {
		this.bytes = _bytes;
	}
	
	public TimeSpan DeltaTime()
	{
		return null;		
	}

	public StateMachine getStateMachine() {
		return stateMachine;
	}

	public void setStateMachine(StateMachine _stateMachine) {
		this.stateMachine = _stateMachine;
	}
}
