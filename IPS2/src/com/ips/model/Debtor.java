package com.ips.model;

public class Debtor {

	private String sysid;
	private String name1;
	private String name2;
	private String debtorId;
	private String contactEmail;
	private String contact2Email;

	public Debtor() {
		super();
		// TODO Auto-generated constructor stub
	}

	
	public Debtor(String sysid, String name1, String name2, String debtorId) {
		super();
		this.sysid = sysid;
		this.name1 = name1;
		this.name2 = name2;
		this.debtorId = debtorId;
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

	public String getDebtorId() {
		return debtorId;
	}

	public void setDebtorId(String debtorId) {
		this.debtorId = debtorId;
	}


	public String getContactEmail() {
		return contactEmail;
	}


	public void setContactEmail(String contactEmail) {
		this.contactEmail = contactEmail;
	}


	public String getContact2Email() {
		return contact2Email;
	}


	public void setContact2Email(String contact2Email) {
		this.contact2Email = contact2Email;
	}
	
	

}
