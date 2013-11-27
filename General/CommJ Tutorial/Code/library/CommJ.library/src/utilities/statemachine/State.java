package utilities.statemachine;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.apache.log4j.Logger;

import universe.MessageType;

public class State implements Serializable{
	
	private static final long serialVersionUID = 1L;

	private boolean isFinal = false;
	private boolean isInitial = false;
	private String name = "";
	private List<Transition> transitions = new ArrayList<Transition>(); 
	
	
	public boolean isFinal() {
		return isFinal;
	}

	public void setFinal(boolean _isFinal) {
		this.isFinal = _isFinal;
	}

	public State(boolean _isFinal, boolean _isInitial, String _name) {
		super();
		this.isFinal = _isFinal;
		this.isInitial = _isInitial;
		this.name = _name;
	}

	public String getName() {
		return name;
	}

	public State(boolean _isFinal, String _name) {
		super();
		this.isFinal = _isFinal;
		this.name = _name;
	}

	public void setName(String _name) {
		this.name = _name;
	}

	public boolean isInitial() {
		return isInitial;
	}

	public void setInitial(boolean _isInitial) {
		this.isInitial = _isInitial;
	}

	public List<Transition> getTransitions() {
		return transitions;
	}

	public void setTransitions(List<Transition> _transitions) {
		this.transitions = _transitions;
	}

	public State makeTransition(char _action, MessageType _type) {
		for(Transition _transition : transitions)
		{			
			if(_transition.match(this, _action,_type))
				return _transition.getToState();
		}
		//logger.debug("it is null can't make transition");
		return null;
	} 
}
