package joinpoints.communication;

import java.net.DatagramPacket;
import java.util.UUID;

import org.aspectj.lang.JoinPoint;

import universe.Conversation;
import universe.MessageType;
import universe.Protocol;
import utilities.TimeSpan;




public class RequestReplyConversationJP extends CommunicationEventJP
{

    private SendEventJP sendJp;
	private ReceiveEventJP receiveJp;
	private int messageId; 
	private String data;
	private byte[] bytes;
	
	
	 public RequestReplyConversationJP() {
		 super.setConversation(getConversation());		
	}


		
	 public RequestReplyConversationJP(int _messageId, Protocol _protocol, Conversation _conversation, MessageType _messageType, byte[] _data) {
			this.messageId = _messageId;			
			super.setConversation(_conversation);
			super.setProtocol(_protocol);
			this.setMessageType(_messageType);
			this.data = new String(_data);
			this.bytes = _data;
	}
	 
	 
		public SendEventJP getSendJp() {
			return sendJp;
		}
		
		public ReceiveEventJP getReceiveJp() {
			return receiveJp;
		}
		
		
		
	public void setSendJp(SendEventJP _sendJp)
	{
		this.sendJp = _sendJp;
	}

	public void setRecieveJp(ReceiveEventJP _receiveJp)
	{	
		this.receiveJp = _receiveJp;
	}
	
	public int getMessageId() {
		return messageId;
	}

	public void setMessageId(int _messageId) {
		this.messageId = _messageId;
	}

	
	public void setData(String _data) {
	  data = _data;
	}
	
	public String getData() {		
		return data;
	}

	public byte[] getMessageBytes() {
		return bytes;
	}

	public void setMessageBytes(byte[] _bytes) {
		this.bytes = _bytes;
	}
	
	public TimeSpan getDeltaTime()
	{
		return null;		
	}

	
	
	
}
