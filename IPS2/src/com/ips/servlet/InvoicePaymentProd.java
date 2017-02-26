package com.ips.servlet;


import java.awt.Color;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;

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
import com.ips.database.DBProperties;
import com.ips.database.FactorDBService;
import com.ips.database.SqlServerDBService;
import com.ips.model.Client;
import com.ips.model.Debtor;
import com.ips.model.Invoice;
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
public class InvoicePaymentProd extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public InvoicePaymentProd() {
        super();
        // TODO Auto-generated constructor stub
    }
    protected String adminEmail = null;
    public javax.servlet.ServletContext sc=null;
    public void init(ServletConfig servletConfig) throws ServletException{
      this.adminEmail  = servletConfig.getInitParameter("email");
      sc = servletConfig.getServletContext();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 
		Connection connection=null;
		try{
			    
				
			connection = SqlServerDBService.getInstance().openConnection();
			Map<String,Client> clients = FactorDBService.getInstance().getClients();
			Map<String,Debtor> debtors = FactorDBService.getInstance().getDebtors();
		 	String accountid = request.getParameter("account");
		 	String totalpayment = request.getParameter("totalPayment");
			totalpayment = totalpayment.substring(1);
			totalpayment = totalpayment.replaceAll(",", "");
		 	String currency = request.getParameter("currency");
		 	String refreshData= request.getParameter("refreshData");
		 	String x="0";
			 String  path = "MakePayment.jsp"; 
		     String sql11 = "select count(*) as counter from invoicetransaction where invoiceAmount=? and Currencytype=?  and sysAcctId=? and invoicePaymentDate > DATEADD(minute, -20, GETDATE())";
		     PreparedStatement ps11 = connection.prepareStatement(sql11); 
		     ps11.setString(1,totalpayment);   
		     ps11.setString(2,currency);
		     ps11.setString(3,accountid);
			 ResultSet rs11 = ps11.executeQuery();
			 int numberOfRows = 0;
			 if (rs11.next()) {
			        numberOfRows = rs11.getInt(1);
			 }      
		    
		 if (numberOfRows>0){
			 String pid1 = request.getParameter("payerid");
			 request.setAttribute("pyid",pid1);
			 request.getRequestDispatcher(path).forward(
						request, response);
			 return;
		 }
		 else {
			 	int level =0;
				String acctid="";
				String payerid ="";
			    //String connectionURL = "jdbc:mysql://localhost:3306/ipspayment";// newData is the database
				//  String connectionURL = "jdbc:jtds:sqlserver://192.168.1.41/ipspayment_test";
			    // Connection connection=null; 
			    String act = request.getParameter("act");
			    String transId = request.getParameter("transId");
			    int id = 0;
			    int counter=0;
			    //Class.forName("com.mysql.jdbc.Driver");
			    acctid = request.getParameter("AcctId");
		        String invNo = request.getParameter("invoiceNumber");
			    String payee = request.getParameter("payee");
			    String amount = request.getParameter("amount");
			    String discount = request.getParameter("discount");
			    String payment = request.getParameter("paymentAmount");
			    String comments = request.getParameter("comments");
			    
			    //String accounnum = request.getParameter("account");
			    DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			    Date date = new Date();
			    //  System.out.println(dateFormat.format(date));
			    String invoicedate = dateFormat.format(date);//request.getParameter("datepicker");
			   
			    String totalpaymentoriginal = totalpayment;
			   
			    
			    int loop=Integer.parseInt(request.getParameter("counter"));
			    level=1;
			    if (transId!=null && transId.length()>0 ){
			    	level=2;
			       	id = Integer.parseInt(transId);
			    	PreparedStatement ps = (PreparedStatement) connection.prepareStatement("update invoicetransaction set SysAcctId = ?,InvoiceAmount=?,CurrencyType=?,InvoicePaymentDate =? where SysId=?");
			        //	(SysAcctId,InvoiceAmount,CurrencyType,InvoicePaymentDate)values(?,?,?,?)RETURNING SysId into ?");
			        ps.setString(1,accountid);
				    ps.setString(2,totalpayment);
				    ps.setString(3,currency);
				    ps.setString(4,invoicedate);
				    ps.setString(5,transId);
				    ps.execute();
				    while (counter<loop){
				    		String name ="invoiceid"+counter;
					    	String checkname ="paycheck"+counter;
					    	String val = request.getParameter(checkname);
					    	if (val!=null && val.equals("on") && request.getParameter(name)!=null && request.getParameter(name)!=""){
					    			CallableStatement ps2 =  connection.prepareCall("{call Update_InvoicePayment(?,?,?,?,?,?)}");
					    			ps2.setString(1,String.valueOf(id));
					    			name="invoiceid" + counter;
					    			ps2.setString(2,request.getParameter(name));
					    			name="clientid" + counter;
					    			ps2.setString(3,request.getParameter(name));
					    			name="amount" + counter;
					    			ps2.setString(4,request.getParameter(name));
					    			name="paymentamount" + counter;
					    			ps2.setString(5,request.getParameter(name));
					    			name="paymentComment" + counter;
					    			ps2.setString(6,request.getParameter(name));
					 		       	ps2.execute();
					    	}
					    	else{
					    		   	PreparedStatement ps3 =  connection.prepareStatement("delete from invoicepayment where invoicetransactionid=? and invoicenumber=?");
					    		   	ps3.setString(1,String.valueOf(transId));
					    		   	name="invoiceid" + counter;
					    		   	ps3.setString(2,request.getParameter(name));
					    		   	ps3.execute();
					    	}
					    	counter=counter+1;
					    }
				       if ((request.getParameter("paymentAmount")!=null)&&(request.getParameter("paymentAmount").trim()!="")){
					    	CallableStatement cs4 =  connection.prepareCall("{call Update_InvoicePayment(?,?,?,?,?,?)}");
					    	cs4.setString(1,String.valueOf(id));
					    	cs4.setString(2,request.getParameter("invoiceNumber"));
					    	cs4.setString(3,request.getParameter("payee"));
					    	cs4.setString(4,request.getParameter("amount"));
					    	cs4.setString(5,request.getParameter("paymentAmount"));
					    	cs4.setString(6,request.getParameter("comments"));
					    	cs4.execute();
					    }
			     }else{
			    	 	//  if (act.equals("insert")){
			         	//  CallableStatement pst =  connection.prepareCall("insert into Invoicetransaction(SysAcctId,InvoiceAmount,CurrencyType,InvoicePaymentDate)values(?,?,?,?)RETURNING SysId into ?");
					   	//insert into InvoicePayment(InvoiceNumber,Payee,Amount,DiscountCredit,PaymentAmount,Comments,AccountId,InvoiceDate,status)values(?,?,?,?,?,?,?,?,?)"
				       CallableStatement cs =  connection.prepareCall("{call InsertInvoice(?,?,?,?,?,?)}");
				       cs.setString(1,accountid);
				       cs.setString(2,totalpayment);
				       cs.setString(3,currency);
				       cs.setString(4,invoicedate);
				       cs.registerOutParameter(5, java.sql.Types.INTEGER);
				       cs.registerOutParameter(6, java.sql.Types.VARCHAR);
					   cs.execute();
					   id = cs.getInt(5);
					   String accountnum = cs.getString(6);
					   while (counter<loop){
					    	String name ="invoiceid"+counter;
					    	String checkname ="paycheck"+counter;
					    	String val = request.getParameter(checkname);
					    	if (val!=null && val.equals("on") && request.getParameter(name)!=null && request.getParameter(name)!=""){
					    		 	PreparedStatement ps =  connection.prepareStatement("insert into invoicepayment (invoicetransactionid, InvoiceNumber, PaymentAmount,payee,Amount,comments,InvId) values (?,?,?,?,?,?,?)");
					    		 	ps.setString(1,String.valueOf(id));
					    		 	name="invoiceid" + counter;
					    		 	ps.setString(2,request.getParameter(name));
					    		 	// name="amount" + counter;
					    		 	// ps.setString(3,request.getParameter(name));
					    		 	name="paymentamount" + counter;
					    		 	String pa = request.getParameter(name);
					    		 	pa = pa.replaceAll(",",  "");
					    		 	ps.setString(3,pa);
					    		 	// ps.setString(3,request.getParameter(name));
					    		 	name="clientid" + counter;
					    		 	ps.setString(4,request.getParameter(name));
					    		 	name="amount" + counter;
					    		 	ps.setString(5,request.getParameter(name));
					    		 	name="paymentComment" + counter;
					    		 	ps.setString(6,request.getParameter(name));
					    		 	name="invoiceNumber" + counter;
					    		 	ps.setString(7,request.getParameter(name));
					    		 	ps.execute();
					    	}counter=counter+1;
					    }
					    //insert into InvoicePayment(InvoiceNumber,Payee,Amount,DiscountCredit,PaymentAmount,Comments,AccountId,InvoiceDate,status)values(?,?,?,?,?,?,?,?,?)"
					    String checkname ="paycheckextra";
				    	String val = request.getParameter(checkname);
				    	if (val!=null && val.equals("on") )
					    {if ((request.getParameter("paymentAmount")!=null)&&(request.getParameter("paymentAmount").trim()!=""))
					      {
					    	PreparedStatement ps =  connection.prepareStatement("insert into invoicepayment(InvoiceNumber,Payee,Amount,PaymentAmount,Comments,InvoiceTransactionId,InvId,PONum,Extra)values(?,?,?,?,?,?,?,?,?)");
					    	String temp="";
					    	temp = request.getParameter("invoiceNumber");
					    	ps.setString(1,temp);
					    	temp = request.getParameter("payee");
					    	ps.setString(2,temp);
					    	temp = request.getParameter("amount");
					    	ps.setString(3,temp);
					    	temp = request.getParameter("paymentAmount");
					    	ps.setString(4,temp);
					    	temp = request.getParameter("comments");
					    	ps.setString(5,temp);

					    	ps.setString(6,String.valueOf(id));
					     	temp = request.getParameter("invoiceNumber");
					    	ps.setString(7,temp);
					    	temp = request.getParameter("ponumber");
					    	ps.setString(8,temp);

					    	ps.setInt(9,1);

					    	ps.execute();
					      }
					    }
			     } //end if not transid = null
			    ResultSet rs =null;
			    PreparedStatement ps = null;
			    // String sql = "SELECT d.Name1 , d.Name2, d.DebtorId,i.InvoiceDate,i.InvoiceAmount,a.AccountNumber,a.CurrencyType FROM Debtor d join PayersAccounts a on a.PayerId = d.SysId join invoicetransaction i on i.SysAcctId = a.SysId where i.SysId="+id;
			    //CallableStatement cs = connection.prepareCall("{call citdebtor(?)}");
			    //cs.setInt(1, id);
			    //ps = connection.prepareStatement(sql);
			    //rs = cs.executeQuery();
			    PreparedStatement ps3 =  connection.prepareStatement("SELECT payerid FROM PayersAccounts  p inner join invoicetransaction t on p.sysid = t.sysacctid where t.sysid = " + id);
			    rs = ps3.executeQuery();
			    while (rs.next()){
						payerid=rs.getString("payerid");
				}
				SavePDF(id, clients, debtors);
				SendEmail(String.valueOf(id),totalpayment, debtors);
				javax.servlet.ServletContext context = null;
			    context=sc;
				//String path =context.getInitParameter("IPS2Path").toString();
				//String  path = "MakePayment.jsp";//?id="+id;
				//response.sendRedirect( path);
				String id2 = "ip"+id; 
				request.setAttribute("pyid",payerid);
				request.setAttribute("id",id2);
				request.getRequestDispatcher(path).forward(request, response);
				return;
		 	}
		 }
	     catch(Exception e)
	     { e.printStackTrace();
		 } finally {
			 SqlServerDBService.getInstance().releaseConnection(connection);
		 }
	}
	public void SendEmail(String id,String totalPaymentOriginal, Map<String, Debtor> debtors){
	
		Connection connection = null;	
	try{
		String from = "webserver@invoicepayment.ca";
		String to2 = "Youssef.shatila@systembind.com";
		
		connection = SqlServerDBService.getInstance().openConnection();
		CallableStatement cs = connection.prepareCall("exec citdebtor_m ?");
		cs.setInt(1, Integer.parseInt(id));
		ResultSet rs = cs.executeQuery();
		String totalpaymentoriginal = null;
		String nameWithDebtor ="";
		while (rs.next()) {
			String payerid = rs.getString("payerid");
			Debtor d = debtors.get(payerid);
		
			
			totalpaymentoriginal = rs.getString("InvoiceAmount");
			if (d!=null) {
				nameWithDebtor = "Payer: " + d.getName1() + " "
						+ d.getName2() + " / ("
						+ d.getDebtorId().trim() + ")";
			}
		}
		MimeBodyPart textBodyPart = new MimeBodyPart();
		String content = "Please note that " + nameWithDebtor 
				+ " has submitted a payment in the amount of "
				+ totalPaymentOriginal
				+ " through the IPS eCheque. Details are attached.<br>";
		content = content + "<a href=https://live.invoicepayment.ca:8443/ipspayersLive/IPS2/Invoices/Invoice_" + id + ".pdf>" + "Invoice_" + id + ".pdf</a>";
	    String sender = from;
	    String subject = "eCheque payment submitted - " + nameWithDebtor;  ////////////////
	    InternetAddress iaSender = new InternetAddress(sender);
	    InternetAddress iaRecipient = new InternetAddress(adminEmail);
	   // MimeMultipart mimeMultipart = new MimeMultipart();
	   // mimeMultipart.addBodyPart(textBodyPart);
	    //mimeMultipart.addBodyPart(pdfBodyPart);
	    Properties props = new Properties();
	    props.setProperty("mail.host", "mail.ips-corporation.net");
	    props.setProperty("mail.smtp.port", "25");
	    props.setProperty("mail.smtp.auth", "false");
	    props.setProperty("mail.smtp.starttls.enable", "false");
	    final String login = "webserver";
	    final String password = "testing";
	    Session session = Session.getInstance(props,
			new javax.mail.Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(login, password);
				}
			});
	    MimeMessage mimeMessage = new MimeMessage(session);
	    mimeMessage.setFrom(iaSender);
	    mimeMessage.setSender(iaSender);
	    mimeMessage.setSubject(subject);
	    mimeMessage.setRecipient(Message.RecipientType.TO, iaRecipient);
	    mimeMessage.setRecipients(Message.RecipientType.CC,
		InternetAddress.parse("youssef.shatila@systembind.com"));
	    // mimeMessage.setRecipients(Message.RecipientType.CC,InternetAddress.parse("suarez@invoicepayment.ca"));
	    // mimeMessage.setRecipients(Message.RecipientType.CC,InternetAddress.parse("ali@invoicepayment.ca"));
	    mimeMessage.setContent(content,"text/html");
	    Transport.send(mimeMessage);
	}
	catch(Exception e){
	}	finally {
		SqlServerDBService.getInstance().releaseConnection(connection);
	}
}
	public void SavePDF(int transId, Map<String,Client> clients, Map<String,Debtor> debtors) {
		
		Connection connection = null;
		try {
			connection = SqlServerDBService.getInstance().openConnection();
			Document document = new Document();
			String id = transId + "";
			BaseFont bf_courier = BaseFont.createFont(BaseFont.COURIER,
					"Cp1252", false);
			BaseFont bf_cambriaz = BaseFont
					.createFont(
							"http://live.invoicepayment.ca/ipspayersLive/IPS2/font/cambriab.ttf",
							BaseFont.WINANSI, false);
			BaseFont bf_cambria = BaseFont
					.createFont(
							"http://live.invoicepayment.ca/ipspayersLive/IPS2/font/cambriab.ttf",
							BaseFont.WINANSI, false);
			BaseFont bf_cambrial = BaseFont
					.createFont(
							"http://live.invoicepayment.ca/ipspayersLive/IPS2/font/Cambria.ttf",
							BaseFont.WINANSI, false);
			Font cambria9 = new Font(bf_cambria, 9);
			Font cambria12 = new Font(bf_cambria, 10);
			Font cambrial9 = new Font(bf_cambrial, 9);
			Font cambria9Red = new Font(bf_cambrial, 9);
			cambria9Red.setColor(Color.RED);
			// ServletOutputStream os = response.getOutputStream();
			// ByteArrayOutputStream os = new ByteArrayOutputStream();
			// OutputStream os = new FileOutputStream("C:\\Users\\systembind\\workspace\\IPS2\\WebContent\\Invoices\\Invoice_" + id + ".pdf");
			OutputStream os = new FileOutputStream("C:\\Tomcat 6.0\\webapps\\ROOT\\ipspayersLive\\IPS2\\Invoices\\Invoice_" + id + ".pdf");
			PdfWriter writer = PdfWriter.getInstance(document, os);
			ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
			PdfWriter writere = PdfWriter.getInstance(document, outputStream);
			document.open();
			document.add(new Paragraph(""));
			com.lowagie.text.Image image = com.lowagie.text.Image
					.getInstance("http://live.invoicepayment.ca/images/logoIPS.gif");
			image.setAbsolutePosition(595 - image.getScaledWidth(), 760);
			image.scaleToFit(73, 55);
			document.add(image);
			PdfContentByte cb = writer.getDirectContent();
			PdfContentByte cbe = writere.getDirectContent();
			cb.setLineWidth(1f);
			int y_line2 = 800;
			cb.beginText();
			cb.setFontAndSize(bf_cambria, 14);
			cbe.beginText();
			cbe.setFontAndSize(bf_cambria, 14);
			String text = "Transaction Complete";
			cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);
			y_line2 = y_line2 - 20;
			cb.setFontAndSize(bf_cambriaz, 10);
			cbe.setFontAndSize(bf_cambriaz, 10);
			text = "Thank you for using the IPS eCheque service.";
			cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);
			y_line2 = y_line2 - 20;
			text = "Please print this page for your records";
			cb.setFontAndSize(bf_cambriaz, 9);
			cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);
			cbe.setFontAndSize(bf_cambriaz, 9);
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);
			y_line2 = y_line2 - 20;
			cb.setFontAndSize(bf_cambriaz, 9);
			cbe.setFontAndSize(bf_cambriaz, 9);
			String name1 = "";
			ResultSet rs = null;
			PreparedStatement ps = null;
			CallableStatement cs = connection.prepareCall("exec citdebtor_m ?");
			cs.setInt(1, Integer.parseInt(id));
			rs = cs.executeQuery();
			String totalpaymentoriginal = null;
			while (rs.next()) {
				String payerid = rs.getString("payerid");
				Debtor d = debtors.get(payerid);
			
				
				totalpaymentoriginal = rs.getString("InvoiceAmount");
				if (d!=null) {
					text = "Payer: " + d.getName1() + " "
							+ d.getName2() + " / ("
							+ d.getDebtorId().trim() + ")";
				}
				cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60,
						y_line2, 0);
				cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60,
						y_line2, 0);
				text = "Payment Amount: " + totalpaymentoriginal + " "
						+ rs.getString("CurrencyType");// rs.getString("InvoiceAmount")
				y_line2 = y_line2 - 20;
				cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60,
						y_line2, 0);
				cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60,
						y_line2, 0);
				text = "From Bank Account: " + rs.getString("TransitNumber")
						+ " " + rs.getString("BranchCode") + " "
						+ rs.getString("AccountNumber") + " "
						+ rs.getString("CurrencyType");
				y_line2 = y_line2 - 20;
				cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60,
						y_line2, 0);
				cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60,
						y_line2, 0);
				text = "To: " + "Invoice Payment System Corporation";
				y_line2 = y_line2 - 20;
				cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60,
						y_line2, 0);
				cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60,
						y_line2, 0);
				text = "Confirmation Number: " + id;
				y_line2 = y_line2 - 20;
				cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60,
						y_line2, 0);
				cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60,
						y_line2, 0);
				text = "Date and Time: " + rs.getString("InvoiceDate");
				y_line2 = y_line2 - 20;
				cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60,
						y_line2, 0);
				cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60,
						y_line2, 0);
				text = "Note:" + "";
				y_line2 = y_line2 - 20;
				cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60,
						y_line2, 0);
				cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60,
						y_line2, 0);
			}
			text = "If you need to have this payment modified or deleted, you must advise us by ";
			y_line2 = y_line2 - 20;
			cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 70, y_line2, 0);
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 70, y_line2, 0);
			text = "calling us at 1-888-503-4528 ext. 227 no later than 4:30pm EDT/EST, or by ";
			y_line2 = y_line2 - 20;
			cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 70, y_line2, 0);
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 70, y_line2, 0);
			text = "making an online request by 6:00 pm your local time on the same day you ";
			y_line2 = y_line2 - 20;
			cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 70, y_line2, 0);
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 70, y_line2, 0);
			text = "submitted your payment. ";
			y_line2 = y_line2 - 20;
			cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 70, y_line2, 0);
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 70, y_line2, 0);
			y_line2 = y_line2 - 20;
			cb.moveTo(70, y_line2);
			cb.lineTo(440, y_line2);
			cb.stroke();
			cb.endText();
			cbe.moveTo(70, y_line2);
			cbe.lineTo(440, y_line2);
			cbe.stroke();
			cbe.endText();
			PdfPTable table = new PdfPTable(5);
			y_line2 = y_line2 - 20;
			table.setSpacingBefore(y_line2);
			table.setTotalWidth(500);
			Paragraph p = new Paragraph("Paid Invoices", cambria12);
			PdfPCell c = new PdfPCell(p);
			c.setColspan(6);
			c.setBorder(Rectangle.NO_BORDER);
			table.addCell(c);
			c = new PdfPCell(new Paragraph("Supplier", cambria9));
			c.setBorder(Rectangle.NO_BORDER);
			table.addCell(c);
			c = new PdfPCell(new Paragraph("Invoice No.", cambria9));
			c.setBorder(Rectangle.NO_BORDER);
			table.addCell(c);
			c = new PdfPCell(new Paragraph("PO No.", cambria9));
			c.setBorder(Rectangle.NO_BORDER);
			table.addCell(c);
			c = new PdfPCell(new Paragraph("Amount", cambria9));
			c.setBorder(Rectangle.NO_BORDER);
			c.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c);
			c = new PdfPCell(new Paragraph("Payment Amount", cambria9));
			c.setBorder(Rectangle.NO_BORDER);
			c.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c);
			cs = connection.prepareCall("exec ipclient_m ?");
			cs.setString(1, String.valueOf(id));
			rs = cs.executeQuery();
			while (rs.next()) {
				String payee = rs.getString("payee");
				String invoicenumber = rs.getString("invoicenumber");
				Client cl = clients.get(payee);
				Invoice inv = FactorDBService.getInstance().getInvoice(invoicenumber);
				
				String name = null;
				if (cl == null || cl.getName1() == null) {
					name = payee;
				} else {
					name = cl.getName1();
				}
				c = new PdfPCell(new Paragraph(name, cambrial9));
				c.setBorder(Rectangle.NO_BORDER);
				table.addCell(c);
				c = new PdfPCell(
						new Paragraph((inv!=null)?inv.getInvoiceId():"", cambrial9));
				c.setBorder(Rectangle.NO_BORDER);
				table.addCell(c);
				c = new PdfPCell(new Paragraph(rs.getString("PoNumber"),
						cambrial9));
				c.setBorder(Rectangle.NO_BORDER);
				table.addCell(c);
				NumberFormat fmt = NumberFormat.getCurrencyInstance(Locale.US);
				Double d = Double.parseDouble(rs.getString("amount"));
				String cur = fmt.format(d);
				c = new PdfPCell(new Paragraph(cur, cambrial9));
				c.setBorder(Rectangle.NO_BORDER);
				c.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(c);
				d = Double.parseDouble(rs.getString("paymentamount"));
				cur = fmt.format(d);
				c = new PdfPCell(new Paragraph(cur, cambrial9));
				c.setBorder(Rectangle.NO_BORDER);
				c.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(c);
				if (rs.getString("Comments").length() > 0) {
					c = new PdfPCell(new Paragraph("Note: "
							+ rs.getString("Comments"), cambrial9));
					c.setBorder(Rectangle.NO_BORDER);
					c.setColspan(6);
					table.addCell(c);
				}
			}
			c = new PdfPCell(new Paragraph(""));
			c.setBorder(Rectangle.NO_BORDER);
			c.setColspan(6);
			c.setFixedHeight(20);
			table.addCell(c);
			c = new PdfPCell(
					new Paragraph(
							"Please allow up to 48 hours for the payment to be posted and for the corresponding invoice(s) to be removed from your invoice payable aging.",
							cambria9Red));
			c.setBorder(Rectangle.NO_BORDER);
			c.setColspan(6);
			table.addCell(c);
			table.completeRow();
			table.writeSelectedRows(0, -1, 50, y_line2, cb);
			table.writeSelectedRows(0, -1, 50, y_line2, cbe);
			document.close();
			outputStream.close();
			
			/*
			 * String from="webserver@invoicepayment.ca"; String
			 * to2="Youssef.shatila@systembind.com"; DataSource dataSource = new
			 * javax.mail.util.ByteArrayDataSource(outputStream.toByteArray(),
			 * "application/pdf"); MimeBodyPart pdfBodyPart = new
			 * MimeBodyPart(); pdfBodyPart.setDataHandler(new
			 * DataHandler(dataSource));
			 * pdfBodyPart.setFileName("PaymentConfirmation_" + id+".pdf");
			 * MimeBodyPart textBodyPart = new MimeBodyPart(); String content =
			 * "Please note that "+ name1 +
			 * " has submitted a payment in the amount of " +
			 * totalpaymentoriginal +
			 * " through the IPS eCheque. Details are attached."; String sender
			 * = from; String subject = "eCheque payment submitted � " + name1 ;
			 * //this will be the subject of the email
			 * textBodyPart.setText(content); InternetAddress iaSender = new
			 * InternetAddress(sender); InternetAddress iaRecipient = new
			 * InternetAddress(adminEmail); MimeMultipart mimeMultipart = new
			 * MimeMultipart(); mimeMultipart.addBodyPart(textBodyPart);
			 * mimeMultipart.addBodyPart(pdfBodyPart); Properties props = new
			 * Properties(); props.setProperty("mail.host",
			 * "mail.ips-corporation.net"); //
			 * props.setProperty("mail.smtp.port", "25"); //
			 * props.setProperty("mail.host", "smtp.gmail.com"); //
			 * props.setProperty("mail.smtp.port", "587");
			 * props.setProperty("mail.smtp.port", "25");
			 * props.setProperty("mail.smtp.auth", "true");
			 * props.setProperty("mail.smtp.starttls.enable", "true"); // final
			 * String login="invoicepayment2@gmail.com"; // final String
			 * password="P@ssword12"; final String login = "webserver"; final
			 * String password = "testing"; Session session =
			 * Session.getInstance(props, new javax.mail.Authenticator() {
			 * protected PasswordAuthentication getPasswordAuthentication() {
			 * return new PasswordAuthentication(login,password); } });
			 * MimeMessage mimeMessage = new MimeMessage(session);
			 * mimeMessage.setFrom(iaSender); mimeMessage.setSender(iaSender);
			 * mimeMessage.setSubject(subject);
			 * mimeMessage.setRecipient(Message.RecipientType.TO, iaRecipient);
			 * mimeMessage
			 * .setRecipients(Message.RecipientType.CC,InternetAddress
			 * .parse("youssef.shatila@systembind.com"));
			 * //mimeMessage.setRecipients
			 * (Message.RecipientType.CC,InternetAddress
			 * .parse("suarez@invoicepayment.ca"));
			 * mimeMessage.setRecipients(Message
			 * .RecipientType.CC,InternetAddress
			 * .parse("ali@invoicepayment.ca"));
			 * mimeMessage.setContent(mimeMultipart);
			 * Transport.send(mimeMessage);
			 */
		} catch (Exception e) {
			e.printStackTrace();
			// ByteArrayOutputStream baos = new ByteArrayOutputStream();
			// PrintWriter pw = new PrintWriter(baos);
			// e.printStackTrace(pw);
			// String stackTrace = new String(baos.toByteArray());
			// response.setContentType("text/html");
			// PrintWriter pw2 = response.getWriter();
			// pw2.println("class=");
			// StringWriter errors = new StringWriter();
			// e.printStackTrace(new PrintWriter(errors));
			// pw2.println(errors.toString());
		} finally {
			SqlServerDBService.getInstance().releaseConnection(connection);
		}
	}	
}
