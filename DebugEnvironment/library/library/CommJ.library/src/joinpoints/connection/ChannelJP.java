package joinpoints.connection;

import org.apache.log4j.Logger;

import utilities.TimeSpan;
import joinpoints.communication.CommunicationEventJP;


public class ChannelJP extends CommunicationEventJP
{
	Logger logger = Logger.getLogger(ChannelJP.class);
	private ConnectEventJP connectJp;
	private CloseEventJP closeJp;
	private int messageId; 
	private String data;
	private byte[] bytes;
	
	 public ChannelJP() {
		 super.setConversation(getConversation());
	}

		 
	public CloseEventJP getCloseJp() {
		return closeJp;
	}
		
	public void setCloseJp(CloseEventJP _closeJp)
	{	
		this.closeJp = _closeJp;
	}
	
	public int getMessageId() {
		return messageId;
	}

	public void setMessageId(int _messageId) {
		this.messageId = _messageId;
	}

	
	public void setData(String _data) {
	  data = _data;
	}
	
	public String getData() {
		// TODO Auto-generated method stub
		return data;
	}

	public byte[] getMessageBytes() {
		return bytes;
	}

	public void setMessageBytes(byte[] _bytes) {
		this.bytes = _bytes;
	}
	
	public TimeSpan deltaTime()
	{
		return null;
		// If not complete, return incomplete TimeSpan
		// If completed, return receiveJP.localTime - sendJP.localTIme 
	}


	public ConnectEventJP getConnectJp() {
		return connectJp;
	}


	public void setConnectJp(ConnectEventJP _connectJp) {
		this.connectJp = _connectJp;
	}

	
	
	
}
