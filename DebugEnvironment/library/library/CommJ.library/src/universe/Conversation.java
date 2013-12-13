package universe;

import java.io.Serializable;
import java.util.*;

import utilities.statemachine.State;
import utilities.statemachine.StateMachine;

public class Conversation implements Serializable{

	private static final long serialVersionUID = 1L;
	private UUID id;
	private List<CommunicationEvent> events = new ArrayList<CommunicationEvent>();
	private int counter = 0;
	private boolean inOrderRecieve = true;
	private State currentState = null;
	private Protocol followsAProtocol =new Protocol(); 
	
	public Conversation(){	
		id = UUID.randomUUID();		
	}
	
	public Conversation(State _currentState){
		super();
		this.currentState = _currentState;
	}

	public Conversation(UUID _id)
	{
		this.setId(_id);		
	}

	public boolean isInFinalState(){
		return getCurrentState().isFinal();			
	}

	public boolean isInInitialState(){
		return getCurrentState().isInitial();			
	}

	
	public UUID getId(){
		return id;
	}

	public void setId(UUID _id) {
		this.id = _id;
	}
	public Protocol getFollowsAProtocol() {
		return followsAProtocol;
	}
	public void setFollowsAProtocol(Protocol _followsAProtocol) {
		this.followsAProtocol = _followsAProtocol;
	}
	public List<CommunicationEvent> getEvents() {
		return events;
	}
	public void setEvents(List<CommunicationEvent> _events) {
		this.events = _events;
	}
	
	public void addEvent(CommunicationEvent _event){		
		events.add(_event);
	}
	
	public void removeEvent(CommunicationEvent _event){
		events.remove(_event);
	}
	public int getEventId(){
		return counter++; 
	}
	public boolean isInOrderRecieve() {
		return inOrderRecieve;
	}
	public void setInOrderRecieve(boolean _inOrderRecieve) {
		this.inOrderRecieve = _inOrderRecieve;
	}
	
	
	public Event getEventForMessage(String _data, char _type){
		synchronized(events){
			for(CommunicationEvent event : events){
				if(event.getMessage().getData().toString().equals(_data) && event.getType()==_type)
					return event;
			}
		}
		return null;
		
	}
	public State getCurrentState() {
		return currentState;
	}
	public void setCurrentState(State _currentState) {
		this.currentState = _currentState;
	}
	
	@Override
	public boolean equals(Object _obj){
		Conversation tempConversation = (Conversation)_obj;
		if(tempConversation.getId().equals(this.getId()))
			return true;
		return false;
	}
}
