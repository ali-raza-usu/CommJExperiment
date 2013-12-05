package utilities.messages.ver1;

import utilities.Message;

public class FileTransferRequest extends Message {

	private String fileIndex = "";
	private String fileNames = "";

	public FileTransferRequest(String fileIndex, String fileNames) {
		this.setVersion("1.0");
		this.fileIndex = fileIndex;
		this.fileNames = fileNames;
	}

	public String getFileIndex() {
		return fileIndex;
	}

	public void setFileIndex(String fileName) {
		this.fileIndex = fileName;
	}

	public String getFileNames() {
		return fileNames;
	}

	public void setFileNames(String fileNames) {
		this.fileNames = fileNames;
	}

}
