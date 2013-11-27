package universe;
import java.util.*;

public class CommunicationThread  extends PrimaryObject implements Runnable{

	private List<Event> events = new ArrayList<Event>();
	private Thread thisThread;
	public CommunicationThread(){}
	public CommunicationThread(Thread t){
		setThisThread(new Thread());
	}
	public List<Event> getEvents() {
		return events;
	}

	public Timestamp getTimestamp(){
		return new Timestamp();
	}
	public void setEvents(List<Event> events) {
		this.events = events;	
	}
	
	
	public void addEvent(CommunicationEvent event){
		events.add(event);
	}
	
	public void removeEvent(CommunicationEvent event){
		events.remove(event);
	}
	
	public boolean contains(Event e) {
		return events.contains(e);
	}
	
	@Override
	public void run() {		
	}
	
	public Thread getThisThread() {
		return thisThread;
	}
	public void setThisThread(Thread thisThread) {
		this.thisThread = thisThread;
	}
	
}
