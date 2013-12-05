package universe;

import java.beans.PropertyChangeEvent;
import java.util.Timer;
import java.util.TimerTask;
import java.util.UUID;

public class CommunicationSendEvent extends CommunicationEvent{

	private Timer timer;
	//Time would expire after the timestampPlusDelta
	//Task: to check whether the message it sent at this time has been received
	
	public CommunicationSendEvent(Conversation con)
	{
		super.setConversation(con);
		long expiryTime = getLocalTime().getDeltaTime();
		super.setId(getConversation().getEventId());
		//System.out.println(super.getId() + " id");
		setTimer(new Timer());
		timer.schedule(new Task(), expiryTime);
	}

	public Timer getTimer() {
		return timer;
	}

	public void setTimer(Timer timer) {
		this.timer = timer;
	}
	
	
	
	public class Task extends TimerTask {
		public void run(){		
			getMessage().isMessageLost();			
		}
	}
	

//	@Override
//	public void propertyChange(PropertyChangeEvent e) {
//		// TODO Auto-generated method stub
//		
//	}

	
}
