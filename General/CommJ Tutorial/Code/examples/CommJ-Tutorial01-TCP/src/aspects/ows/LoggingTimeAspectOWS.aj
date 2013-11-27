package aspects.ows;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import joinpoints.communication.RequestReplyConversationJP;
import joinpoints.communication.SendEventJP;

import org.apache.log4j.Logger;

import utilities.Encoder;
import utilities.Message;
import baseaspects.communication.OneWaySendAspect;

public aspect LoggingTimeAspectOWS extends OneWaySendAspect{
		private Logger logger = Logger.getLogger(LoggingTimeAspectOWS.class);			

		Object around(SendEventJP _sendEventJp): ConversationBegin(_sendEventJp){
			String sendTime = getCurrentTime();
	     	Message msg =  (Message)Encoder.decode(_sendEventJp.getBytes());
	     	String logString = "OneWaySend: Sender: "+getTargetClass() + " - Message "+ msg.getClass().getSimpleName() + " [ID = " +_sendEventJp.getConversation().getId().toString()+"] at time "+ sendTime;
			logger.debug(logString);		
			System.out.println(logString);
	     	return proceed(_sendEventJp);
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

				

