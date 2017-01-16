package ProcessAcctData;

import java.awt.Color;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.DriverManager;
import java.sql.SQLException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//import com.sun.mail.smtp.SMTPSaslAuthenticator;
import com.sun.mail.smtp.*;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.text.DateFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;

import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.CMYKColor;
import com.lowagie.text.pdf.ColumnText;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPageEventHelper;
import com.lowagie.text.pdf.PdfWriter;
import com.lowagie.text.Cell;
import com.lowagie.text.Chapter;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.HeaderFooter;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.Rectangle;
import com.lowagie.text.Section;
import com.lowagie.text.Table;

import javax.mail.AuthenticationFailedException;
import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.*;
import javax.mail.*;

import java.util.*;
import java.io.*;
import java.net.*;

import javax.activation.DataSource;
import javax.activation.DataHandler;
import javax.mail.internet.InternetAddress;

/**
 * Servlet implementation class InvoicePayment
 */
public class InvoicePaymentf extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public InvoicePaymentf() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected String adminEmail = null;
	public javax.servlet.ServletContext sc = null;

	public void init(ServletConfig servletConfig) throws ServletException {
		this.adminEmail = servletConfig.getInitParameter("email");
		sc = servletConfig.getServletContext();
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
		int level = 0;
		String acctid = "";
		String payerid = "";
		Connection connection = null;
		try {

			String act = request.getParameter("act");
			String transId = request.getParameter("transId");
			int id = 0;
			int counter = 0;
			
			Class.forName(DBProperties.JDBC_SQLSERVER_DRIVER);
			connection = (Connection) DriverManager.getConnection(DBProperties.CONNECTION_SQLSERVER_URL, DBProperties.USERNAME_SQLSERVER, DBProperties.PASSWORD_SQLSERVER);
		
			acctid = request.getParameter("AcctId");
			String invNo = request.getParameter("invoiceNumber");
			String payee = request.getParameter("payee");
			String amount = request.getParameter("amount");
			String discount = request.getParameter("discount");
			String payment = request.getParameter("paymentAmount");
			String comments = request.getParameter("comments");
			String accountid = request.getParameter("account");
			// String accounnum = request.getParameter("account");
			DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			Date date = new Date();
			// System.out.println(dateFormat.format(date));
			String invoicedate = dateFormat.format(date);// request.getParameter("datepicker");
			String totalpayment = request.getParameter("totalPayment");
			String totalpaymentoriginal = totalpayment;
			totalpayment = totalpayment.substring(1);
			totalpayment = totalpayment.replaceAll(",", "");
			String currency = request.getParameter("currency");
			int loop = Integer.parseInt(request.getParameter("counter"));
			level = 1;
			if (transId != null && transId.length() > 0) {
				level = 2;
				id = Integer.parseInt(transId);
				PreparedStatement ps = (PreparedStatement) connection
						.prepareStatement("update invoicetransaction set SysAcctId = ?,InvoiceAmount=?,CurrencyType=?,InvoicePaymentDate =? where SysId=?");
				// (SysAcctId,InvoiceAmount,CurrencyType,InvoicePaymentDate)values(?,?,?,?)RETURNING
				// SysId into ?");
				ps.setString(1, accountid);
				ps.setString(2, totalpayment);
				ps.setString(3, currency);
				ps.setString(4, invoicedate);
				ps.setString(5, transId);
				ps.execute();
				while (counter < loop) {
					String name = "invoiceid" + counter;
					String checkname = "paycheck" + counter;
					String val = request.getParameter(checkname);
					if (val != null && val.equals("on")
							&& request.getParameter(name) != null
							&& request.getParameter(name) != "") {
						CallableStatement ps2 = connection
								.prepareCall("{call Update_InvoicePayment(?,?,?,?,?,?)}");
						ps2.setString(1, String.valueOf(id));
						name = "invoiceid" + counter;
						ps2.setString(2, request.getParameter(name));
						name = "clientid" + counter;
						ps2.setString(3, request.getParameter(name));
						name = "amount" + counter;
						ps2.setString(4, request.getParameter(name));
						name = "paymentamount" + counter;
						ps2.setString(5, request.getParameter(name));
						name = "paymentComment" + counter;
						ps2.setString(6, request.getParameter(name));
						ps2.execute();

					} else {
						PreparedStatement ps3 = connection
								.prepareStatement("delete from invoicepayment where invoicetransactionid=? and invoicenumber=?");
						ps3.setString(1, String.valueOf(transId));
						name = "invoiceid" + counter;
						ps3.setString(2, request.getParameter(name));
						ps3.execute();

					}

					counter = counter + 1;

				}
				if ((request.getParameter("paymentAmount") != null)
						&& (request.getParameter("paymentAmount").trim() != "")) {
					CallableStatement cs4 = connection
							.prepareCall("{call Update_InvoicePayment(?,?,?,?,?,?)}");
					cs4.setString(1, String.valueOf(id));
					cs4.setString(2, request.getParameter("invoiceNumber"));
					cs4.setString(3, request.getParameter("payee"));
					cs4.setString(4, request.getParameter("amount"));
					cs4.setString(5, request.getParameter("paymentAmount"));
					cs4.setString(6, request.getParameter("comments"));
					cs4.execute();
				}

			} else {

				// if (act.equals("insert")){

				// CallableStatement pst =
				// connection.prepareCall("insert into Invoicetransaction(SysAcctId,InvoiceAmount,CurrencyType,InvoicePaymentDate)values(?,?,?,?)RETURNING SysId into ?");
				// insert into
				// InvoicePayment(InvoiceNumber,Payee,Amount,DiscountCredit,PaymentAmount,Comments,AccountId,InvoiceDate,status)values(?,?,?,?,?,?,?,?,?)"

				CallableStatement cs = connection
						.prepareCall("{call InsertInvoice(?,?,?,?,?,?)}");
				cs.setString(1, accountid);
				cs.setString(2, totalpayment);
				cs.setString(3, currency);
				cs.setString(4, invoicedate);
				cs.registerOutParameter(5, java.sql.Types.INTEGER);
				cs.registerOutParameter(6, java.sql.Types.VARCHAR);
				cs.execute();
				id = cs.getInt(5);
				String accountnum = cs.getString(6);

				while (counter < loop) {
					String name = "invoiceid" + counter;
					String checkname = "paycheck" + counter;
					String val = request.getParameter(checkname);
					if (val != null && val.equals("on")
							&& request.getParameter(name) != null
							&& request.getParameter(name) != "") {
						PreparedStatement ps = connection
								.prepareStatement("insert into invoicepayment (invoicetransactionid, InvoiceNumber, PaymentAmount,payee,Amount,comments,InvId) values (?,?,?,?,?,?,?)");
						ps.setString(1, String.valueOf(id));
						name = "invoiceid" + counter;
						ps.setString(2, request.getParameter(name));
						// name="amount" + counter;
						// ps.setString(3,request.getParameter(name));
						name = "paymentamount" + counter;
						String pa = request.getParameter(name);
						pa = pa.replaceAll(",", "");
						ps.setString(3, pa);
						// ps.setString(3,request.getParameter(name));
						name = "clientid" + counter;
						ps.setString(4, request.getParameter(name));
						name = "amount" + counter;
						ps.setString(5, request.getParameter(name));
						name = "paymentComment" + counter;
						ps.setString(6, request.getParameter(name));
						name = "invoiceNumber" + counter;
						ps.setString(7, request.getParameter(name));
						ps.execute();

					}
					counter = counter + 1;

				}

				// insert into
				// InvoicePayment(InvoiceNumber,Payee,Amount,DiscountCredit,PaymentAmount,Comments,AccountId,InvoiceDate,status)values(?,?,?,?,?,?,?,?,?)"
				String checkname = "paycheckextra";
				String val = request.getParameter(checkname);
				if (val != null && val.equals("on")) {
					if ((request.getParameter("paymentAmount") != null)
							&& (request.getParameter("paymentAmount").trim() != "")) {
						PreparedStatement ps = connection
								.prepareStatement("insert into invoicepayment(InvoiceNumber,Payee,Amount,PaymentAmount,Comments,InvoiceTransactionId,InvId,PONum,Extra)values(?,?,?,?,?,?,?,?,?)");
						String temp = "";
						temp = request.getParameter("invoiceNumber");
						ps.setString(1, temp);
						temp = request.getParameter("payee");
						ps.setString(2, temp);
						temp = request.getParameter("amount");
						ps.setString(3, temp);
						temp = request.getParameter("paymentAmount");
						ps.setString(4, temp);
						temp = request.getParameter("comments");
						ps.setString(5, temp);

						ps.setString(6, String.valueOf(id));
						temp = request.getParameter("invoiceNumber");
						ps.setString(7, temp);
						temp = request.getParameter("ponumber");
						ps.setString(8, temp);

						ps.setInt(9, 1);

						ps.execute();
					}
				}
			} // end if not transid = null
			ResultSet rs = null;
			PreparedStatement ps = null;
			// String sql =
			// "SELECT d.Name1 , d.Name2, d.DebtorId,i.InvoiceDate,i.InvoiceAmount,a.AccountNumber,a.CurrencyType FROM Debtor d join PayersAccounts a on a.PayerId = d.SysId join invoicetransaction i on i.SysAcctId = a.SysId where i.SysId="+id;
			//CallableStatement cs = connection
			//		.prepareCall("{call citdebtor(?)}");
			//cs.setInt(1, id);
			// ps = connection.prepareStatement(sql);
			//rs = cs.executeQuery();
			PreparedStatement ps3 = connection
					.prepareStatement("SELECT payerid FROM PayersAccounts  p inner join invoicetransaction t on p.sysid = t.sysacctid where t.sysid = "
							+ id);
			rs = ps3.executeQuery();
			while (rs.next()) {
				payerid = rs.getString("payerid");
			}
			javax.servlet.ServletContext context = null;
			context = sc;
			// String path =context.getInitParameter("IPS2Path").toString();
			String path = "MakePaymentf.jsp";// ?id="+id;
			// response.sendRedirect( path);
			request.setAttribute("pyid", payerid);
			request.setAttribute("id", id);
			request.getRequestDispatcher(path).forward(request, response);
		} catch (Exception e) {
			// ByteArrayOutputStream baos = new ByteArrayOutputStream();
			// PrintWriter pw = new PrintWriter(baos);
			// e.printStackTrace(pw);
			// String stackTrace = new String(baos.toByteArray());

			// context.log("Error received:",new
			// IllegalStateException(stackTrace));

			// response.setContentType("text/html");
			// PrintWriter pw2 = response.getWriter();
			// pw2.println("class=");
			// StringWriter errors = new StringWriter();
			// e.printStackTrace(new PrintWriter(errors));
			// pw2.println(errors.toString());
			// e.printStackTrace();
		}
	}
}
