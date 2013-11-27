package connection;
import joinpoints.connection.ChannelJP;
import org.apache.log4j.Logger;
import baseaspects.connection.CompleteConnectionAspect;

public aspect InitiatorTimeAspect extends CompleteConnectionAspect{
	Logger logger = Logger.getLogger(InitiatorTimeAspect.class);
	
	private	long startTime = 0;	
	static String timingInfo = "";
	
	before(ChannelJP _channelJp): ConversationBeginOnInitiator(_channelJp){							
     	//startTime = System.currentTimeMillis();	     	
	}
	
	after(ChannelJP _channelJp): ConversationEndOnInitiator(_channelJp){	
		//String Time  = String.format("%.3g%n",new Double(System.currentTimeMillis() - startTime)/1000);			
		//timingInfo = " Total Time of initator " +thisJoinPointStaticPart.getSignature().getName()+" localEP " + 
			//	_channelJp.getConnectJp().getLocalEP()+ " turn-around time (nano seconds) : " + Time +"\n";		
		//logger.debug(timingInfo);		
	}
}

