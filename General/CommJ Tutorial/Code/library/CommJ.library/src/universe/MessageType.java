package universe;

import java.io.Serializable;

public class MessageType implements Serializable {

	private static final long serialVersionUID = 1L;
	private String type;

	public MessageType()
	{}
	
	public MessageType(String _type)
	{
		this.type = _type;
	}
	public String getType() {
		return type;
	}

	public void setType(String _type) {
		this.type = _type;
	}
}
