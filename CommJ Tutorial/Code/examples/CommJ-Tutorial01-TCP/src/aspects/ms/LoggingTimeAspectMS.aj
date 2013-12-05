package aspects.ms;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import joinpoints.communication.MultistepConversationJP;
import org.apache.log4j.Logger;
import utilities.Encoder;
import utilities.Message;
import baseaspects.communication.MultistepConversationAspect;

public aspect LoggingTimeAspectMS extends MultistepConversationAspect {

	private Logger logger = Logger.getLogger(LoggingTimeAspectMS.class);
	static String timingInfo = "";

	before(MultistepConversationJP _multiStepJP): ConversationBegin(_multiStepJP){
		String sendTime = getCurrentTime();
     	Message msg =  (Message)Encoder.decode(_multiStepJP.getBytes());
     	String logString = null;
     	if(_multiStepJP.getConversation() == null)
     		logString = "Multistep : MS Sender: "+getTargetClass() + " - Message "+ msg.getClass().getSimpleName() + " [ID = " +_multiStepJP.getConversation()+"] at time "+ sendTime;
     	else
     		logString = "Multistep: MS Sender: "+getTargetClass() + " - Message "+ msg.getClass().getSimpleName() + " [ID = " +_multiStepJP.getConversation().getId().toString()+"] at time "+ sendTime;
		logger.debug(logString);		
		System.out.println(logString);
	}

	after(MultistepConversationJP _multiStepJP): ConversationEnd(_multiStepJP){
		
		String endTime = getCurrentTime();	
     	Message msg =  (Message)Encoder.decode(_multiStepJP.getBytes());
     	String logString = " Multistep: MS Receiver: "+getTargetClass() + " - Message "+ msg.getClass().getSimpleName() + " [ID = " +_multiStepJP.getConversation().getId().toString()+"] at time "+ endTime;
		logger.debug(logString);		
		System.out.println(logString);
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
