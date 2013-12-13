package universe;


import utilities.statemachine.StateMachine;

public class ProtocolRole extends Object{

	private Protocol protocol = null;
	private Role role = null;
	private StateMachine machine = null;
	private Class<?> className = null;
	
	public ProtocolRole(Protocol _protocol, Role _role, StateMachine _stateMachine)
	{	protocol = _protocol;
		role = _role;
		machine = _stateMachine;
	}
	
	public ProtocolRole(Protocol _protocol, Role _role)
	{
		protocol = _protocol;
		role = _role;
	}

	public Protocol getProtocol() {
		return protocol;
	}

	public void setProtocol(Protocol _protocol) {
		this.protocol = _protocol;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role _role) {
		this.role = _role;
	}


	public StateMachine getMachine() {
		return machine;
	}

	public void setMachine(StateMachine _machine) {
		this.machine = _machine;
	}
	
	@Override
	public boolean equals(Object _pRole)
	{
		ProtocolRole tempRole = (ProtocolRole)_pRole;
		if(tempRole.getProtocol().getName().equals(this.getProtocol().getName()) )// && _pRole.getRole().getName().equals(_partRole.getRole().getName()))
		{
			return true;
		}
		return false;		
	}

	public Class<?> getClassName() {
		return className;
	}

	public void setClassName(Class<?> className) {
		this.className = className;
	}
}
