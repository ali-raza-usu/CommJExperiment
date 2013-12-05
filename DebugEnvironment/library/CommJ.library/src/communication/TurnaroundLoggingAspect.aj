package communication;
import joinpoints.communication.RequestReplyConversationJP;

import org.apache.log4j.Logger;

import baseaspects.communication.RRConversationAspect;
import utilities.Encoder;

public aspect TurnaroundLoggingAspect  extends RRConversationAspect{
	private Logger logger = Logger.getLogger(TurnaroundLoggingAspect.class);		
	private	long startTime = 0;	
	private String messageName = "";
	private static String timingInfo = "";
	
	Object around(RequestReplyConversationJP _requestReplyJp): ConversationBegin(_requestReplyJp){				
		logger.debug("TurnaroundLoggingAspect : ConversationBegin(rrjp)");
     	startTime = System.currentTimeMillis();	
     	return proceed(_requestReplyJp);
	}
	
	Object around(RequestReplyConversationJP _requestReplyJp): ConversationEnd(_requestReplyJp){	
		logger.debug("TurnaroundLoggingAspect : ConversationEnd(rrjp)");
		String Time  = String.format("%.3g%n",new Double(System.currentTimeMillis() - startTime)/1000);
		messageName = Encoder.decode(_requestReplyJp.getSendJp().getBytes()).getClass().getName();
		String initiator = _requestReplyJp.getSendJp().getChannelJp().getConnectJp().getLocalEP().toString();
		String Receiver = _requestReplyJp.getReceiveJp().getChannelJp().getConnectJp().getRemoteEP().toString();
		timingInfo = " Total Time for message " + messageName +" is "+thisJoinPointStaticPart.getSignature().getName()+" turn-around time (nano seconds) : " + Time +
		" initiator " + initiator + " receiver " + Receiver;
		logger.debug(timingInfo);
		return proceed(_requestReplyJp);
	}

}

			


