package joinpoints.communication;

import java.net.Socket;
import java.util.UUID;

import org.aspectj.lang.JoinPoint;

import universe.Conversation;
import universe.MessageType;
import universe.Protocol;

public class SendEventJP extends CommunicationEventJP {
	
	public SendEventJP(){}
	
	public SendEventJP(Protocol _protocol, Conversation _conversation, MessageType _messageType)	
	{
		setProtocol(_protocol);
		setConversation(_conversation);
		setMessageType(_messageType);		
	}
	
	private JoinPoint sendJP;	
	private Socket socket = null;

	public JoinPoint getJp() {
		return sendJP;
	}
	
	public void setJp(JoinPoint _sendJP) {
		this.sendJP = _sendJP;
	}

	
	
	public void setBytes(byte[] _bytes)
	{
		super.setBytes(_bytes);	
	}

	public Socket getSocket() {
		return socket;
	}

	public void setSocket(Socket _socket) {
		this.socket = _socket;
	}

	
}
