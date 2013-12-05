package utilities;

import java.net.InetSocketAddress;
import java.net.SocketAddress;
import java.util.List;
import java.util.Vector;

import joinpoints.connection.ChannelJP;
import joinpoints.connection.ConnectEventJP;

import org.apache.log4j.Logger;


public class ConnectionJoinPointRegistry {

	Logger logger = Logger.getLogger(ConnectionJoinPointRegistry.class);
	private Vector<ChannelJP> channelJpList = new Vector<ChannelJP>();
	
	public ChannelJP find(String _data, char _messageType){		
		ChannelJP tempConnJP = null;
		for(ChannelJP channelJp : channelJpList){
			{				
				tempConnJP = channelJp;
				break;
			}			
		}
		return tempConnJP;
	}

	boolean checkSockets(SocketAddress _socketAddr1, SocketAddress _socketAddr2){
		boolean _flag = false;
		return _flag;
	}
	
	public ChannelJP findBySocket(InetSocketAddress _socAddr){		
		ChannelJP channelJp = null;
		for(ChannelJP tempChannelJp : channelJpList){
			if (tempChannelJp.getConnectJp().getLocalEP() != null)
			if(tempChannelJp.getConnectJp().getLocalEP().getPort()==(_socAddr.getPort())){				
				channelJp = tempChannelJp;
				break;
			}
		}
		return channelJp;
	}
	
	public List<ChannelJP> getConnectEventJoinPointList(){
		return channelJpList;
	}

	
	public void setConnectEventJoinPointList(Vector<ChannelJP> p_ConnectJointPointList){
		this.channelJpList = p_ConnectJointPointList;
	}

	
	public void add(ChannelJP _channelJp){
		channelJpList.add(_channelJp);
	}	
}