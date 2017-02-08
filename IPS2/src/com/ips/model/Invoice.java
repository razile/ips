package com.ips.model;

import java.sql.Date;

public class Invoice {

	private String invoiceId;
	private String termsOfSale;
	private Date purchaseDate;
	private String clientName;
	private String assignment;
	private String invoiceSysId;
	private String clientSysId;
	private String companyId;
	private String poNumber;
	private String status;
	
	

	public Invoice() {
		super();
		// TODO Auto-generated constructor stub
	}

	public String getInvoiceId() {
		return invoiceId;
	}

	public void setInvoiceId(String invoiceId) {
		this.invoiceId = invoiceId;
	}

	public String getTermsOfSale() {
		return termsOfSale;
	}

	public void setTermsOfSale(String termsOfSale) {
		this.termsOfSale = termsOfSale;
	}

	public Date getPurchaseDate() {
		return purchaseDate;
	}

	public void setPurchaseDate(Date purchaseDate) {
		this.purchaseDate = purchaseDate;
	}

	public String getClientName() {
		return clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

	public String getAssignment() {
		return assignment;
	}

	public void setAssignment(String assignment) {
		this.assignment = assignment;
	}

	public String getInvoiceSysId() {
		return invoiceSysId;
	}

	public void setInvoiceSysId(String invoiceSysId) {
		this.invoiceSysId = invoiceSysId;
	}

	public String getClientSysId() {
		return clientSysId;
	}

	public void setClientSysId(String clientSysId) {
		this.clientSysId = clientSysId;
	}

	public String getCompanyId() {
		return companyId;
	}

	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}

	public String getPoNumber() {
		return poNumber;
	}

	public void setPoNumber(String poNumber) {
		this.poNumber = poNumber;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	
	
	
	
}
