
package baseaspects.communication;
import joinpoints.communication.*;

import org.apache.log4j.Logger;

import baseaspects.communication.MessageAspect;

import universe.Conversation;
import utilities.CommunicationJoinPointRegistry;
import utilities.Encoder;
import utilities.Session;
import utilities.TimeSpan;

public abstract aspect RRConversationAspect extends MessageAspect{
	
	private Logger logger = Logger.getLogger(RRConversationAspect.class);
	
	public pointcut ConversationBegin(RequestReplyConversationJP _requestReplyJp) : execution(* RRConversationAspect.Begin(RequestReplyConversationJP)) && args(_requestReplyJp);
	public pointcut ConversationStart(RequestReplyConversationJP _requestReplyJp, TimeSpan _timeout) : execution(* RRConversationAspect.Begin(RequestReplyConversationJP, TimeSpan)) && args(_requestReplyJp, _timeout);
	public pointcut ConversationEnd(RequestReplyConversationJP _requestReplyJp) : execution(* RRConversationAspect.End(..)) && args(_requestReplyJp);
	public pointcut ConverationTimeOut(RequestReplyConversationJP _requestReplyJp) : execution(* RRConversationAspect.Timeout(..)) && args(_requestReplyJp);
	private Conversation currentConversation = null;
	void around(SendEventJP _sendJp) : MessageSend(_sendJp){
		//logger.debug("Received from MessageSend RR Conversation ");
		RequestReplyConversationJP requestReplyJp = new  RequestReplyConversationJP();
		requestReplyJp.setSendJp(_sendJp);	
		
		if (_sendJp!= null && _sendJp.getConversation() == null){
			if(currentConversation == null)
				currentConversation =  new Conversation();
			_sendJp.setConversation(currentConversation);
		}else{
			currentConversation = _sendJp.getConversation();
		}
		
		if(_sendJp.getConversation()!= null)
		requestReplyJp.setConversation(_sendJp.getConversation());
					
		if(Session.getInstance().getUniverse().findByConversation(requestReplyJp.getConversation().getId()) == null)
				Session.getInstance().getUniverse().add(requestReplyJp);
		//logger.debug("Size of list is " +Session.getInstance().getUniverse().getConversationJoinPointList().size() );
		Begin(requestReplyJp);
		proceed(_sendJp);
	}

	void around(ReceiveEventJP _receiveJp) : MessageRecieve(_receiveJp){
		
		if (_receiveJp!= null && _receiveJp.getConversation() != null)
			currentConversation = _receiveJp.getConversation();
		
		
		RequestReplyConversationJP requestReplyJp = (RequestReplyConversationJP) Session.getInstance().getUniverse().findByConversation(Encoder.decode(_receiveJp.getBytes()).getConversation().getId());
		//logger.debug("Received conversation is " + requestReplyJp);
		if (requestReplyJp != null){
			requestReplyJp.setRecieveJp(_receiveJp);						
			End(requestReplyJp);
		}
		proceed(_receiveJp);
	}

	public void Begin(RequestReplyConversationJP _requestReplyJp, TimeSpan _timeout){		
	}

	public void Begin(RequestReplyConversationJP _requestReplyJp){		
	}

	public void End(RequestReplyConversationJP _requestReplyJp){		
	}
	
	
	public void RRConverstaionEnd(RequestReplyConversationJP _requestReplyJp){}
	
	public void RRConverstaionStart(RequestReplyConversationJP _requestReplyJp){}
	
	private void Timeout(RequestReplyConversationJP _requestReplyJp){}
	
}