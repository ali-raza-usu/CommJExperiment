package connection;
import joinpoints.connection.ChannelJP;
import org.apache.log4j.Logger;
import baseaspects.connection.CompleteConnectionAspect;


public aspect ListenerTimeAspect extends CompleteConnectionAspect{
	Logger logger = Logger.getLogger(ListenerTimeAspect.class);
	
	private	long startTime = 0;	
	static String timingInfo = "";
	
	Object around(ChannelJP _channelJp): ConversationBeginOnListener(_channelJp)
	{					
     	//startTime = System.currentTimeMillis();	
       	return proceed(_channelJp);
	}
	
	Object around(ChannelJP _channelJp): ConversationEndOnListener(_channelJp)
	{	
		//String Time  = String.format("%.3g%n",new Double(System.currentTimeMillis() - startTime)/1000);		
		//timingInfo = " Total Time of listener " +thisJoinPointStaticPart.getSignature().getName()+" localEP " + _channelJp.getConnectJp().getLocalEP()+ " turn-around time (nano seconds) : " + Time +"\n";		
		//logger.debug(timingInfo);
		return proceed(_channelJp);
	}
}
