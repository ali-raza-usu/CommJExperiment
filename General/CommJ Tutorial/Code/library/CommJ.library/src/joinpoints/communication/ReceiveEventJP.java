package joinpoints.communication;

import java.net.Socket;
import java.util.UUID;

import org.aspectj.lang.JoinPoint;

import universe.Conversation;
import universe.MessageType;
import universe.Protocol;

public class ReceiveEventJP extends CommunicationEventJP {

	private Socket socket;
	private int messageId;

	private JoinPoint receiveJP;
	

	
	public ReceiveEventJP(Protocol _protocol, Conversation _conversation, MessageType _msgType)	
	{
		setProtocol(_protocol);
		setConversation(_conversation);
		setMessageType(_msgType);		
	}
	
	public ReceiveEventJP() {
	}

	public JoinPoint getJp() {
		return receiveJP;
	}
	
	public void setJp(JoinPoint _receiveJP) {
		this.receiveJP = _receiveJP;
	}
	
	public Socket getSocket() {
		return socket;
	}

	public void setSocket(Socket _socket) {
		socket = _socket;
	}
	
	public void setBytes(byte[] _bytes)
	{
		super.setBytes(_bytes);
	}
}
