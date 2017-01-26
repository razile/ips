package com.ips.database;


import java.sql.Connection;
import java.sql.DriverManager;


public class SqlServerDBService {
	
	private static SqlServerDBService instance;
	
	static  {
		instance = new SqlServerDBService();
		
	}
	

	private SqlServerDBService() {}
	

	public static SqlServerDBService getInstance() {
		return instance;
	}
	
	public Connection openConnection() {
		Connection connection = null;
		try {
			Class.forName(DBProperties.JDBC_SQLSERVER_DRIVER);
			connection = (Connection) DriverManager.getConnection(DBProperties.CONNECTION_SQLSERVER_URL, DBProperties.USERNAME_SQLSERVER, DBProperties.PASSWORD_SQLSERVER);
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
	
	
}
