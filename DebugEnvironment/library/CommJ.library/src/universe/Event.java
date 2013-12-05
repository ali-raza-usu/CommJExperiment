package universe;

import java.util.UUID;

public class Event  extends PrimaryObject{

	private CommunicationThread commThread = new CommunicationThread();
	private char type;
	private Timestamp minTime = new Timestamp();
	private Timestamp maxTime = new Timestamp();
	private Timestamp localTime = new Timestamp();
	private int id ;//
	
	public Event()
	{
	}
	public char getType() {
		return type;
	}
	public void setType(char type) {
		this.type = type;
	}
	
	public CommunicationThread getCommThread() {
		return commThread;
	}
	public void setCommThread(CommunicationThread commThread) {
		this.commThread = commThread;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Timestamp getMinTime() {
		return minTime;
	}
	public void setMinTime(Timestamp minTime) {
		this.minTime = minTime;
	}
	public Timestamp getMaxTime() {
		return maxTime;
	}
	public void setMaxTime(Timestamp maxTime) {
		this.maxTime = maxTime;
	}
	
	
	public boolean threadEventHappensBefore(Event e)
	{
		if(e.getCommThread().getThisThread().getId() == this.getCommThread().getThisThread().getId())
			if(e.getLocalTime().compareTo(this.getLocalTime()) > 0)
					return true;
		return false;
	}
	
	public Timestamp getLocalTime() {
		return localTime;
	}
	public void setLocalTime(Timestamp localTime) {
		this.localTime = localTime;
	}
}
