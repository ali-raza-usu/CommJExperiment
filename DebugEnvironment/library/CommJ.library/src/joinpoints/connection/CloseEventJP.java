package joinpoints.connection;

import java.net.InetSocketAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.nio.channels.ServerSocketChannel;

import joinpoints.communication.CommunicationEventJP;
import joinpoints.connection.ConnectEventJP.Status;

import org.aspectj.lang.JoinPoint;


public class CloseEventJP extends CommunicationEventJP{

	private JoinPoint jP = null;	
	private InetSocketAddress localEP = null;
	private InetSocketAddress remoteEP = null;
	private Object socket = null;
  //Introduce a channelJP in both the close and connect JP
	public static enum Status{CLOSED};
	private Status status;
	
	public JoinPoint getCloseJp() {
		return jP;
	}

	public void setCloseJp(JoinPoint _jP) {
		this.jP = _jP;
	}

	public Object getSocket() {
		return socket;
	}

	public void setSocket(Object _socket) {
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

	public Status getStatus() {
		return status;
	}

	public void setStatus(Status _status) {
		status = _status;
	}
}
