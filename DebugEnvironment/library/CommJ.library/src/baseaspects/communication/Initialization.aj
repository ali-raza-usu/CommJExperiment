package baseaspects.communication;
import java.lang.reflect.Method;
import java.util.*;

import org.apache.log4j.Logger;

import universe.*;
import utilities.*;
import joinpointracker.*;



//Uncomment the advices, we did it to run the code for RRConversation

public abstract  aspect Initialization {

	private Logger logger = Logger.getLogger(Initialization.class);
  	
	public static Protocol protocol = null;
	public static Role role = null;
		
	private pointcut ConfigureMessage(IMessage _message) : execution(void utilities.IMessage.setMessage(..)) && target(_message);
	public  pointcut ConfigureProtocolRole() :execution(void *.main(..));
	public  pointcut DeserializeMessage(byte[] bytes) :call(IMessage MessageJoinPointTracker.ReadMessage(..)) && args(bytes);
	
	
	public static HashMap<Class<?>, Class<?>> mappings = new HashMap<Class<?>, Class<?>>();
	
	public abstract void defineMappng();
	before():ConfigureProtocolRole()
	{								
		defineMappng();
	//	logger.debug("Calling ConfigureProtocolRole");
        Class<?> className = thisJoinPointStaticPart.getSignature().getDeclaringType();
        logger.debug("className "+ className.getName());
        invokeRoleAndProtocol(className);
	}		
	
	after(IMessage _message):ConfigureMessage(_message)
	{	
		logger.debug("Configuring the Message: Role, Protocol, Conversation");
//		if(conversation!= null)
//			logger.debug("Conversation is not null and id : " + conversation.getId());

		_message.setProtocol(protocol);
		_message.setRole(role);
		//_message.setConversation(conversation);
	//	logger.debug("Setting conversation value in the message " + _message.getConversation().getId());
	}
	
	//To ensure that every received message is having a conversation, role, and protocol
	IMessage around(byte[] bytes):DeserializeMessage(bytes)
	{								
		IMessage msg = proceed(bytes);
		if(msg != null){
			msg.setProtocol(protocol);
			msg.setRole(role);
		}
		return msg;
	}
	
	public void invokeRoleAndProtocol(Class<?> _className)
	{		
	//	logger.debug("Invoking RoleAndProtocol");
		Class<?> _stateMachineClass = mappings.get(_className);
		protocol = (Protocol)invoke("getProtocol", _stateMachineClass);
	//	if(protocol!=null)
	//		logger.debug("protocol is " + protocol.getName());
		role = (Role)invoke("getRole", _stateMachineClass);
	//	if(role!=null)
	//		logger.debug("role is " + role.getName());
	}
	
	public void addMapping(Class<?> _classA, Class<?> _classB){
		mappings.put(_classA, _classB);
	}
	

	public Object invoke(String _methodName, Class<?> _class)
	{
		try{
		Method method = _class.getMethod(_methodName, null);			
		return method.invoke(null, null);
		}catch(Exception e){
			return null;
		}		
	}
	
}
