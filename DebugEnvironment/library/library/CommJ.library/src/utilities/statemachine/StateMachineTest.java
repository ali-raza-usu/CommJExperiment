package utilities.statemachine;

import static org.junit.Assert.*;

import org.junit.Test;

import universe.Conversation;
import universe.ParticipantRole;
import universe.Protocol;
import universe.Role;


public class StateMachineTest {

	@Test
	public void testCreateStateMachine() {
		
		Protocol _protocol = ClientEncryptionSM.getProtocol();
        Role _role = ClientEncryptionSM.getRole();    
        ParticipantRole _pRole = new ParticipantRole(_protocol, _role);
        StateMachine m = StateMachine.CreateStateMachine(_pRole);
        assertNotNull(m);
	}

}
