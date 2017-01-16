package ProcessAcctData;

import java.sql.Connection;
import java.sql.DriverManager;
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
		
		Class.forName("net.sourceforge.jtds.jdbc.Driver");
		connection = (Connection) DriverManager.getConnection(connectionURL, username, password);
		
		return null;
	}
	
	
	public Map<String,Client> getClients() throws Exception {
		Connection connection = null;
		String  sql = null;
		
		Class.forName("net.sourceforge.jtds.jdbc.Driver");
		connection = (Connection) DriverManager.getConnection(connectionURL, username, password);
		
		
		return null;
	}
	
	public Invoice getInvoice(String sysid) {
		return null;
	}
	
	
}
