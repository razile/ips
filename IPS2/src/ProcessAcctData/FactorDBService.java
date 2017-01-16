package ProcessAcctData;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

public class FactorDBService {

	private final String connectionURL = "jdbc:sybase:Tds:192.168.10.11:2638/factorsql_dbserver/Factor";
	private final String username = "admin";
	private final String password = "adminco";
	
	private static FactorDBService instance;
	
	static  {
		instance = new FactorDBService();
		
	}
	

	private FactorDBService() {}
	

	public static FactorDBService getInstance() {
		return instance;
	}
	
	public Map<String,Debtor> getDebtors() throws Exception {
		Connection connection = null;
		String  sql = null;
		Map<String, Debtor> map = new HashMap<String,Debtor>();
		try {
			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			connection = (Connection) DriverManager.getConnection(connectionURL, username, password);
	
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
			if (connection != null) {
				connection.close();
			}
		}
		return map;
	}
	
	
	public Map<String,Client> getClients() throws Exception {
		Connection connection = null;
		String  sql = null;
		Map<String, Client> map = new HashMap<String,Client>();
		try {
			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			connection = (Connection) DriverManager.getConnection(connectionURL, username, password);
	
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
			if (connection != null) {
				connection.close();
			}
		}
		return map;
	}
	
	public Invoice getInvoice(String sysid) throws Exception {
		Connection connection = null;
		String  sql = null;
		Invoice i = null;
		try {
			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			connection = (Connection) DriverManager.getConnection(connectionURL, username, password);
	
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
			if (connection != null) {
				connection.close();
			}
		}
		return i;
	}
	
	
}
