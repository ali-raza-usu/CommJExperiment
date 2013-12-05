package baseaspects.communication;

import java.util.UUID;

import joinpoints.communication.CommunicationEventJP;
import joinpoints.communication.MultistepConversationJP;
import joinpoints.communication.ReceiveEventJP;
import joinpoints.communication.SendEventJP;
import org.apache.log4j.Logger;
import baseaspects.communication.MessageAspect;
import universe.Conversation;
import utilities.Encoder;
import utilities.Session;
import utilities.statemachine.StateMachine;


public  abstract aspect MultistepConversationAspect extends MessageAspect{

	
	public pointcut ConversationBegin(MultistepConversationJP _multiStepJp) : execution(* MultistepConversationAspect.Begin(MultistepConversationJP)) && args(_multiStepJp);	
	public pointcut ConversationEnd(MultistepConversationJP _multiStepJp) : execution(* MultistepConversationAspect.End(..)) && args(_multiStepJp);	
	private Logger logger = Logger.getLogger(MultistepConversationAspect.class);
	private Conversation currentConversation = null;

	void around(SendEventJP _sendJp) : MessageSend(_sendJp){	
		//logger.debug("in Message send before makeStateTransition");
		//logger.debug(" setting role "+ _sendJp.getRole());
		makeStateTransiton(_sendJp, 'S');
		//logger.debug("After makeStateTransition and before proceed");
		proceed(_sendJp);		
	}
	

	void around(ReceiveEventJP _receiveJp) : MessageRecieve(_receiveJp){
		//logger.debug("in Message received before makeStateTransition");
		//logger.debug("Receieved message before making tranisition "+ Encoder.decode(_receiveJp.getBytes()).getClass());
		makeStateTransiton(_receiveJp, 'R');
		//logger.debug("Receieved message after making transition "+ Encoder.decode(_receiveJp.getBytes()).getClass());
		proceed(_receiveJp);		
	}

	
	public void Begin(MultistepConversationJP _multiStepJp){
	}

	public void End(MultistepConversationJP _multiStepJp){	
		//logger.debug("In the end " + Encoder.decode(_multiStepJp.getBytes()).getClass());
	}
	
	private void makeStateTransiton(CommunicationEventJP _commJp, char _actionType){
		//logger.debug("finding joinpoint by conversaiton");
		if(_commJp.getProtocol() == null)
			return;
		
		if (_commJp!= null && _commJp.getConversation() == null){
			if(currentConversation == null)
				currentConversation =  new Conversation();
			_commJp.setConversation(currentConversation);
		}else{
			currentConversation = _commJp.getConversation();
		}
		
		MultistepConversationJP multiStepJp = (MultistepConversationJP)Session.getInstance().getUniverse().findByConversation(_commJp.getConversation().getId());
		//logger.debug("found result is  multistepHJp " + multiStepJp );
		if(multiStepJp == null){
			multiStepJp = new MultistepConversationJP(_commJp);
		//	logger.debug("default protocol is "+ multiStepJp.getProtocol());
		//	logger.debug("default Role is "+ multiStepJp.getRole());
		//	logger.debug("default Role from commJ is "+ _commJp.getRole());
		//	logger.debug("default protocolRole is "+ multiStepJp.getProtocolRole());
			Session.getInstance().getUniverse().getConversationJoinPointList().add(multiStepJp);
		//	logger.debug("it was null and so adding to the list wth size now "+ Session.getInstance().getUniverse().getConversationJoinPointList().size());
			
		} else{
			multiStepJp.setMessageType(_commJp.getMessageType());
			//logger.debug("No it was not null and hence its message type is " + multiStepJp.getMessageType().getType());
		}	
		multiStepJp.setBytes(_commJp.getBytes());
		//logger.debug("before finding the state machine ");
		StateMachine stateMachine = StateMachine.findConverstion(multiStepJp.getConversation());
		//logger.debug("state machine found is " + stateMachine);
		if (stateMachine == null){			
			//logger.debug("multistep conversations are "+ multiStepJp.getConversation());
			stateMachine =  StateMachine.createStateMachine(multiStepJp.getProtocolRole(), multiStepJp.getConversation());
			//logger.debug("state machine WAS NULL and newly created state machine is " + stateMachine.getClass());
			//logger.debug("current state of state machine in multistepJoinPoint is " + multiStepJp.getConversation().getCurrentState().getName());
			if(stateMachine !=null)
				multiStepJp.getConversation().setCurrentState(stateMachine.getIntialState());
		}
		
		if(stateMachine !=null){

			if(multiStepJp.getConversation().isInInitialState())
				Begin(multiStepJp);
			
			logger.debug(_actionType+" : before transition current state is " + multiStepJp.getConversation().getCurrentState().getName());	
			if(!multiStepJp.getConversation().getCurrentState().isFinal())
				multiStepJp.getConversation().setCurrentState(stateMachine.makeTransition(multiStepJp.getConversation(), _actionType,multiStepJp.getMessageType()) );
			logger.debug(_actionType+" : after transition current state is " + multiStepJp.getConversation().getCurrentState().getName());
			logger.debug(_actionType+" : is final state  " + multiStepJp.getConversation().getCurrentState().isFinal());
			logger.debug(" : current message is " + Encoder.decode(multiStepJp.getBytes()).getClass());
			multiStepJp.setConversation(StateMachine.getConversationInProgress(multiStepJp.getConversation()));		

			if(multiStepJp.getConversation().isInFinalState()){
				End(multiStepJp);
				currentConversation = null;
				StateMachine.deleteStateMachine(currentConversation);
			}
		}
	}
}


