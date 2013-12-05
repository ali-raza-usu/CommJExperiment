package universe;

import java.util.*;

public class CommunicationChannel {

	private List<CommunicationEvent> commEvents = new ArrayList<CommunicationEvent>();
	private String name ="";
	

	public List<CommunicationEvent> getCommEvents() {
		return commEvents;
	}

	public void setCommEvents(List<CommunicationEvent> _commEvents) {	
		this.commEvents = _commEvents;
	}
	
	public void addEvent(CommunicationEvent _event)
	{
		
		commEvents.add(_event);
	}
	
	public void removeEvent(CommunicationEvent _event)
	{
		commEvents.remove(_event);
	}

	public String getName() {
		return name;
	}

	public void setName(String _name) {
		this.name = _name;
	}

	
}
