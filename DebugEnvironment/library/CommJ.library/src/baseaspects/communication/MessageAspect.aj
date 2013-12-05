package baseaspects.communication;
import joinpointracker.*;
import joinpoints.communication.ReceiveEventJP;
import joinpoints.communication.SendEventJP;

public abstract aspect MessageAspect
{		   
	public pointcut MessageSend(SendEventJP _sendJp) : 
								within(MessageJoinPointTracker) && 
								execution(void MessageJoinPointTracker.SendJoinPoint(..)) && args(_sendJp);
	
	public pointcut MessageRecieve(ReceiveEventJP _receiveJp) : within(MessageJoinPointTracker) && 
								execution(void MessageJoinPointTracker.ReceiveJoinPoint(..)) && args(_receiveJp);
	
}


