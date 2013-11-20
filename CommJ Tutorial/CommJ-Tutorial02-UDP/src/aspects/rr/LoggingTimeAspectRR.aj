package aspects.rr;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import joinpoints.communication.RequestReplyConversationJP;
import org.apache.log4j.Logger;
import baseaspects.communication.RRConversationAspect;
import utilities.Encoder;
import utilities.Message;

public aspect LoggingTimeAspectRR  extends RRConversationAspect{
	private Logger logger = Logger.getLogger(LoggingTimeAspectRR.class);			

	Object around(RequestReplyConversationJP _requestReplyJp): ConversationBegin(_requestReplyJp){
		String sendTime = getCurrentTime();
     	Message msg =  (Message)Encoder.decode(_requestReplyJp.getSendJp().getBytes());
     	String logString = "Sender: "+getTargetClass() + " - Message "+ msg.getClass().getSimpleName() + " [ID = " +_requestReplyJp.getConversation().getId().toString()+"] at time "+ sendTime;
		logger.debug(logString);		
		System.out.println(logString);
     	return proceed(_requestReplyJp);
	}
	
	Object around(RequestReplyConversationJP _requestReplyJp): ConversationEnd(_requestReplyJp){	
		String endTime = getCurrentTime();	
     	Message msg =  (Message)Encoder.decode(_requestReplyJp.getSendJp().getBytes());
     	String logString = "Receiver: "+getTargetClass() + " - Message "+ msg.getClass().getSimpleName() + " [ID = " +_requestReplyJp.getConversation().getId().toString()+"] at time "+ endTime;
		logger.debug(logString);		
		System.out.println(logString);
		return proceed(_requestReplyJp);
	}
	
	
	private String getCurrentTime(){
		DateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
		Date date = new Date();
		return dateFormat.format(date);
	}
	
	public static String getTargetClass() {
		StackTraceElement[] elements = Thread.currentThread().getStackTrace();
		String[] classes = elements[elements.length - 1].getClassName().split("\\.");
		return classes[classes.length - 1];
	}
}

			


