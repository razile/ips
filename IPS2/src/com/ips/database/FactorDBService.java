package com.ips.database;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;
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
			PreparedStatement ps = connection.prepareStatement(sql);
			
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
			PreparedStatement ps = connection.prepareStatement(sql);
			
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
	
	public Invoice getInvoice(String sysid) throws Exception {
		Connection connection = null;
		String  sql = null;
		Invoice i = null;
		try {
			connection = openConnection();
	
			sql = "SELECT invid from Invoice where sysid = ?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, sysid);
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
	
	
}
