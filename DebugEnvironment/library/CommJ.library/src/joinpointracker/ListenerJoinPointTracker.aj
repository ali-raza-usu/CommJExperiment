	package joinpointracker;


import java.nio.channels.DatagramChannel;
import java.nio.channels.ServerSocketChannel;
import java.nio.channels.SocketChannel;
import java.net.InetSocketAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.SocketAddress;
import java.rmi.Remote;

import joinpoints.connection.CloseEventJP;
import joinpoints.connection.ConnectEventJP;
import joinpoints.connection.ConnectEventJP.Status;
import org.apache.log4j.Logger;

	 public aspect ListenerJoinPointTracker {
	 	 
		 private Logger logger = Logger.getLogger(ListenerJoinPointTracker.class);
		 
					
		//===========================================LISTENER============================================		 		 
		//Socket related pointcut for Listner
		 private pointcut SocketAccept(Socket _socket, InetSocketAddress _remoteEP): 
			 							call(* Socket+.accept(..)) && target(_socket) && args(_remoteEP);
		 
		 //Channel related pointcut for Listner
		 pointcut ChannelAccept(ServerSocketChannel _serverSocketChannel) : 
										call(* ServerSocketChannel+.accept()) && target(_serverSocketChannel) ;	 		 	    

		 //Channel-related pointcuts for Close and connection-orient communication channel						
		 pointcut ChannelClose(ServerSocketChannel _serverSocketChannel) :
										call(* ServerSocketChannel.close()) && target(_serverSocketChannel);			 
		 //Datagram Channel related pointcut for Listner
		 public pointcut ChannelOpen(DatagramChannel _channel, SocketAddress _addr) : 
				call(* DatagramChannel.bind(..)) && target(_channel) && args(_addr);	 		 	    

	
		after(Socket _socket, InetSocketAddress _remoteEP) : SocketAccept(_socket, _remoteEP){		
			ConnectEventJP connectEventJoinPoint = new ConnectEventJP(false);
			InetSocketAddress localEP = new InetSocketAddress(_socket.getInetAddress(), _socket.getLocalPort());				
			codeForConnect(connectEventJoinPoint, _remoteEP, localEP, Status.CONNECTING);
			ChannelAccept(connectEventJoinPoint);									
		}
		
		SocketChannel around(ServerSocketChannel _serverSocketChannel) : ChannelAccept(_serverSocketChannel){
			SocketChannel socketChannel = proceed(_serverSocketChannel);
			ConnectEventJP connectEventJoinPoint = new ConnectEventJP(false);			
			InetSocketAddress localEP = new InetSocketAddress(socketChannel.socket().getLocalPort());
			InetSocketAddress remoteEP = new InetSocketAddress(socketChannel.socket().getPort());
			try {		
				InetSocketAddress serverLocalEP = new InetSocketAddress(_serverSocketChannel.socket().getInetAddress(), _serverSocketChannel.socket().getLocalPort());
				connectEventJoinPoint.setServerlocalEP(serverLocalEP);
			} catch (Exception e) {}
			connectEventJoinPoint.setSocket(socketChannel.socket());
			codeForConnect(connectEventJoinPoint, remoteEP, localEP, Status.CONNECTING);
			ChannelAccept(connectEventJoinPoint);						
			return socketChannel;
        }

		DatagramChannel around(DatagramChannel _channel, SocketAddress _addr) : ChannelOpen( _channel, _addr){
			DatagramChannel dgChannel = proceed(_channel,_addr);
			ConnectEventJP connectEventJoinPoint = new ConnectEventJP(true);
			InetSocketAddress localEP = new InetSocketAddress(dgChannel.socket().getLocalPort());
			InetSocketAddress remoteEP = null;//new InetSocketAddress(dgChannel.socket().getPort());
			try {		
				InetSocketAddress serverLocalEP = new InetSocketAddress(dgChannel.socket().getInetAddress(), dgChannel.socket().getLocalPort());
				connectEventJoinPoint.setServerlocalEP(serverLocalEP);
			} catch (Exception e) {}
			codeForConnect(connectEventJoinPoint, remoteEP, localEP, Status.CONNECTING);
			ChannelAccept(connectEventJoinPoint);						
			return dgChannel;
        }
		
		before(ServerSocketChannel _serverSocketChannel) : ChannelClose(_serverSocketChannel){
			CloseEventJP closeJP = new CloseEventJP();
			closeJP.setCloseJp(thisJoinPoint);
			ServerSocket serverSocket = _serverSocketChannel.socket();
			InetSocketAddress remoteEP = null;			
			closeJP.setRemoteEP(remoteEP);			
			closeJP.setLocalEP(new InetSocketAddress(serverSocket.getInetAddress(), serverSocket.getLocalPort()));
			closeJP.setStatus(joinpoints.connection.CloseEventJP.Status.CLOSED);			
			closeJP.setSocket(serverSocket);		
			CloseServerEventJointPoint(closeJP);			
		}
		
		void codeForConnect(ConnectEventJP _connectJp, InetSocketAddress _remoteSocAddr, InetSocketAddress _localAddr, Status _status){
			ConnectEventJP connectJP = _connectJp;
			connectJP.setRemoteEP(_remoteSocAddr);
			connectJP.setLocalEP(_localAddr);
			connectJP.setStatus(_status);									
		}
		
		public void ChannelAccept(ConnectEventJP _connectJP){			
		}
		
										    	  
		private void CloseServerEventJointPoint(CloseEventJP _closeJp){
		}
		
	 }

	 