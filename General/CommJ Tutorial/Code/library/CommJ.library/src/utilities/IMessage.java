package utilities;
import universe.Conversation;
import universe.MessageType;
import universe.Protocol;
import universe.Role;



public interface IMessage {

	public Protocol getProtocol();
	public void setProtocol(Protocol protocol);
	public Conversation getConversation();
	public void setConversation(Conversation conversation);
	public Role getRole();
	public void setRole(Role role);
	public Object getMessageId();
	public MessageType getMessageType();
	public Object getResponseId();
	public String toString();
	public void setMessage(IMessage msg);
}

