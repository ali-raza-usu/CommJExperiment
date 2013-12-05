package utilities;
import java.util.List;
import java.util.Vector;
import java.util.concurrent.CopyOnWriteArrayList;

import joinpoints.communication.CommunicationEventJP;
import joinpoints.communication.CommunicationEventJP;

import org.apache.log4j.Logger;


public class CommunicationJoinPointRegistry {

	Logger logger = Logger.getLogger(CommunicationJoinPointRegistry.class);
	private CopyOnWriteArrayList<CommunicationEventJP> comJpList = new CopyOnWriteArrayList<CommunicationEventJP>();
	
	public CommunicationEventJP findByConversation(Object _conversationId)
	{		
		CommunicationEventJP comJp = null;	
		for(CommunicationEventJP tempComJp : comJpList){
			if(tempComJp.getConversation().getId().toString().equals(_conversationId.toString()))
			{											
				comJp = tempComJp;
				break;
			}
		}
		return comJp;
	}
	
	
	public List<CommunicationEventJP> getConversationJoinPointList() {
		return comJpList;
	}

	
	public void setConversationJoinPointList(
			CopyOnWriteArrayList<CommunicationEventJP> _conversationJointPointList) {
		this.comJpList = _conversationJointPointList;
	}

	
	public void add(CommunicationEventJP _commJp)
	{		
		comJpList.add(_commJp);
	}	
}
