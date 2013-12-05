package universe;

import java.io.Serializable;

public class Role implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public Role(String _name) {
		super();
		this.name = _name;
	}

	public String name = "";

	public String getName() {
		return name;
	}

	public void setName(String _name) {
		this.name = _name;
	}
}
