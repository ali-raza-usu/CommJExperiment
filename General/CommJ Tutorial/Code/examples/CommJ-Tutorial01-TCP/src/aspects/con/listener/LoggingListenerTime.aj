package aspects.con.listener;


import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import joinpoints.communication.ReceiveEventJP;
import joinpoints.communication.RequestReplyConversationJP;
import joinpoints.communication.SendEventJP;
import joinpoints.connection.ChannelJP;

import org.apache.log4j.Logger;

import utilities.Encoder;
import utilities.Message;
import baseaspects.communication.OneWayReceiveAspect;
import baseaspects.communication.OneWaySendAspect;
import baseaspects.connection.CompleteConnectionAspect;

public aspect LoggingListenerTime extends CompleteConnectionAspect{
	Logger logger = Logger.getLogger(LoggingListenerTime.class);
	
	private	long startTime = 0;	
	static String timingInfo = "";
	
	Object around(ChannelJP _channelJp): ConversationBeginOnListener(_channelJp)
	{					
		String sendTime = getCurrentTime();
     	String logString = "ConversationBeginOnListener: Listener: "+getTargetClass() + " -  [ID = " +_channelJp.getConversation().getId().toString()+"] at time "+ sendTime;
		logger.debug(logString);		
		System.out.println(logString);
       	return proceed(_channelJp);
	}
	
	Object around(ChannelJP _channelJp): ConversationEndOnListener(_channelJp)
	{	
		String sendTime = getCurrentTime();
     	Message msg =  (Message)Encoder.decode(_channelJp.getBytes());
     	String logString = "ConversationBeginOnListener: Listener: "+getTargetClass() + " - [ID = " +_channelJp.getConversation().getId().toString()+"] at time "+ sendTime;
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

				

