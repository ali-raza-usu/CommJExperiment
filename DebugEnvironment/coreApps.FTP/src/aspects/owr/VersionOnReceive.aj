package aspects.owr;


import joinpoints.communication.ReceiveEventJP;
//import joinpoints.communication.RequestReplyConversationJP;
//import joinpoints.communication.SendEventJP;

import org.apache.log4j.Logger;

import utilities.Encoder;
import utilities.Message;
import baseaspects.communication.OneWayReceiveAspect;
//import baseaspects.communication.OneWaySendAspect;


public aspect VersionOnReceive extends OneWayReceiveAspect{
	private Logger logger = Logger.getLogger(VersionOnReceive.class);
	
	after (ReceiveEventJP _receiveEventJp): ConversationEnd(_receiveEventJp){
		//System.out.println(" received bytes are " + " bytes size : "+ _receiveEventJp.getBytes().length);		
		Message msg =  (Message)Encoder.decode(_receiveEventJp.getBytes());
     	if(msg !=null)
     	{
     		String logString = "OneWayReceive: Receiver: "+getTargetClass() + " - Message "+ msg.getClass().getSimpleName() + " [ID = " +_receiveEventJp.getConversation().getId().toString();

     		logger.debug(getTargetClass() +"Message is "+ msg.getVersion());
     		
     		if(getTargetClass().equals("FTPClient"))
     		{
     			logString+="\n"+" The expected version is: 1.0"+ "\n"+"The actual version is:"+msg.getVersion()+ "ID"+ msg.getMessageId()
     					+ "Response ID"+ msg.getResponseId();
     		}
     		else if(getTargetClass().equals("FTPServer"))
     		{
     			logString+="\n"+" The expected version is: 0.0"+ "\n"+"The actual version is:"+msg.getVersion() + "ID"+ msg.getMessageId()
     					+ "Response ID"+ msg.getResponseId();
     		}
         	logger.debug(logString);		
    		//System.out.println(logString);
     	}
		 	

	}
	
	public static String getTargetClass() {
		StackTraceElement[] elements = Thread.currentThread().getStackTrace();
		String[] classes = elements[elements.length - 1].getClassName().split("\\.");
		return classes[classes.length - 1];
	}

}
