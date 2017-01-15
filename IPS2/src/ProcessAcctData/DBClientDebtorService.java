package ProcessAcctData;

import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Map;

public class DBClientDebtorService {

	private final String connectionURL = "jdbc:sybase:Tds:192.168.10.11:2638/factorsql_dbserver/Factor";
	private final String username = "admin";
	private final String password = "adminco";
	
	private static DBClientDebtorService instance;
	
	static  {
		instance = new DBClientDebtorService();
		
	}
	

	private DBClientDebtorService() {}
	

	public static DBClientDebtorService getInstance() {
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
	
	
}
