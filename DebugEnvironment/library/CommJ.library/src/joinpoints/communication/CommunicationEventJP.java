package joinpoints.communication;
import java.util.UUID;

import joinpoints.connection.ChannelJP;
import joinpoints.connection.ConnectEventJP;

import org.apache.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.reflect.SourceLocation;

import universe.Conversation;
import universe.MessageType;
import universe.ProtocolRole;
import universe.Protocol;
import universe.Role;


public class CommunicationEventJP{

	Logger logger = Logger.getLogger(CommunicationEventJP.class);
	private Conversation conversation;
	private Protocol protocol;
	private MessageType messageType;	
	private Role role;
	private byte[] bytes;
	private ChannelJP channelJp = null;
	private ProtocolRole protocolRole = null;
	public CommunicationEventJP()
	{}

	
	public CommunicationEventJP(Conversation _conversation,
			Protocol _protocol, MessageType _messageType, byte[] _bytes,
			ChannelJP _channelJP) {
		super();
		this.conversation = _conversation;
		this.protocol = _protocol;
		this.messageType = _messageType;
		this.bytes = _bytes;
		this.channelJp = _channelJP;		
		setProtocolRole(new ProtocolRole(_protocol, role));
		
	}


	public CommunicationEventJP(CommunicationEventJP _comJp) {
		super();
		this.conversation = _comJp.getConversation();
		this.protocol = _comJp.getProtocol();
		this.role = _comJp.getRole();
		this.messageType = _comJp.getMessageType();
		this.bytes = _comJp.getBytes();
		this.channelJp = _comJp.getChannelJp();
		this.protocolRole = _comJp.getProtocolRole();
		this.bytes = _comJp.getBytes();
	}



	public void set(CommunicationEventJP _comJp) {		
		
		this.messageType = _comJp.getMessageType();	
	}
	
	public Conversation getConversation() {
		return conversation;
	}

	public void setConversation(Conversation _conversation) {		
		this.conversation = _conversation;
	}

	public MessageType getMessageType() {
		return messageType;
	}

	public void setMessageType(MessageType _messageType) {
		this.messageType = _messageType;
	}

	public byte[] getBytes() {
		return bytes;
	}

	public void setBytes(byte[] _bytes) {
		this.bytes = _bytes;
		
	}

	public ChannelJP getChannelJp() {
		return channelJp;
	}

	public void setChannelJp(ChannelJP _channelJP) {
		this.channelJp = _channelJP;
	}

	public Protocol getProtocol() {
		return protocol;
	}

	public void setProtocol(Protocol _protocol) {
		this.protocol = _protocol;
	}


	public Role getRole() {
		return role;
	}


	public void setRole(Role _role) {
		this.role = _role;
	}


	public ProtocolRole getProtocolRole() {
		return protocolRole;
	}


	public void setProtocolRole(ProtocolRole _protocolRole) {
		this.protocolRole = _protocolRole;
	}
}
