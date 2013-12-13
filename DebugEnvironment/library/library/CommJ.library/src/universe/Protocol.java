package universe;

import java.io.Serializable;
import java.util.*;


public class Protocol implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public Protocol(UUID _protocolId) {
		super();
		this.protocolId = _protocolId;
	}

	private UUID protocolId = null;
	private List<Conversation> conversations = new ArrayList<Conversation>();

	private String name = "";
	
	public Protocol(String _name) {
		super();
		protocolId = UUID.randomUUID();
		this.name = _name;
	}

	public Protocol() {
		super();
	}

	public List<Conversation> getConversations() {
		return conversations;
	}

	public void setConversations(List<Conversation> _conversations) {
		this.conversations = _conversations;
	}
	
	public void addConversation(Conversation _conversation)
	{
		conversations.add(_conversation);
	}
	
	public void removeEvent(Conversation _conversation)
	{
		conversations.remove(_conversation);
	}

	public String getName() {
		return name;
	}

	public void setName(String _name) {
		this.name = _name;
	}

	public UUID getProtocolId() {
		return protocolId;
	}

	public void setProtocolId(UUID _protocolId) {
		this.protocolId = _protocolId;
	}
}
