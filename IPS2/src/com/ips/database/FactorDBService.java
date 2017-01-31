package com.ips.database;


import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import com.ips.model.Client;
import com.ips.model.Debtor;
import com.ips.model.Invoice;

public class FactorDBService {
	
	private static FactorDBService instance;
	
	static  {
		instance = new FactorDBService();
		
	}
	

	private FactorDBService() {}
	

	public static FactorDBService getInstance() {
		return instance;
	}
	
	public Connection openConnection() {
		Connection connection = null;
		try {
			Class.forName(DBProperties.JDBC_SYBASE10_DRIVER);
			connection = (Connection) DriverManager.getConnection(DBProperties.CONNECTION_SYBASE10_URL, DBProperties.USERNAME_SYBASE10, DBProperties.PASSWORD_SYBASE10);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return connection;
	}
	
	
	public void releaseConnection(Connection connection) {
		try {
			if (connection != null && !connection.isClosed()) {
				connection.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public Map<String,Debtor> getDebtors() throws Exception {
		String  sql = null;
		Map<String, Debtor> map = new HashMap<String,Debtor>();
		Connection connection = null;
		try {
			connection = openConnection();
	
			sql = "SELECT sysid, name1, name2, debtorid from Debtor";
			Statement ps = connection.createStatement(); 
			
			ResultSet rs = ps.executeQuery(sql);
			
			while (rs.next()) {
				String sysid = rs.getString("sysid");
				String name1 = rs.getString("name1");
				String name2 = rs.getString("name2");
				String debtorId = rs.getString("debtorid");
				Debtor d = new Debtor(sysid,name1,name2,debtorId);
				map.put(sysid, d);
				
			} 
			
			rs.close();
			ps.close();
		} catch (Exception e) {
			throw e;
		} finally {
			releaseConnection(connection);
		}
		return map;
	}
	
	
	public Map<String,Client> getClients() throws Exception {
		Connection connection = null;
		String  sql = null;
		Map<String, Client> map = new HashMap<String,Client>();
		try {
			connection = openConnection();
	
			sql = "SELECT sysid, name1, name2  from Client";
			Statement ps = connection.createStatement();
			
			ResultSet rs = ps.executeQuery(sql);
			
			while (rs.next()) {
				String sysid = rs.getString("sysid");
				String name1 = rs.getString("name1");
				String name2 = rs.getString("name2");
				Client c = new Client(sysid,name1,name2);
				map.put(sysid, c);
				
			} 
			
			rs.close();
			ps.close();
		} catch (Exception e) {
			throw e;
		} finally {
			releaseConnection(connection);
		}
		return map;
	}
	
	public Map<String,Invoice> getInvoices(int payerid) throws Exception{
		Connection connection = null;
		String  sql = null;
		Map<String, Invoice> map = new HashMap<String,Invoice>();
		try {
			connection = openConnection();
	
			sql = "SELECT Inv.InvId, Inv.TermsOfSale, Cli.Name1, Cli.Name2, Inv.Assignment, Inv.SysId, Cli.SysId AS Expr1, Inv.PurchDate, Com.CompanyId, Inv.PoNumber"
				+ " FROM Invoice AS Inv INNER JOIN Account AS Acc ON Inv.SysAcctId = Acc.SysId"
				+ " INNER JOIN Debtor AS Dtr ON Acc.SysDtrId = Dtr.SysId"
				+ " INNER JOIN Schedules AS Sch ON Inv.SysSchedId = Sch.SysId"
				+ " INNER JOIN Relation AS Rel ON Inv.SysRelId = Rel.SysId"
				+ " INNER JOIN Client AS Cli ON Rel.SysClientId = Cli.SysId" 
				+ " INNER JOIN Company AS Com ON Cli.SysCompId = Com.SysId"
				+ " WHERE (Dtr.DebtorId = " + payerid + ") AND (Inv.Status = 'ACTI') AND (Acc.Repossession = 'N')"
				+ " ORDER BY Com.CompanyId, Inv.DueDate";
			
			Statement ps = connection.createStatement();
			
			ResultSet rs = ps.executeQuery(sql);
			
			while (rs.next()) {
				
				Invoice i = new Invoice();
				
				String sysid = rs.getString("sysid");
				i.setInvoiceSysId(sysid);
				i.setClientSysId(rs.getString("expr1"));
				i.setInvoiceId(rs.getString("invid"));
				String tos = rs.getString("termsofsale");
				Date pd = rs.getDate("purchdate", Calendar.getInstance());
				String status = getStatus(tos,pd);
				
				i.setTermsOfSale(tos);
				i.setPurchaseDate(pd);
				i.setStatus(status);
				
				String name1 = rs.getString("name1");
				String name2 = rs.getString("name2");
				String clientName = name1 + " " + name2;
				
				i.setClientName(clientName);
				
				i.setAssignment(rs.getString("assignment"));
				i.setCompanyId(rs.getString("companyid"));
				i.setPoNumber(rs.getString("ponumber"));
				
				map.put(sysid, i);
				
			} 
			
			rs.close();
			ps.close();
		} catch (Exception e) {
			throw e;
		} finally {
			releaseConnection(connection);
		}
		return map;
	}
	
	public static boolean isBetween(long x, int lower, int upper) {
		  return lower <= x && x <= upper;
	}
	
	private String getStatus(String tos, Date pd) {
		
		String st = "Current";
	    if (tos == null) return st;
		Calendar c = Calendar.getInstance();
		long diffms = c.getTimeInMillis() - pd.getTime();
		long dtdiff = TimeUnit.DAYS.convert(diffms, TimeUnit.MILLISECONDS);
		if ( tos.equalsIgnoreCase("DUE on Receipt") || tos.equalsIgnoreCase("net 14") || tos.equalsIgnoreCase("net 15") ) {
			if (isBetween(dtdiff, 15, 29)) { 
				st = "Due";
			} else if (isBetween(dtdiff, 30, 44)) {
				st = "Overdue";
			} else if (dtdiff >= 45) {
				st = "Delinquent";
			}
		} else if (tos.equalsIgnoreCase("net 20")) {
			if (isBetween(dtdiff, 20, 34)) { 
				st = "Due";
			} else if (isBetween(dtdiff, 35, 49)) {
				st = "Overdue";
			} else if (dtdiff >= 50) {
				st = "Delinquent";
			}		
		} else if (tos.equalsIgnoreCase("net 30")) {
			if (isBetween(dtdiff, 23, 44)) { 
				st = "Due";
			} else if (isBetween(dtdiff, 45, 59)) {
				st = "Overdue";
			} else if (dtdiff >= 60) {
				st = "Delinquent";
			}			
		} else if (tos.equalsIgnoreCase("net 45")) {
			if (isBetween(dtdiff, 45, 59)) { 
				st = "Due";
			} else if (isBetween(dtdiff, 60, 74)) {
				st = "Overdue";
			} else if (dtdiff >= 75) {
				st = "Delinquent";
			}			
		} else if (tos.equalsIgnoreCase("net 60")) {
			if (isBetween(dtdiff, 60, 74)) { 
				st = "Due";
			} else if (isBetween(dtdiff, 75, 89)) {
				st = "Overdue";
			} else if (dtdiff >= 90) {
				st = "Delinquent";
			}			
		} else if (tos.equalsIgnoreCase("net 90")) {
			if (isBetween(dtdiff, 90, 104)) { 
				st = "Due";
			} else if (isBetween(dtdiff, 105, 119)) {
				st = "Overdue";
			} else if (dtdiff >= 120) {
				st = "Delinquent";
			}		
		}
		
		return st;
	}
	
	public Invoice getInvoice(String sysid) throws Exception {
		Connection connection = null;
		String  sql = null;
		Invoice i = null;
		try {
			connection = openConnection();
	
			sql = "SELECT invid from Invoice where sysid = " + sysid;
			Statement ps = connection.createStatement();
			ResultSet rs = ps.executeQuery(sql);
			
			if (rs.next()) {
				String invoiceId = rs.getString("invid");
				i = new Invoice();
				i.setInvoiceId(invoiceId);
			}
			
			rs.close();
			ps.close();
		} catch (Exception e) {
			throw e;
		} finally {
			releaseConnection(connection);
		}
		return i;
	}
	
	public Debtor getEmails(String debtorSysId) throws Exception {
		Connection connection = null;
		String  sql = null;
		Debtor d = null;
		try {
			connection = openConnection();		
			
			sql = "SELECT     Deb.SysId, Deb.DebtorId, Deb.Name1, Deb.Name2, LOWER(ISNULL(Com.Email, '')) AS 'ContactEMail', LOWER(ISNULL(Csh.Email, '')) AS 'Contact2EMail'" 
			+ " FROM Debtor AS Deb "
			+ " LEFT OUTER JOIN Address AS Adr ON Deb.SysId = Adr.SysParentId"
			+ " LEFT OUTER JOIN "
			+ " (SELECT Con.SysParentId, Con.Name1, Adr.Email, Con.Title "
			+ " FROM Contact AS Con INNER JOIN Address AS Adr ON Con.SysId = Adr.SysParentId"
			+ " WHERE (Con.ParentTable = 'DEBTOR') AND (Con.ContactType = 'MAIN') AND (Adr.ParentTable = 'CONTACT') AND (Adr.AddressType = 'MAIN'))"
			+ " AS Com ON Deb.SysId = Com.SysParentId LEFT OUTER JOIN"
			+ " (SELECT     Con.SysParentId, Con.Name1, Adr.Email, Con.Title"
            + " FROM Contact AS Con INNER JOIN Address AS Adr ON Con.SysId = Adr.SysParentId"
            + " WHERE (Con.ParentTable = 'DEBTOR') AND (Con.ContactType = 'SHIP') AND (Adr.ParentTable = 'CONTACT') AND (Adr.AddressType = 'MAIN'))"
            + " AS Csh ON Deb.SysId = Csh.SysParentId "
            + " LEFT OUTER JOIN Debtor AS Dpa ON Deb.SysId = Dpa.SysId"
            + " WHERE (Deb.SysId = " + debtorSysId + ") AND (Adr.ParentTable = 'DEBTOR') AND (Adr.AddressType = 'MAIN')";
			
			Statement ps = connection.createStatement();
			ResultSet rs = ps.executeQuery(sql);
			
			if (rs.next()) {
				String name1 = rs.getString("Name1");
				String name2 = rs.getString("Name2");
				String sysId = rs.getString("SysId");
				String debtorId = rs.getString("DebtorId");
				d = new Debtor(sysId, name1, name2, debtorId);
				
				String c1 = rs.getString("ContactEMail");
				String c2 = rs.getString("Contact2EMail");
				
				d.setContactEmail(c1);
				d.setContact2Email(c2);
			}
			
			rs.close();
			ps.close();
		} catch (Exception e) {
			throw e;
		} finally {
			releaseConnection(connection);
		}
		return d;
	}
	
	
}
