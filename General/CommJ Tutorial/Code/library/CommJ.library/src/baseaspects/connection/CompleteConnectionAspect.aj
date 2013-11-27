package baseaspects.connection;
import joinpoints.connection.ChannelJP;
import joinpoints.connection.CloseEventJP;
import joinpoints.connection.ConnectEventJP;
import org.apache.log4j.Logger;

import baseaspects.connection.ConnectionAspect;
import universe.Conversation;
import utilities.Session;

public abstract aspect CompleteConnectionAspect extends ConnectionAspect
{
	Logger logger = Logger.getLogger(CompleteConnectionAspect.class);
	
	public pointcut ConversationBeginOnInitiator(ChannelJP _channelJp) : execution(* CompleteConnectionAspect.BeginOnInitiator(ChannelJP)) && args(_channelJp);	
	public pointcut ConversationBeginOnListener(ChannelJP _channelJp) : execution(* CompleteConnectionAspect.BeginOnListner(ChannelJP)) && args(_channelJp);
	public pointcut ConversationEndOnListener(ChannelJP _channelJp) : execution(* CompleteConnectionAspect.EndListener(ChannelJP)) && args(_channelJp);
	public pointcut ConversationEndOnInitiator(ChannelJP _channelJp) : execution(* CompleteConnectionAspect.EndInitiator(ChannelJP)) && args(_channelJp);

	
	void around(ConnectEventJP _connectJp) : Connect(_connectJp)
	{	
		ChannelJP channelJp = new  ChannelJP();	
		channelJp.setConnectJp(_connectJp);
		channelJp.setConversation(new Conversation());
		Session.getInstance().getConUniverse().add(channelJp);
		BeginOnInitiator(channelJp);
		proceed(_connectJp);
	}
	
	
	void around(ConnectEventJP _connectJp) : Accept(_connectJp)
	{	
		ChannelJP channelJp = new  ChannelJP();		
		channelJp.setConnectJp(_connectJp);
		channelJp.setConversation(new Conversation());
		
		ChannelJP severChannelJP = new  ChannelJP();		
		severChannelJP.setConnectJp(_connectJp);
		
		Session.getInstance().getConUniverse().add(channelJp);
		Session.getInstance().getConUniverse().add(severChannelJP);		
		BeginOnListner(channelJp);
		proceed(_connectJp);
	}

	void around(CloseEventJP _closeJp) : CloseServer(_closeJp)
	{					 		
		ChannelJP channelJp = Session.getInstance().getConUniverse().findBySocket(_closeJp.getLocalEP());
		proceed(_closeJp);
		if (channelJp != null)
		{
			channelJp.setCloseJp(channelJp.getCloseJp());
			EndListener(channelJp);
		}
		
	}

	
	void around(CloseEventJP _closeJp) : CloseClient(_closeJp)
	{					 		
		ChannelJP channelJp = Session.getInstance().getConUniverse().findBySocket(_closeJp.getLocalEP());
		proceed(_closeJp);
		if (channelJp != null)
		{
			channelJp.setCloseJp(channelJp.getCloseJp());		
			EndInitiator(channelJp);
		}
	}

	
	public void BeginOnInitiator(ChannelJP _channelJp)
	{}

	public void BeginOnListner(ChannelJP _channelJp)
	{}
	
	public void EndListener(ChannelJP _channelJp)
	{}

	public void EndInitiator(ChannelJP _channelJp)
	{}
		
}