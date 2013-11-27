package utilities;

import java.net.DatagramPacket;

import org.apache.log4j.Logger;

import patterns.CommunicationPattern;

import universe.*;



public class Session {
	Logger logger = Logger.getLogger(Session.class);

	private static Session instance = null;

	private CommunicationThread comThread;
	private Conversation conversation;
	private CommunicationChannel channel;
	private Protocol protocol;
	protected Message message = new Message();
	private CommunicationJoinPointRegistry comJpReg;
	private ConnectionJoinPointRegistry conJpReg;

	public static Session getInstance()
	{
		if(instance == null)
			instance = new Session();		
		return instance;
	}


	private Session()
	{
		buildUniverse();
	}


	void buildUniverse()
	{
		comJpReg = new CommunicationJoinPointRegistry();
		conJpReg = new ConnectionJoinPointRegistry();
	}


	public void printMessage(){}


//	public void buildUnreliableMessageVisual(DatagramPacket _dataGramPacket, char _eventType, CommunicationPattern _pattern)
//	{		
//
//		message = new Message();
//		message.setType(_pattern.getMessageType());
//		message.setId(message.getId());
//		String string = new String(_dataGramPacket.getData(),0,_dataGramPacket.getLength());
//		message.setData(string.trim());
//		message.setId(message.getUUID());
//
//		CommunicationEvent cEvent;		
//		if(_eventType == 'S')
//		{
//			cEvent = new CommunicationSendEvent(getConversation());
//			message.setSendEvent(cEvent);
//		}
//		else
//		{
//			cEvent = new CommunicationReceiveEvent();
//			message.setReceiveEvent(cEvent);
//			Event sendEvent = getConversation().getEventForMessage(string,'S');
//			cEvent.setId(sendEvent.getId());
//		}
//
//		cEvent.setType(_eventType);
//		cEvent.setLocalTime(new Timestamp());		
//		cEvent.setMessage(message);				
//		cEvent.setConversation(getConversation());				
//		getConversation().addEvent(cEvent);
//		channel.addEvent(cEvent);
//		cEvent.setChannelOccurs(channel);
//		protocol.setName(_pattern.getReliabilityName());	
//		comThread.addEvent(cEvent);
//		cEvent.setCommThread(comThread);
//	}



	public Message getMessage() {
		return message;
	}

	public void setMessage(Message _message) {
		this.message = _message;
	}

	public Conversation getConversation() {
		return conversation;
	}


	public CommunicationJoinPointRegistry getUniverse() {
		return comJpReg;
	}


	public void setUniverse(CommunicationJoinPointRegistry _universe) {
		this.comJpReg = _universe;
	}


	public int getRand()
	{
		return (int) (Math.random()*1000000);
	}


	public ConnectionJoinPointRegistry getConUniverse() {
		return conJpReg;
	}


	public void setConUniverse(ConnectionJoinPointRegistry _conUniverse) {
		this.conJpReg = _conUniverse;
	}

}
