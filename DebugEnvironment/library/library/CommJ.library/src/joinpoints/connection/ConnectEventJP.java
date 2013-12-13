package joinpoints.connection;

import java.net.InetSocketAddress;
import java.net.Socket;

import org.apache.log4j.Logger;
import org.aspectj.lang.JoinPoint;

public class ConnectEventJP {

	Logger logger = Logger.getLogger(ConnectEventJP.class);
	private JoinPoint connectJp;	
	private Socket socket = null;
	private InetSocketAddress localEP = null;
	private InetSocketAddress listeningEP = null;
	private InetSocketAddress remoteEP = null;
	
	private boolean isConnectionLess = false;
	public static enum Status{CONNECTING, ESTABLISHED};
	private Status status;

	public ConnectEventJP()
	{}
	
	public ConnectEventJP(boolean _isConnectionLess)
	{
		this.isConnectionLess = _isConnectionLess;
	}
	
	public JoinPoint getConnectJp() {
		return connectJp;
	}

	public void setConnectJp(JoinPoint _connectJp) {
		this.connectJp = _connectJp;
	}

	public Status getStatus()
	{
		return status;
	}

	public void setStatus(Status _value)
	{
		 status = _value;
	}
	
	public Socket getSocket() {
		return socket;
	}

	public void setSocket(Socket _socket) {
		this.socket = _socket;
	}

	public InetSocketAddress getLocalEP() {
		return localEP;
	}

	public void setLocalEP(InetSocketAddress _localEP) {
		this.localEP = _localEP;
		
	}

	public InetSocketAddress getRemoteEP() {
		return remoteEP;
	}

	public void setRemoteEP(InetSocketAddress _remoteEP) {
		this.remoteEP = _remoteEP;
	}

	public InetSocketAddress getServerlocalEP() {
		return listeningEP;
	}

	public void setServerlocalEP(InetSocketAddress _serverlocalEP) {
		this.listeningEP = _serverlocalEP;
	}
}

