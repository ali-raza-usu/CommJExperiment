package communication;


import joinpoints.communication.ReceiveEventJP;
import joinpoints.communication.SendEventJP;

import org.apache.log4j.Logger;

import baseaspects.communication.OneWaySendAspect;
import universe.*;
import utilities.Encoder;
import utilities.IMessage;

public aspect VersionControlAspect  extends OneWaySendAspect{
	
	private Logger logger = Logger.getLogger(VersionControlAspect.class);
	pointcut main() : execution(void *.main(..));
	private String version = "1.1";

		void around(SendEventJP _sendJp): MessageSend(_sendJp){
			IMessage msg = Encoder.decode(_sendJp.getBytes());			
			if(Double.parseDouble(msg.getVersion()) < Double.parseDouble(version)){
				logger.debug("MessageSend(mjp) : changing to new version");
				_sendJp.setBytes(msg.getNewVersion(msg).getBytes());
			}     
			else
				logger.debug("MessageSend(mjp) : Not a new version ");
			logger.debug("end Version Control");
			proceed(_sendJp);
		}


	
		void around(ReceiveEventJP _receiveJp) : MessageRecieve(_receiveJp)
		{	
			IMessage msg = Encoder.decode(_receiveJp.getBytes());
			logger.debug("Receive: Versions are curr/req : " + Double.parseDouble(msg.getVersion()) +" "+Double.parseDouble(version ));
			if(Double.parseDouble(msg.getVersion()) < Double.parseDouble(version)){
				logger.debug("Message Received : using old version : now raising event ");
				_receiveJp.setBytes(msg.getNewVersion(msg).getBytes());
			}
			proceed(_receiveJp);
		}
	}
	 

