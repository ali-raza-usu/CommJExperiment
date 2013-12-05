package joinpointracker;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.DatagramSocket;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.net.SocketAddress;
import java.nio.ByteBuffer;
import java.nio.channels.*;

import joinpoints.communication.*;
import joinpoints.connection.ChannelJP;
import joinpoints.connection.ConnectEventJP;

import org.apache.log4j.Logger;

import baseaspects.communication.Initialization;

import universe.Conversation;
import universe.ProtocolRole;
import utilities.*;

public aspect MessageJoinPointTracker {
	
	private Logger logger = Logger.getLogger(MessageJoinPointTracker.class);
	
	private pointcut SocketRead(Socket _socket, byte[] _buffer, int _len) :
						call(* Socket+.read(byte[], ..)) && target(_socket) && args(_buffer, _len);  
	
	private pointcut ChannelRead(SocketChannel _channel, ByteBuffer _buffer) :
						call(* SocketChannel+.read(ByteBuffer)) && target(_channel) && args(_buffer) ||
						call(* DatagramChannel+.receive(ByteBuffer)) && target(_channel) && args(_buffer) ;
	
	public pointcut SocketWrite(Socket _socket, byte[] _data, int _length) :
						call(void Socket+.write(byte[], int)) && target(_socket) && args(_data, _length);
	
	public pointcut ChannelWrite(SocketChannel _channel, ByteBuffer _data) :
						call(* SocketChannel+.write(ByteBuffer)) && target(_channel) && args(_data);
						
	
	public pointcut DatagramChannelWrite(DatagramChannel _channel, ByteBuffer _data, SocketAddress _addr) :
						call(* DatagramChannel+.send(ByteBuffer, SocketAddress)) && target(_channel) && args(_data, _addr) ;
	
	private pointcut DatagramChannelRead(DatagramChannel _channel, ByteBuffer _buffer) :	
						call(* DatagramChannel+.receive(ByteBuffer)) && target(_channel) && args(_buffer) ||
						call(* DatagramChannel+.read(ByteBuffer)) && target(_channel) && args(_buffer);

	protected RequestReplyConversationJP requestReplyJp = null;
	protected SendEventJP sendJp = null;
	protected ReceiveEventJP receiveJp = null;
	
    after(SocketChannel _channel, ByteBuffer _buffer) : ChannelRead(_channel, _buffer){  
    	boolean isEncrypted = false;
    	if(_buffer.position() != 0){  
			ByteBuffer tempBuf = _buffer.duplicate();	    
			tempBuf.flip(); 
			logger.debug("remaining bytes received are are "+ tempBuf.remaining());
			byte[] bytes = new byte[tempBuf.remaining()];			
			tempBuf.get(bytes);	
			
			receiveJp = new ReceiveEventJP();
			receiveJp.setJp(thisJoinPoint);
	    	receiveJp.setBytes(bytes);
	  		IMessage message = ReadMessage(receiveJp.getBytes());
	  		
	    	Socket socket = _channel.socket();
	    	receiveJp.setChannelJp(Session.getInstance().getConUniverse().findBySocket(new InetSocketAddress(socket.getInetAddress(), socket.getLocalPort())));

	    	
	  		if(message == null){
	  			isEncrypted = true;
		    	ReceiveJoinPoint(receiveJp); 
	  		}
				    	

	    	
	    	if(message!=null){
	    		receiveJp.setConversation(message.getConversation());
	    	}

 //   		logger.debug("Conversation in Initialization aspect is " + Initialization.conversation.getId());
//    		logger.debug("Conversation in message receive is " + message.getConversation().getId());
	    	if(message != null){
		    	receiveJp.setMessageType(message.getMessageType());
		    	receiveJp.setProtocol(message.getProtocol());
		    	receiveJp.setRole(message.getRole());
		    	receiveJp.setProtocolRole(new ProtocolRole(message.getProtocol(),message.getRole()));
	    	}
	    	
	    	if(!isEncrypted)
	    		ReceiveJoinPoint(receiveJp);
	    	if(receiveJp.getConversation() != null){
	    		message = ReadMessage(receiveJp.getBytes());
	    	}
	    		message.setConversation( receiveJp.getConversation());
	    	
	    	_buffer.clear();
	  		_buffer.put(ByteBuffer.wrap(receiveJp.getBytes()));	    	
    	}
    }

    after(DatagramChannel _channel, ByteBuffer _buffer) : DatagramChannelRead(_channel, _buffer){
    	boolean isEncrypted = false;
    	if(_buffer.position() != 0){   
			ByteBuffer tempBuf = _buffer.duplicate();	    
			tempBuf.flip(); 
			logger.debug("remaining bytes are "+ tempBuf.remaining());
			byte[] bytes = new byte[tempBuf.remaining()];
			tempBuf.get(bytes);	
			
			receiveJp = new ReceiveEventJP();
			receiveJp.setJp(thisJoinPoint);
	    	receiveJp.setBytes(bytes);
	    	IMessage message = ReadMessage(receiveJp.getBytes());

	    	DatagramSocket socket = _channel.socket();
	    	receiveJp.setChannelJp(Session.getInstance().getConUniverse().findBySocket(new InetSocketAddress(socket.getInetAddress(), socket.getLocalPort())));	    	

	    	if(message == null){
	  			isEncrypted = true;
		    	ReceiveJoinPoint(receiveJp); 
	  		}
	    	

	    	if(message != null)
	    		receiveJp.setConversation(message.getConversation());
	    	
//    		logger.debug("Conversation in Initialization aspect is " + Initialization.conversation.getId());
//    		logger.debug("Conversation in message receive is " + message.getConversation().getId());
	    	if(message != null){
	    		receiveJp.setMessageType(message.getMessageType());
	    		receiveJp.setProtocol(message.getProtocol());
	    		receiveJp.setRole(message.getRole());
	    		receiveJp.setProtocolRole(new ProtocolRole(message.getProtocol(),message.getRole()));
	    	}
	    	
	    	if(!isEncrypted)
	    		ReceiveJoinPoint(receiveJp);
	    	if(receiveJp.getConversation() != null){
	    		message = ReadMessage(receiveJp.getBytes());
	    	}
	    	
	    	if(message != null)
	    		message.setConversation( receiveJp.getConversation());
	    	
	    	_buffer.clear();
	  		_buffer.put(ByteBuffer.wrap(receiveJp.getBytes()));	 
    	}
    }
    
    int around(SocketChannel _channel, ByteBuffer _data) : ChannelWrite(_channel, _data){
    	ByteBuffer tempBuf = _data.duplicate();	
 //   	logger.debug("starting channel write in MessageJPTracker");
    	byte[] bytes = new byte[tempBuf.remaining()];
    	logger.debug("remaining bytes sent are "+ tempBuf.remaining());
		tempBuf.get(bytes); 
    	sendJp = new SendEventJP();
    	sendJp.setJp(thisJoinPoint);
    	sendJp.setBytes(bytes);
    	IMessage message = decode(bytes);
 //   	logger.debug("ChannelWrite : Sending message : "+ message.getClass());
    	Socket socket = _channel.socket();
   		sendJp.setConversation(message.getConversation());
   		
 //  	logger.debug(" ChannelWrite : converstion id "+ sendJp.getConversation().getId());
       	sendJp.setProtocol(message.getProtocol());
 //     logger.debug(" setting protocol "+ sendJp.getProtocol());
    	sendJp.setRole(message.getRole());    	
  //  	logger.debug(" setting role "+ sendJp.getRole());
    	sendJp.setProtocolRole(new ProtocolRole(message.getProtocol(),message.getRole()));
 //   	logger.debug(" setting protocolRole "+ sendJp.getProtocolRole());
    	sendJp.setMessageType(message.getMessageType());
       	ChannelJP channelJp = Session.getInstance().getConUniverse().findBySocket(new InetSocketAddress(socket.getInetAddress(), socket.getLocalPort() ));
       	sendJp.setChannelJp( channelJp);
    	SendJoinPoint(sendJp);    
 //   	logger.debug("ChannelWrite: converstion Id after pointcut " + sendJp.getConversation().getId());
    	IMessage tempMsg = Encoder.decode(sendJp.getBytes());
    	
    	if(tempMsg != null){
    	message.setConversation(sendJp.getConversation());
    	sendJp.setBytes(Encoder.encode(message));
    	}
    	
    	_data = ByteBuffer.wrap(sendJp.getBytes());
    	//logger.debug("Now writing date ");
        return proceed(_channel, _data);
    }
    
    
    int around(DatagramChannel _channel, ByteBuffer _data, SocketAddress _addr) : DatagramChannelWrite(_channel, _data, _addr){
    	    	
    	ByteBuffer tempBuf = _data.duplicate();	    
    	byte[] bytes = new byte[tempBuf.remaining()];
		tempBuf.get(bytes);
    	sendJp = new SendEventJP();
    	sendJp.setJp(thisJoinPoint);
    	IMessage message = decode(bytes);
    	
    	sendJp.setSocket(null);
    	sendJp.setBytes(bytes);
    	DatagramSocket socket = _channel.socket();
    
       	sendJp.setProtocol(message.getProtocol());
       	logger.debug(" setting protocol "+ sendJp.getProtocol());
    	sendJp.setRole(message.getRole());    	
    	logger.debug(" setting role "+ sendJp.getRole());
    	sendJp.setProtocolRole(new ProtocolRole(message.getProtocol(),message.getRole()));
    	logger.debug(" setting protocolRole "+ sendJp.getProtocolRole());
    	sendJp.setMessageType(message.getMessageType());
       	
    	ChannelJP channelJp = Session.getInstance().getConUniverse().findBySocket(new InetSocketAddress(socket.getInetAddress(), socket.getLocalPort() ));
       	sendJp.setChannelJp( channelJp);
    	SendJoinPoint(sendJp);    
    	
    	//logger.debug("ChannelWrite: converstion Id after pointcut " + sendJp.getConversation().getId());
    	
    	IMessage tempMsg = Encoder.decode(sendJp.getBytes());
    	
    	if(tempMsg != null){
    	message.setConversation(sendJp.getConversation());
    	sendJp.setBytes(Encoder.encode(message));
    	}
    	
    	_data = ByteBuffer.wrap(sendJp.getBytes());
    	//logger.debug("Now writing date ");    	
        return proceed(_channel, _data, _addr);
    }
    
    
    void around(Socket _socket, byte[] _data, int _length) : SocketWrite(_socket, _data, _length){
    	
    	byte[] bytes = _data;		    	   	    
    	sendJp = new SendEventJP();
    	sendJp.setJp(thisJoinPoint);
    	sendJp.setSocket(null);
    	sendJp.setBytes(bytes);     
        SendJoinPoint(sendJp);
        proceed(_socket, _data, _length);
    }

    public void SendJoinPoint(SendEventJP sendJp){    	    	
    }

    public void ReceiveJoinPoint(ReceiveEventJP receiveJp){    	
    }    
    
    
    public static IMessage ReadMessage(byte[] _bytes)
	{
		return  MessageJoinPointTracker.decode(_bytes);
	}


	public static IMessage decode(byte[] _bytes)
	{
		
		try{			
		
			ByteArrayInputStream bInputS = new ByteArrayInputStream(_bytes);
			ObjectInputStream oIs = new ObjectInputStream(bInputS);				
			IMessage msg = (IMessage) oIs.readObject();
			
			oIs.close();
			bInputS.close();
			return msg;
		}catch(Exception e)
		{
			//logger.error(ExceptionUtils.getStackTrace(e));
			return null;
		}
	}
	
}
