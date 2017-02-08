package com.ips.model;

public class Client {
	private String sysid;
	private String name1;
	private String name2;

	public Client() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Client(String sysid, String name1, String name2) {
		super();
		this.sysid = sysid;
		this.name1 = name1;
		this.name2 = name2;
	}

	public String getSysid() {
		return sysid;
	}

	public void setSysid(String sysid) {
		this.sysid = sysid;
	}

	public String getName1() {
		return name1;
	}

	public void setName1(String name1) {
		this.name1 = name1;
	}

	public String getName2() {
		return name2;
	}

	public void setName2(String name2) {
		this.name2 = name2;
	}
	
	

}
