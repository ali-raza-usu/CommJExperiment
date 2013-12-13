package baseaspects.communication;

import joinpoints.communication.ReceiveEventJP;
import joinpoints.communication.RequestReplyConversationJP;
import joinpoints.communication.SendEventJP;

import org.apache.log4j.Logger;

import universe.Conversation;
import utilities.Encoder;
import utilities.Session;

public abstract aspect OneWayReceiveAspect extends MessageAspect{

private Logger logger = Logger.getLogger(OneWayReceiveAspect.class);
	
	public pointcut ConversationEnd(ReceiveEventJP _receiveEventJp) : execution(* OneWayReceiveAspect.End(..)) && args(_receiveEventJp);
	

	void around(ReceiveEventJP _receiveJp) : MessageRecieve(_receiveJp){
		if(_receiveJp.getConversation() == null)
			_receiveJp.setConversation(new Conversation());
		End(_receiveJp);
		proceed(_receiveJp);
	}


	public void End(ReceiveEventJP _receiveJp){		

	}
}
