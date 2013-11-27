package baseaspects.connection;


import joinpointracker.ListenerJoinPointTracker;
import joinpointracker.InitiatorJoinPointTracker;

import joinpoints.connection.CloseEventJP;
import joinpoints.connection.ConnectEventJP;

public abstract aspect ConnectionAspect {

	public pointcut Connect(ConnectEventJP _connectJp) :
					within(InitiatorJoinPointTracker) && 
					execution(* InitiatorJoinPointTracker.ChannelConnect(..)) && args(_connectJp);

	public pointcut Accept(ConnectEventJP _connectJp) :
					within(ListenerJoinPointTracker) && 
					execution(void ListenerJoinPointTracker.ChannelAccept(..)) && args(_connectJp);
	
	public pointcut CloseServer(CloseEventJP _closeJp) :
					within(ListenerJoinPointTracker) && 
					execution(void ListenerJoinPointTracker.CloseServerEventJointPoint(..)) && args(_closeJp);
		
	public pointcut CloseClient(CloseEventJP _closeJp) :
					within(InitiatorJoinPointTracker) && 
					execution(void InitiatorJoinPointTracker.CloseClientEventJointPoint(..)) && args(_closeJp);	
}
