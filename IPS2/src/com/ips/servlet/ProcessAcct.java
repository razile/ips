package com.ips.servlet;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//import net.sourceforge.jtds.jdbc.Driver;

import com.ips.database.DBProperties;
import com.ips.database.SqlServerDBService;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.io.*;

//import java.sql.*;
//import com.mysql.jdbc.Connection;
//import com.mysql.jdbc.PreparedStatement;

/**
 * Servlet implementation class ProcessAcct
 */
public class ProcessAcct extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProcessAcct() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// response.setContentType("text/html");
		// PrintWriter pw = response.getWriter();
		int testline = 0;
		ServletContext context = getServletContext();
		String ids = "";
		String acctid = "";
	
		String act = request.getParameter("act");
		String payerId = request.getParameter("PayerId");
		String sql = "aaa=" + act; // is
		Connection connection = null;
		try // the
			// database
		{
			connection = SqlServerDBService.getInstance().openConnection();

			sql = "aaab";

			if (act.equals("Add") || act.equals("Update")) {
				sql = "bbb";
				acctid = request.getParameter("AcctId");

				String trNo = request.getParameter("transit");
				String brNo = request.getParameter("branch");
				String atNo = request.getParameter("account");
				String crTp = request.getParameter("currency");

				if (acctid != "") {
					PreparedStatement pst = (PreparedStatement) connection
							.prepareStatement("update payersaccounts set transitNumber=?,BranchCode=?,AccountNumber=?,CurrencyType=? where SysId=?");// try2
																																						// is
																																						// the
																																						// name
																																						// of
																																						// the
																																						// table
					pst.setString(1, trNo);
					pst.setString(2, brNo);
					pst.setString(3, atNo);
					pst.setString(4, crTp);
					pst.setString(5, acctid);
					sql = "cccpayerid=" + payerId + "=trno=" + trNo + "=brno="
							+ brNo + "=atno=" + atNo + "=cRtP=" + crTp;

					int i = pst.executeUpdate();
					connection.close();
				} else {
					sql = "payerid=" + payerId + "=trno=" + trNo + "=brno="
							+ brNo + "=atno=" + atNo + "=cRtP=" + crTp;
					PreparedStatement ps = (PreparedStatement) connection
							.prepareStatement("select Sysid from payersaccounts where AccountNumber = '"
									+ atNo + "'");
					ResultSet rs = ps.executeQuery();
					if (!rs.next()) {
						PreparedStatement pst = (PreparedStatement) connection
								.prepareStatement("insert into payersaccounts(PayerId,TransitNumber,BranchCode,AccountNumber,CurrencyType,Active) values(?,?,?,?,?,?)");// try2
						pst.setString(1, payerId);
						pst.setString(2, trNo);
						pst.setString(3, brNo);
						pst.setString(4, atNo);
						pst.setString(5, crTp);
						pst.setString(6, "1");
						int i = pst.executeUpdate();
						connection.close();
					}
				}
			} else if (act.equals("Delete")) {
				ids = request.getParameter("AcctId2");
				testline = 2;
				/*
				 * String[] checked = request.getParameterValues("AcctChk"); if
				 * (checked !=null && checked.length >0){ for (int i = 0; i <
				 * checked.length; i++) { ids=ids+checked[i]; if
				 * (i<(checked.length-1)) ids=ids+","; } }
				 */
				if (ids.length() > 0) {
					testline = 3;
					PreparedStatement pst = (PreparedStatement) connection
							.prepareStatement("update payersaccounts set Active =0 where SysId in ("
									+ ids + ")");// try2 is the name of the
					testline = 4;
					int i = pst.executeUpdate();
					sql = "select payerid from payersaccounts where sysid = '"
							+ ids + "'";
					PreparedStatement ps = (PreparedStatement) connection
							.prepareStatement(sql);
					ResultSet rs = ps.executeQuery();
					while (rs.next()) {
						payerId = rs.getString("payerid");
					}
					testline = 5;
					connection.close();
					testline = 6;
				}
			} else if (act.equals("Edit")) {
				response.setContentType("text/html");
				PrintWriter pw = response.getWriter();
				String actId = request.getParameter("AcctId");
				pw.println(actId);
			}

			/*
			 * if(i!=0){ pw.println("<br>Record has been inserted");
			 * 
			 * } else{ pw.println("failed to insert the data"); }
			 */
			// if (acctid=="")
			// response.setContentType("text/html");
			// PrintWriter pw2 = response.getWriter();
			// pw2.println("pyid="+payerId);
			// String path = context.getInitParameter("IPS2Path").toString();
			request.setAttribute("pyid", payerId.toString());
			request.getRequestDispatcher("ManageAccounts.jsp").forward(request,
					response);
		}

		catch (Exception e) {
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			PrintWriter pw = new PrintWriter(baos);
			e.printStackTrace(pw);
			String stackTrace = new String(baos.toByteArray());

			// context.log("Error received:",new
			// IllegalStateException(stackTrace));

			response.setContentType("text/html");
			PrintWriter pw2 = response.getWriter();
			StringWriter errors = new StringWriter();
			e.printStackTrace(new PrintWriter(errors));
			pw2.println("class=" + act + "=" + ids + "=" + testline + "SQL="
					+ sql + "Payerid=" + payerId);
			pw2.println(errors.toString());
		} finally {
			SqlServerDBService.getInstance().releaseConnection(connection);
		}

	}

}
