package aspects.con.initiator;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import joinpoints.connection.ChannelJP;

import org.apache.log4j.Logger;

import utilities.Encoder;
import utilities.Message;
import baseaspects.connection.CompleteConnectionAspect;

public aspect LoggingInitiatorTime extends CompleteConnectionAspect{
	Logger logger = Logger.getLogger(LoggingInitiatorTime.class);
	
	private	long startTime = 0;	
	static String timingInfo = "";
	
	Object around(ChannelJP _channelJp): ConversationBeginOnInitiator(_channelJp)
	{					
		String sendTime = getCurrentTime();
     	String logString = "ConversationBeginOnInitiator: Initiator: "+getTargetClass() + " -  [ID = " +_channelJp.getConversation().getId().toString()+"] at time "+ sendTime;
		logger.debug(logString);		
		System.out.println(logString);
       	return proceed(_channelJp);
	}
	
	Object around(ChannelJP _channelJp): ConversationEndOnInitiator(_channelJp)
	{	
		String sendTime = getCurrentTime();
     	Message msg =  (Message)Encoder.decode(_channelJp.getBytes());
     	String logString = "ConversationEndOnInitiator: Initiator: "+getTargetClass() + " - [ID = " +_channelJp.getConversation().getId().toString()+"] at time "+ sendTime;
		logger.debug(logString);		
		System.out.println(logString);
		return proceed(_channelJp);
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

				

