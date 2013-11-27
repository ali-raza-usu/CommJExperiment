package joinpointracker;

import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.net.SocketAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.nio.channels.ServerSocketChannel;
import java.nio.channels.SocketChannel;

import joinpoints.connection.ChannelJP;
import joinpoints.connection.CloseEventJP;
import joinpoints.connection.ConnectEventJP;
import joinpoints.connection.ConnectEventJP.Status;

import org.apache.commons.lang3.exception.ExceptionUtils;
import org.apache.log4j.Logger;

import utilities.Session;

public aspect InitiatorJoinPointTracker {

	private Logger logger = Logger.getLogger(InitiatorJoinPointTracker.class);
	 
	
	 //===========================================INITIATOR============================================
	 //Sockets related pointcuts for initiator in 5 styles				 
	 private pointcut SocketConnectStyle1():
		 							call(Socket.new());
	 
	 private pointcut SocketConnectStyle2(InetAddress _address, int _port): 
		 							call(Socket+.new(InetAddress, int)) && args(_address, _port);
	 		 	 		 
	 private pointcut SocketConnectStyle3(InetAddress _remoteAddress, int _remotePort, InetAddress _localAddress, int _localPort): 
									call(Socket+.new(InetAddress, int, InetAddress, int)) && args(_remoteAddress, _remotePort, _localAddress, _localPort);
	 
	 private pointcut SocketConnectStyle4(String _host, int _port): 
				 					call(Socket.new(String, int))  && args(_host, _port);
	 		 		 
	 private pointcut SocketConnectStyle5(Socket _socket, InetSocketAddress _endPoint): 
									call(void Socket+.connect(SocketAddress)) && target(_socket) && args(_endPoint);
	 
	 //Channel-related pointcuts for Initiator
	 pointcut ChannelConnect(SocketChannel _socketChannel, InetSocketAddress _remoteEP) : 
									call(* SocketChannel.connect(..)) && target(_socketChannel) && args(_remoteEP); 
	 		 		
	 pointcut ChannelConnectFinish(SocketChannel _socketChannel) : 
									call(* SocketChannel+.finishConnect(..)) && target(_socketChannel);
	 
	 
	 //Socket-related pointcuts for Close and connection-orient communication channel
	 private pointcut SocketClose(Socket _socket): 
		 							call(* Socket+.close(..)) && target(_socket);
	
	 
	 pointcut ClientChannelClose(SocketChannel _channel) :
			call(* SocketChannel.close()) && target(_channel);	
	 
	 
	 
	Socket around() : SocketConnectStyle1(){			
		Socket socket = proceed();
		ConnectEventJP connectJP = new ConnectEventJP(false);
		InetSocketAddress remoteEP = new InetSocketAddress(socket.getPort());
		InetSocketAddress localEP = new InetSocketAddress(socket.getLocalPort());
		codeForConnect(connectJP, remoteEP, localEP, Status.CONNECTING);
		return socket;
	}
	
	Socket around(InetAddress _address, int _port) : SocketConnectStyle2(_address, _port){
		Socket socket = proceed(_address, _port);
		ConnectEventJP connectJP = new ConnectEventJP(false);
		InetSocketAddress remoteEP = new InetSocketAddress(socket.getPort());
		InetSocketAddress localEP = new InetSocketAddress(_address,_port);
		codeForConnect(connectJP, remoteEP, localEP, Status.CONNECTING);
		return socket;
	}
	
	
	Socket around(InetAddress _remoteAddress, int _remotePort, InetAddress _localAddress, int _localPort) : SocketConnectStyle3(_remoteAddress, _remotePort, _localAddress, _localPort){			
		Socket socket = proceed(_remoteAddress, _remotePort, _localAddress, _localPort);
		ConnectEventJP connectJP = new ConnectEventJP(false);
		InetSocketAddress remoteEP = new InetSocketAddress(_remoteAddress, _remotePort);
		InetSocketAddress localEP = new InetSocketAddress(_localAddress,_localPort);
		codeForConnect(connectJP, remoteEP, localEP, Status.CONNECTING);
		return socket;
	}
	
	Socket around(String _host, int _port) : SocketConnectStyle4( _host, _port){
		Socket socket = proceed(_host, _port);
		ConnectEventJP connectJP = new ConnectEventJP(false);
		InetSocketAddress remoteEP = new InetSocketAddress(socket.getPort());
		InetSocketAddress localEP = new InetSocketAddress(_host, _port);
		codeForConnect(connectJP, remoteEP, localEP, Status.CONNECTING);
		return socket;
	}
				 
	 
	after(Socket _socket, InetSocketAddress _endPoint) : SocketConnectStyle5(_socket, _endPoint){			
		ConnectEventJP connectJP = new ConnectEventJP(false);
		InetSocketAddress remoteEP = _endPoint;
		InetSocketAddress localEP = new InetSocketAddress(_socket.getLocalAddress().getHostName(), _socket.getLocalPort());
		codeForConnect(connectJP, remoteEP, localEP, Status.CONNECTING);
	}
	
	after(SocketChannel _socketChannel, InetSocketAddress _remoteEP) : ChannelConnect(_socketChannel, _remoteEP){			
		/*ConnectEventJP connectJP = new ConnectEventJP(false);
		Socket socket = _socketChannel.socket();
		logger.debug(" Socket value is " + socket);
		logger.debug(" Socket local address " + socket.getLocalAddress());
		logger.debug(" Socket Inet Address address " + socket.getInetAddress());
		logger.debug(" Socket Remote EP " + _remoteEP);
		InetSocketAddress localEP = null;
		if(socket.isConnected()){
			localEP = new InetSocketAddress(socket.getInetAddress(), socket.getLocalPort());
		}
			InetSocketAddress remoteEP = _remoteEP;		
			connectJP.setRemoteEP(remoteEP);	
			codeForConnect(connectJP, remoteEP,localEP , Status.CONNECTING);	
		
		ChannelConnect(connectJP);*/
	}
	
	boolean  around(SocketChannel _socketChannel) : ChannelConnectFinish(_socketChannel){
		//Socket port is not available at the time of connect hence the findBySocket will always returns false
		// So one design is to get the channel after connect
		boolean flag = proceed(_socketChannel);
		ConnectEventJP connectJP = new ConnectEventJP(false);
		Socket socket = _socketChannel.socket();
		logger.debug(" Socket value is " + socket);
		logger.debug(" Socket local address " + socket.getLocalAddress());
		logger.debug(" Socket Inet Address address " + socket.getInetAddress());
		logger.debug(" Socket Remote EP " + socket.getPort());
		InetSocketAddress localEP = null;
		if(socket.isConnected()){
			localEP = new InetSocketAddress(socket.getInetAddress(), socket.getLocalPort());
		}
			InetSocketAddress remoteEP = new InetSocketAddress(socket.getInetAddress(), socket.getPort());	
			connectJP.setLocalEP(localEP);
			connectJP.setRemoteEP(remoteEP);	
			codeForConnect(connectJP, remoteEP,localEP , Status.CONNECTING);	
		
		ChannelConnect(connectJP);
		
		/*boolean flag = proceed(_socketChannel);
		ConnectEventJP connectJp;
		if (flag == true){
			Socket socket = _socketChannel.socket();
			ChannelJP channelJp = Session.getInstance().getConUniverse().findBySocket(new InetSocketAddress(socket.getInetAddress(), socket.getLocalPort() ) );
			if(channelJp != null){
				connectJp = channelJp.getConnectJp();
			if (connectJp != null){
				connectJp.setStatus(Status.ESTABLISHED);				
				ChannelConnectFishish(connectJp);
			}					
			}
		}*/
		return flag;
	}
						
	before(SocketChannel _socketChannel) : ClientChannelClose(_socketChannel){	
		CloseEventJP closeJP = new CloseEventJP();
		closeJP.setCloseJp(thisJoinPoint);
		Socket socket = _socketChannel.socket();
		InetSocketAddress remoteEP = null;			
		closeJP.setRemoteEP(remoteEP);			
		closeJP.setLocalEP(new InetSocketAddress(socket.getInetAddress(), socket.getLocalPort()));
		closeJP.setStatus(joinpoints.connection.CloseEventJP.Status.CLOSED);			
		closeJP.setSocket(socket);			
		CloseClientEventJointPoint(closeJP);	
	}
	
	after(Socket socket) : SocketClose(socket){
		CloseEventJP closeJP = new CloseEventJP();
		closeJP.setCloseJp(thisJoinPoint);			
		InetSocketAddress remoteEP = null;			
		closeJP.setRemoteEP(remoteEP);			
		closeJP.setLocalEP(new InetSocketAddress(socket.getInetAddress(), socket.getLocalPort()));
		closeJP.setStatus(joinpoints.connection.CloseEventJP.Status.CLOSED);			
		closeJP.setSocket(socket);			
		CloseClientEventJointPoint(closeJP);	
	}
	
	void codeForConnect(ConnectEventJP _connectJp, InetSocketAddress _remoteSocAddr, InetSocketAddress _localAddr, Status _status){
		ConnectEventJP connectJP = _connectJp;
		connectJP.setRemoteEP(_remoteSocAddr);			
		connectJP.setLocalEP(_localAddr);	
		connectJP.setStatus(_status);									
	}
	
	public void ChannelConnect(ConnectEventJP _connectJp){		
	}
	
	void ChannelConnectFishish(ConnectEventJP _connectJp){		
	}
							    	  
	private void CloseClientEventJointPoint(CloseEventJP _closeJp){		
	}
}
