package baseaspects.communication;

import java.nio.ByteBuffer;

import joinpoints.communication.ReceiveEventJP;
import joinpoints.communication.SendEventJP;

import org.apache.log4j.Logger;

import universe.Conversation;
import utilities.Encoder;
import utilities.IMessageExt;


public abstract aspect OneWaySendAspect  extends MessageAspect{

private Logger logger = Logger.getLogger(OneWaySendAspect.class);
	
	public pointcut ConversationBegin(SendEventJP _sendEventJp) : execution(* OneWaySendAspect.Begin(..)) && args(_sendEventJp);

	void around(SendEventJP _sendJp) : MessageSend(_sendJp){
		if(_sendJp.getConversation() == null)
			_sendJp.setConversation(new Conversation());
		
			Begin(_sendJp);
	    	//IMessageExt ext = (IMessageExt) Encoder.decode(_sendJp.getBytes());
	    	//System.out.println("OWS " + ext.getVersion() );
			proceed(_sendJp);
	}


	public void Begin(SendEventJP _receiveJp){		
	}
}