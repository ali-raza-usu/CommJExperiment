package aspects.owr;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import joinpoints.communication.ReceiveEventJP;
import joinpoints.communication.RequestReplyConversationJP;
import joinpoints.communication.SendEventJP;

import org.apache.log4j.Logger;

import utilities.Encoder;
import utilities.Message;
import baseaspects.communication.OneWayReceiveAspect;
import baseaspects.communication.OneWaySendAspect;

public aspect LoggingTimeAspectOWR extends OneWayReceiveAspect{
		private Logger logger = Logger.getLogger(LoggingTimeAspectOWR.class);			

		Object around(ReceiveEventJP _receiveEventJp): ConversationEnd(_receiveEventJp){
			String sendTime = getCurrentTime();
	     	Message msg =  (Message)Encoder.decode(_receiveEventJp.getBytes());
	     	String logString = "Receiver: "+getTargetClass() + " - Message "+ msg.getClass().getSimpleName() + " [ID = " +_receiveEventJp.getConversation().getId().toString()+"] at time "+ sendTime;
			logger.debug(logString);		
			System.out.println(logString);
	     	return proceed(_receiveEventJp);
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

				

