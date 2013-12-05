package utilities.statemachine;

import java.io.Serializable;
import java.util.UUID;

import org.apache.log4j.Logger;

import universe.MessageType;

public class Transition implements Serializable{
		
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private char actionType;
	private MessageType messageType = null; 
	private State fromState = null;
	private State toState = null;
	private UUID index = null;
	
	public Transition(char _actionType, MessageType _messageType,State _fromState, State _toState, UUID _index) {
		super();
		this.actionType = _actionType;
		this.messageType = _messageType;
		this.fromState = _fromState;
		this.toState = _toState;
		this.index = _index;
	}

	public State getFromState() {
		return fromState;
	}
	public void setFromState(State _fromState) {
		this.fromState = _fromState;
	}
	public State getToState() {
		return toState;
	}
	public void setToState(State _toState) {
		this.toState = _toState;
	}
	public UUID getIndex() {
		return index;
	}
	public void setIndex(UUID _index) {
		this.index = _index;
	}
	public char getActionType() {
		return actionType;
	}
	public void setActionType(char _actionType) {
		this.actionType = _actionType;
	}
	public MessageType getMessageType() {
		return messageType;
	}
	public void setMessageType(MessageType _messageType) {
		this.messageType = _messageType;
	}

	public boolean match(State _fromState, char _action, MessageType _messageType){	
		if(_fromState.getName().equals(fromState.getName()) && actionType == _action && messageType.getType().equals(_messageType.getType()) )
			return true;
		else
			return false;
	}
}
