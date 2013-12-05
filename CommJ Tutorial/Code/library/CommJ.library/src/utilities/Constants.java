package utilities;

import java.io.FileInputStream;
import java.util.Properties;

public class Constants {

	 static Properties props = new Properties();
	 public static long TimeToWait = 0; 
	 public final static String EventSpecification = "EventSpecificaiton";
	 public final static String ThreadSpecification = "ThreadSpecification";
	 public final static String MessageSpecification = "MessageSpecificaiton";
	 
	 public final static String Node = "Node";
	 public final static String Process = "Process";
	 public final static String Thread = "CommunicationThread";
	 public final static String CommunicationChannel = "CommunicationChannel";
	 public final static String Event = "Event";
	 public final static String CommunicationEvent = "CommunicationEvent";
	 public final static String CommunicationSendEvent = "CommunicationSendEvent";
	 public final static String CommunicationReceiveEvent = "CommunicationReceiveEvent";
	 public final static String ExceptionThrownEvent = "ExceptionThrownEvent";
	 public final static String OtherEvent = "OtherEvent";
	 public final static String Message = "Messange";
	 public final static String SendMessage = "S";
	 public final static String ReceiveMessage = "R";
	 public final static String Timestamp = "Timestamp";
	 public final static String EventType = "EventType";
	 
	 
	public static void loadProperties()
	{
		String path = "C:\\Users\\aliraza\\Desktop\\Office\\CS7930 AoP\\implementation\\TMLFramework\\src\\tml\\bugs\\utilities\\";
	       try {
			props.load(new FileInputStream(path+"constants.properties"));
		} catch (Exception e) {
			e.printStackTrace();
		}			
			TimeToWait = Long.parseLong(props.getProperty("TimeToWait"));	            
	}
}
