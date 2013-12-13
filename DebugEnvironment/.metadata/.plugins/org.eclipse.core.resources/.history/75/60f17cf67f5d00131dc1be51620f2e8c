package aspects.ms;

import universe.Conversation;
import universe.Protocol;
import universe.Role;
import utilities.statemachine.StateMachine;

public class FTPServer_SM extends StateMachine {
	static {
		register(FTPServer_SM.class, new Protocol("FileTransferPerformanceMonitor"),new Role("FTPServer"));
	}

	public FTPServer_SM(Conversation con) {
		super(con);
	}

	@Override
	public void buildTransitions() {
		addTransition("Initial", 'S', "FileTransferResponse","ServerSentResponse");
		addTransition("ServerSentResponse", 'R', "FileTransferAck","ServerReceivedAck");
	}

	public static Protocol getProtocol() {
		return getProtocolRole().getProtocol();
	}

	public static Role getRole() {
		return getProtocolRole().getRole();
	}
}
