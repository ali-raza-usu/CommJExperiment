package communication;

import joinpoints.communication.MultistepConversationJP;
import joinpoints.communication.RequestReplyConversationJP;
import org.apache.log4j.Logger;
import baseaspects.communication.MultistepConversationAspect;
import utilities.Encoder;




public aspect TurnaroundMLLoggingAspect  extends MultistepConversationAspect{
	
	private Logger logger = Logger.getLogger(TurnaroundMLLoggingAspect.class);
		
	private	long startTime = 0;	
	static String timingInfo = "";
	
	before(MultistepConversationJP _multiStepJP): ConversationBegin(_multiStepJP){				
     	startTime = System.currentTimeMillis();	     	
	}
	
	after(MultistepConversationJP _multiStepJP): ConversationEnd(_multiStepJP){	
		String Time  = String.format("%.3g%n",new Double(System.currentTimeMillis() - startTime)/1000);		
		timingInfo = " Total Time for Multistep conversation is  turn-around ML time (nano seconds) : " + Time;				
		logger.debug(timingInfo);
	}

}

			


