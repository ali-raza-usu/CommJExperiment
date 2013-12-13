package universe;

import java.util.UUID;



public class Message extends PrimaryObject implements Cloneable{

	private UUID id = UUID.randomUUID();
	private MessageType type;
	private Object data = new Object();
	private CommunicationEvent sendEvent  = null;
	private CommunicationEvent receiveEvent  = null;
	
	public Message()
	{}
	
	public UUID getUUID()
	{
		return UUID.randomUUID();
	}
	
	public Message(UUID _id, MessageType _type)
	{
		this.setId(_id);
		this.setType(_type);		
	}


	public UUID getId()
	{
		return id;
	}

	public void setId(UUID _id) {
		this.id = _id;
	}

	public MessageType getType() {
		return type;
	}

	public void setType(MessageType _type) {
		this.type = _type;
	}

	public Object getData() {
		return data;
	}

	public void setData(Object _data) {
		this.data = _data;
	}

	
	public CommunicationEvent getReceiveEvent() {		
		return receiveEvent;
	}

	public void setReceiveEvent(CommunicationEvent _receiveEvent) {
		if((sendEvent!=null && _receiveEvent !=null )&& sendEvent.getLocalTime().compareTo(_receiveEvent.getLocalTime())> 0)
			this.receiveEvent = _receiveEvent;
	}

	public CommunicationEvent getSendEvent() {
		return sendEvent;
	}

	public void setSendEvent(CommunicationEvent _sendEvent) {
		this.sendEvent = _sendEvent;
	}
	
	boolean isMessageLost()
	{		
		return (getReceiveEvent() == null);
	}
	
	public Object clone()
    {
        try
    {
            return super.clone();
        }
    catch( CloneNotSupportedException e )
    {
            return null;
        }
    } 
}
