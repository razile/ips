package com.ips.servlet;

import java.awt.Color;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.sql.CallableStatement;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.Map;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ips.database.DBProperties;
import com.ips.database.FactorDBService;
import com.ips.database.SqlServerDBService;
import com.ips.model.Client;
import com.ips.model.Debtor;
import com.ips.model.Invoice;
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

//import com.mysql.jdbc.Connection;

/**
 * Servlet implementation class ReviewPayment
 */
public class ReviewPayment extends HttpServlet {
	public static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ReviewPayment() {
		super();
		// TODO Auto-generated constructor stub
	}

	public String adminEmail = null;
	public javax.servlet.ServletContext sc = null;

	public void init(ServletConfig servletConfig) throws ServletException {
		this.adminEmail = servletConfig.getInitParameter("emailDelete");
		sc = servletConfig.getServletContext();

	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Connection connection = null;
		try {
			String act = request.getParameter("act");
			String decline = request.getParameter("declineh");
			String approve = request.getParameter("approveh");
			String deleteAdmin = request.getParameter("deleteAdminh");
			if (decline != null && decline.equals("on"))
				act = "Decline";
			if (approve != null && approve.equals("on"))
				act = "Approve";
			if (deleteAdmin != null && deleteAdmin.equals("on"))
				act = "DeleteAdmin";

			Map<String,Client> clients = FactorDBService.getInstance().getClients();
			Map<String,Debtor> debtors = FactorDBService.getInstance().getDebtors();
			
			connection = SqlServerDBService.getInstance().openConnection();
			
			javax.servlet.ServletContext context = null;
			context = sc;
			String email1 = "";
			String email2 = "";
			String name = "";
			String client = "";
			String amount = "";

			String path = context.getInitParameter("IPS2Path").toString();
			String pyid = (String) request.getParameter("pyid");
			if (act.equals("Decline")) {
				String selected = request.getParameter("check");
				String comment = request.getParameter("cm");
				if (selected != null)
					selected = selected.trim();
				PreparedStatement ps2 = connection
						.prepareStatement("update invoicetransaction set Active =2,status='Declined',comment=? where SysId =?;");
				ps2.setString(1, comment);
				ps2.setString(2, selected);
				ps2.execute();
				ps2 = connection
						.prepareStatement("SELECT payerid,InvoiceAmount FROM  PayersAccounts pa left join invoicetransaction it on it.SysAcctId =  pa.sysid where it.sysid =?");
				ps2.setString(1, selected);
				ResultSet rs = ps2.executeQuery();
				String payerid = "";
				while (rs.next()) {
					payerid = rs.getString("payerid");
					amount = rs.getString("InvoiceAmount");
				}
				
				// FACTOR-CLIENT
				ps2 = connection
						.prepareStatement("SELECT ip.payee FROM invoicepayment ip join invoicetransaction it on it.SysId = ip.InvoiceTransactionId  where it.sysid =?");
				ps2.setString(1, selected);
				rs = ps2.executeQuery();

				while (rs.next()) {
					String payee = rs.getString("payee");
					Client c = clients.get(payee);
					client = client + c.getName1() + " "
							+ c.getName2() + ", ";
				}
				if (client.length() > 0) {
					client = client.substring(0, client.length() - 2);
				}

				
				Debtor d = FactorDBService.getInstance().getEmails(payerid);
				email1 = d.getContactEmail();
				email2 = d.getContact2Email();
				name= d.getName1() + " " + d.getName2();
				// if (path.length()>0){
				// path = "/" + path;}
				// path = path + "/BackendReview.jsp";
				// String invId,String comment,String name,String client,String
				// amount,Connection con
				// (String invId,String name,String comment,String
				// email,Connection con){
				ByteArrayOutputStream outputStream = GetDocument(connection,
						selected, clients, debtors);
				if (email1.length() > 0)
					SendDebtorEmail(outputStream, selected, name, comment,
							email1);
				if (email2.length() > 0)
					SendDebtorEmail(outputStream, selected, name, comment,
							email2);
				SendEmailDeclined(selected, comment, name, client, amount,
						connection, outputStream);
				path = context.getInitParameter("IPS2Path").toString();
				request.setAttribute("pyid", pyid);
				request.getRequestDispatcher("BackendReview.jsp").forward(
						request, response);
				// response.sendRedirect( path);
			} else if (act.equals("Approve")) {
				String selected = request.getParameter("check");
				// String comment = request.getParameter("cm");
				if (selected != null)
					selected = selected.trim();
				PreparedStatement ps2 = connection
						.prepareStatement("update invoicetransaction set Active =3,status='Approved' where SysId =?;");
				// ps2.setString(1,comment);
				ps2.setString(1, selected);
				ps2.execute();
				ps2 = connection
						.prepareStatement("SELECT payerid,InvoiceAmount FROM  PayersAccounts pa left join invoicetransaction it on it.SysAcctId =  pa.sysid where it.sysid =?");
				ps2.setString(1, selected);
				ResultSet rs = ps2.executeQuery();
				String payerid = "";
				while (rs.next()) {
					payerid = rs.getString("payerid");
					amount = rs.getString("InvoiceAmount");
				}
				
				// FACTOR-CLIENT
				ps2 = connection
						.prepareStatement("SELECT ip.payee from invoicepayment ip join invoicetransaction it on it.SysId = ip.InvoiceTransactionId  where it.sysid =?");
				ps2.setString(1, selected);
				rs = ps2.executeQuery();

				while (rs.next()) {
					String payee = rs.getString("payee");
					Client c = clients.get(payee);
					client = client + c.getName1() + " "
							+ c.getName2() + ", ";
				}
				if (client.length() > 0) {
					client = client.substring(0, client.length() - 2);
				}

				Debtor d = FactorDBService.getInstance().getEmails(payerid);
				email1 = d.getContactEmail();
				email2 = d.getContact2Email();
				name= d.getName1() + " " + d.getName2();
				
				// if (path.length()>0){
				// path = "/" + path;}
				path = "BackendReview.jsp";
				// String invId,String comment,String name,String client,String
				// amount,Connection con
				// (String invId,String name,String comment,String
				// email,Connection con){
				ByteArrayOutputStream outputStream = GetDocumentApproved(
						connection, selected, clients, debtors);
				if (email1.length() > 0)// ByteArrayOutputStream
										// outputStream,String invId,String
										// name,String comment,String email
					SendDebtorApprovedEmail(outputStream, selected, name, "",
							email1);

				if (email2.length() > 0)
					SendDebtorApprovedEmail(outputStream, selected, name, "",
							email2);
				SendEmailApproved(selected, "", name, client, amount,
						connection, outputStream);
				// response.sendRedirect( path);
				path = context.getInitParameter("IPS2Path").toString();
				request.setAttribute("pyid", pyid);
				request.getRequestDispatcher("BackendReview.jsp").forward(
						request, response);

			} else if (act.equals("DeleteAdmin")) {
				String selected = request.getParameter("check");
				if (selected != null)
					selected = selected.trim();
				String accountid = request.getParameter("InvoiceId");
				PreparedStatement ps2 = connection
						.prepareStatement("delete from invoicepayment where invoicetransactionId =?;");
				ps2.setString(1, selected);
				ps2.execute();
				ps2 = connection
						.prepareStatement("delete from invoicetransaction where SysId =?;");
				ps2.setString(1, selected);
				ps2.execute();
				// if (path.length()>0)
				// {path = "/" + path;}
				path = context.getInitParameter("IPS2Path").toString();
				// path = path + "/ReviewPayment.jsp?d="+selected;
				// SendEmail(selected,accountid,connection);
				// r.forward(request, response);
				request.setAttribute("pyid", pyid);
				request.setAttribute("d", selected);
				request.getRequestDispatcher("BackendReview.jsp").forward(
						request, response);
				// response.sendRedirect( path);
			} else if (act.equals("Delete")) {
				String selected = request.getParameter("check");
				if (selected != null)
					selected = selected.trim();
				String accountid = request.getParameter("InvoiceId");
				CallableStatement cs = connection
						.prepareCall("exec Del_Invoice ?");
				cs.setString(1, selected);
				cs.execute();
				// if (path.length()>0)
				// {path = "/" + path;}
				path = context.getInitParameter("IPS2Path").toString();
				// path = path + "/ReviewPayment.jsp?d="+selected;
				SendEmail(selected, accountid, connection, clients);
				// r.forward(request, response);
				request.setAttribute("pyid", pyid);
				request.setAttribute("d", selected);
				request.getRequestDispatcher("ReviewPayment.jsp").forward(
						request, response);
				// response.sendRedirect( path);
			} else if (act.equals("Modify")) {
				String[] check = request.getParameterValues("check");
				request.setAttribute("transId", check[0]);
				request.getRequestDispatcher("UpdatePayment.jsp?" + path)
						.forward(request, response);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlServerDBService.getInstance().releaseConnection(connection);
		}
		// request.getRequestDispatcher("/ReviewPayment.jsp").forward(request,
		// response);
	}

	public ByteArrayOutputStream GetDocument(Connection connection, String id, Map<String,Client> clients, Map<String,Debtor> debtors) {

		Document document = new Document();
		ByteArrayOutputStream outputStream = null;
		try {
			BaseFont bf_courier = BaseFont.createFont(BaseFont.COURIER,
					"Cp1252", false);
			BaseFont bf_cambriaz = BaseFont
					.createFont(
							"http://live.invoicepayment.ca/ipspayers/IPS2/font/cambriab.ttf",
							BaseFont.WINANSI, false);
			BaseFont bf_cambria = BaseFont
					.createFont(
							"http://live.invoicepayment.ca/ipspayers/IPS2/font/cambriab.ttf",
							BaseFont.WINANSI, false);
			BaseFont bf_cambrial = BaseFont
					.createFont(
							"http://live.invoicepayment.ca/ipspayers/IPS2/font/Cambria.ttf",
							BaseFont.WINANSI, false);

			Font cambria9 = new Font(bf_cambria, 9);
			Font cambria12 = new Font(bf_cambria, 10);
			Font cambrial9 = new Font(bf_cambrial, 9);
			Font cambria9Red = new Font(bf_cambrial, 9);
			cambria9Red.setColor(Color.RED);

			outputStream = new ByteArrayOutputStream();
			PdfWriter writere = PdfWriter.getInstance(document, outputStream);
			document.open();
			document.add(new Paragraph(""));
			com.lowagie.text.Image image = com.lowagie.text.Image
					.getInstance("http://live.invoicepayment.ca/images/logoIPS.gif");
			image.setAbsolutePosition(595 - image.getScaledWidth(), 760);
			image.scaleToFit(73, 55);
			document.add(image);
			PdfContentByte cbe = writere.getDirectContent();
			int y_line2 = 800;
			cbe.beginText();
			cbe.setFontAndSize(bf_cambria, 14);
			String text = "Transaction Declined";
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);
			y_line2 = y_line2 - 20;
			cbe.setFontAndSize(bf_cambriaz, 10);
			text = "Thank you for using the IPS eCheque service.";
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);
			y_line2 = y_line2 - 20;
			text = "Please print this page for your records";
			cbe.setFontAndSize(bf_cambriaz, 9);
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);
			y_line2 = y_line2 - 20;
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
				// text ="Total Amount: $" + totalpayment + " "+ currency ;
				cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60,
						y_line2, 0);
				text = "Declined Amount: " + totalpaymentoriginal + " "
						+ rs.getString("CurrencyType");// rs.getString("InvoiceAmount")
				y_line2 = y_line2 - 20;
				cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60,
						y_line2, 0);

				text = "Declined Payment Number: " + id;
				y_line2 = y_line2 - 20;
				cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60,
						y_line2, 0);

				Date date2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
						.parse(rs.getString("InvoiceDate"));
				SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
						"yyyy/MM/dd HH:mm");
				String datep = simpleDateFormat.format(date2);
				text = "Date and Time: " + datep;
				y_line2 = y_line2 - 20;

				cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60,
						y_line2, 0);
				y_line2 = y_line2 - 20;
				cbe.moveTo(70, y_line2);
				cbe.lineTo(440, y_line2);
				cbe.stroke();

			}

			text = "Declined Invoice Payments:";
			y_line2 = y_line2 - 20;
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);
			y_line2 = y_line2 - 5;
			cbe.moveTo(60, y_line2);
			cbe.lineTo(170, y_line2);
			cbe.stroke();
			y_line2 = y_line2 - 10;

			PdfPTable table = new PdfPTable(5);
			table.setSpacingBefore(y_line2);
			table.setTotalWidth(500);
			float[] columnWidths = new float[] { 100f, 100f, 100f, 100f, 100f };
			table.setWidths(columnWidths);

			// cb.setFontAndSize(bf_cambria, 8);
			Paragraph p = new Paragraph("Paid Invoices", cambria12);
			// PdfPCell c = new PdfPCell (p);
			// c.setColspan(6);
			// c.setBorder(Rectangle.NO_BORDER);
			// table.addCell(c);
			// table.endHeaders();

			// c = new PdfPCell(new Paragraph("Confirmation No.",cambria9));
			// c.setBorder(Rectangle.NO_BORDER);
			// table.addCell(c);
			PdfPCell c = new PdfPCell(new Paragraph("Supplier", cambria9));
			c.setBorder(Rectangle.NO_BORDER);
			// c.setBorderColor(new Color(255, 0, 0));
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

			/*
			 * c = new PdfPCell(new Paragraph("Discount / Credit",cambria9));
			 * c.setBorder(Rectangle.NO_BORDER); table.addCell(c);
			 */

			c = new PdfPCell(new Paragraph("Payment Amount", cambria9));
			c.setBorder(Rectangle.NO_BORDER);
			c.setHorizontalAlignment(Element.ALIGN_RIGHT);

			table.addCell(c);

			// String sql =
			// "SELECT pa.*,Client.name1 FROM invoicepayment pa Left join Factor.dbo.Client  on Client.sysid = pa.payee where pa.InvoiceTransactionId="+id;
			cs = connection.prepareCall("{call ipclient_m(?)}");
			// cs = connection.prepareStatement(sql);
			cs.setString(1, String.valueOf(id));
			rs = cs.executeQuery();
			// loop=0;
			int counter = 0;
			while (rs.next()) {
				String payee = rs.getString("payee");
				String invoicenumber = rs.getString("invoicenumber");
				Client cl = clients.get(payee);
				Invoice inv = FactorDBService.getInstance().getInvoice(invoicenumber);
				
				String name = null;
				if (cl == null || cl.getName1() == null) {
					rs.getString("payeeextra");
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

				// name="amount" + counter;
				NumberFormat fmt = NumberFormat.getCurrencyInstance(Locale.US);
				Double d = Double.parseDouble(rs.getString("amount"));
				String cur = fmt.format(d);
				// cur .format(format, args);
				c = new PdfPCell(new Paragraph(cur, cambrial9));
				c.setBorder(Rectangle.NO_BORDER);
				c.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(c);

				/*
				 * Double x = Double.parseDouble(rs.getString("amount"))
				 * -Double.parseDouble(rs.getString("paymentamount")); c = new
				 * PdfPCell(new Paragraph("$"+x,cambria9));
				 * c.setBorder(Rectangle.NO_BORDER); table.addCell(c);
				 */
				// name="paymentamount" + counter;
				d = Double.parseDouble(rs.getString("paymentamount"));
				cur = fmt.format(d);
				c = new PdfPCell(new Paragraph(cur, cambrial9));
				c.setBorder(Rectangle.NO_BORDER);
				c.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(c);

				/*
				 * if (rs.getString("Comments").length()>0) { c = new
				 * PdfPCell(new
				 * Paragraph("Note: "+rs.getString("Comments"),cambrial9));
				 * c.setBorder(Rectangle.NO_BORDER); c.setColspan(6);
				 * table.addCell(c);
				 * 
				 * }
				 */

			}
			/*
			 * c=new PdfPCell(new Paragraph(""));
			 * c.setBorder(Rectangle.NO_BORDER); c.setColspan(6);
			 * c.setFixedHeight(20);
			 * 
			 * table.addCell(c); c = new PdfPCell(new Paragraph(
			 * "Please allow up to 48 hours for the payment to be posted and for the corresponding invoice(s) to be removed from your invoice payable aging."
			 * ,cambria9Red)); c.setBorder(Rectangle.NO_BORDER);
			 * c.setColspan(6); table.addCell(c); // table. table.completeRow();
			 * table.writeSelectedRows(0, -1, 50, y_line2 , cb);
			 */
			table.writeSelectedRows(0, -1, 60, y_line2, cbe);
			cbe.endText();
			document.close();
		} catch (Exception e) {
		}
		return outputStream;
	}

	public ByteArrayOutputStream GetDocumentApproved(Connection connection,
			String id, Map<String,Client> clients, Map<String,Debtor> debtors) {

		Document document = new Document();
		ByteArrayOutputStream outputStream = null;
		try {
			BaseFont bf_courier = BaseFont.createFont(BaseFont.COURIER,
					"Cp1252", false);
			BaseFont bf_cambriaz = BaseFont
					.createFont(
							"http://live.invoicepayment.ca/ipspayers/IPS2/font/cambriab.ttf",
							BaseFont.WINANSI, false);
			BaseFont bf_cambria = BaseFont
					.createFont(
							"http://live.invoicepayment.ca/ipspayers/IPS2/font/cambriab.ttf",
							BaseFont.WINANSI, false);
			BaseFont bf_cambrial = BaseFont
					.createFont(
							"http://live.invoicepayment.ca/ipspayers/IPS2/font/Cambria.ttf",
							BaseFont.WINANSI, false);

			Font cambria9 = new Font(bf_cambria, 9);
			Font cambria12 = new Font(bf_cambria, 10);
			Font cambrial9 = new Font(bf_cambrial, 9);
			Font cambria9Red = new Font(bf_cambrial, 9);
			cambria9Red.setColor(Color.RED);

			outputStream = new ByteArrayOutputStream();
			PdfWriter writere = PdfWriter.getInstance(document, outputStream);
			document.open();
			document.add(new Paragraph(""));
			com.lowagie.text.Image image = com.lowagie.text.Image
					.getInstance("http://live.invoicepayment.ca/images/logoIPS.gif");
			image.setAbsolutePosition(595 - image.getScaledWidth(), 760);
			image.scaleToFit(73, 55);
			document.add(image);
			PdfContentByte cbe = writere.getDirectContent();
			int y_line2 = 800;
			cbe.beginText();
			cbe.setFontAndSize(bf_cambria, 14);
			String text = "Transaction Approved";
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);
			y_line2 = y_line2 - 20;
			cbe.setFontAndSize(bf_cambriaz, 10);
			text = "Thank you for using the IPS eCheque service.";
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);
			y_line2 = y_line2 - 20;
			text = "Please print this page for your records";
			cbe.setFontAndSize(bf_cambriaz, 9);
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);
			y_line2 = y_line2 - 20;
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
				// text ="Total Amount: $" + totalpayment + " "+ currency ;
				cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60,
						y_line2, 0);
				text = "Approved Amount: " + totalpaymentoriginal + " "
						+ rs.getString("CurrencyType");// rs.getString("InvoiceAmount")
				y_line2 = y_line2 - 20;
				cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60,
						y_line2, 0);

				text = "Approved Payment Number: " + id;
				y_line2 = y_line2 - 20;
				cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60,
						y_line2, 0);

				Date date2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
						.parse(rs.getString("InvoiceDate"));
				SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
						"yyyy/MM/dd HH:mm");
				String datep = simpleDateFormat.format(date2);
				text = "Date and Time: " + datep;
				y_line2 = y_line2 - 20;

				cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60,
						y_line2, 0);
				y_line2 = y_line2 - 20;
				cbe.moveTo(70, y_line2);
				cbe.lineTo(440, y_line2);
				cbe.stroke();

			}

			text = "Approved Invoice Payments:";
			y_line2 = y_line2 - 20;
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);
			y_line2 = y_line2 - 5;
			cbe.moveTo(60, y_line2);
			cbe.lineTo(170, y_line2);
			cbe.stroke();
			y_line2 = y_line2 - 10;

			PdfPTable table = new PdfPTable(5);
			table.setSpacingBefore(y_line2);
			table.setTotalWidth(500);
			float[] columnWidths = new float[] { 100f, 100f, 100f, 100f, 100f };
			table.setWidths(columnWidths);

			// cb.setFontAndSize(bf_cambria, 8);
			Paragraph p = new Paragraph("Paid Invoices", cambria12);
			// PdfPCell c = new PdfPCell (p);
			// c.setColspan(6);
			// c.setBorder(Rectangle.NO_BORDER);
			// table.addCell(c);
			// table.endHeaders();

			// c = new PdfPCell(new Paragraph("Confirmation No.",cambria9));
			// c.setBorder(Rectangle.NO_BORDER);
			// table.addCell(c);
			PdfPCell c = new PdfPCell(new Paragraph("Supplier", cambria9));
			c.setBorder(Rectangle.NO_BORDER);
			// c.setBorderColor(new Color(255, 0, 0));
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

			/*
			 * c = new PdfPCell(new Paragraph("Discount / Credit",cambria9));
			 * c.setBorder(Rectangle.NO_BORDER); table.addCell(c);
			 */

			c = new PdfPCell(new Paragraph("Payment Amount", cambria9));
			c.setBorder(Rectangle.NO_BORDER);
			c.setHorizontalAlignment(Element.ALIGN_RIGHT);

			table.addCell(c);

			// String sql =
			// "SELECT pa.*,Client.name1 FROM invoicepayment pa Left join Factor.dbo.Client  on Client.sysid = pa.payee where pa.InvoiceTransactionId="+id;
			cs = connection.prepareCall("exec ipclient_m ?");
			// cs = connection.prepareStatement(sql);
			cs.setString(1, String.valueOf(id));
			rs = cs.executeQuery();
			// loop=0;
			int counter = 0;
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

				// name="amount" + counter;
				NumberFormat fmt = NumberFormat.getCurrencyInstance(Locale.US);
				Double d = Double.parseDouble(rs.getString("amount"));
				String cur = fmt.format(d);
				// cur .format(format, args);
				c = new PdfPCell(new Paragraph(cur, cambrial9));
				c.setBorder(Rectangle.NO_BORDER);
				c.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(c);

				/*
				 * Double x = Double.parseDouble(rs.getString("amount"))
				 * -Double.parseDouble(rs.getString("paymentamount")); c = new
				 * PdfPCell(new Paragraph("$"+x,cambria9));
				 * c.setBorder(Rectangle.NO_BORDER); table.addCell(c);
				 */
				// name="paymentamount" + counter;
				d = Double.parseDouble(rs.getString("paymentamount"));
				cur = fmt.format(d);
				c = new PdfPCell(new Paragraph(cur, cambrial9));
				c.setBorder(Rectangle.NO_BORDER);
				c.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(c);

				/*
				 * if (rs.getString("Comments").length()>0) { c = new
				 * PdfPCell(new
				 * Paragraph("Note: "+rs.getString("Comments"),cambrial9));
				 * c.setBorder(Rectangle.NO_BORDER); c.setColspan(6);
				 * table.addCell(c);
				 * 
				 * }
				 */

			}
			/*
			 * c=new PdfPCell(new Paragraph(""));
			 * c.setBorder(Rectangle.NO_BORDER); c.setColspan(6);
			 * c.setFixedHeight(20);
			 * 
			 * table.addCell(c); c = new PdfPCell(new Paragraph(
			 * "Please allow up to 48 hours for the payment to be posted and for the corresponding invoice(s) to be removed from your invoice payable aging."
			 * ,cambria9Red)); c.setBorder(Rectangle.NO_BORDER);
			 * c.setColspan(6); table.addCell(c); // table. table.completeRow();
			 * table.writeSelectedRows(0, -1, 50, y_line2 , cb);
			 */
			table.writeSelectedRows(0, -1, 60, y_line2, cbe);
			cbe.endText();
			document.close();
		} catch (Exception e) {
		}
		return outputStream;
	}

	public void SendDebtorEmail(ByteArrayOutputStream outputStream,
			String invId, String name, String comment, String email) {
		Properties props = new Properties();
		// props.setProperty("mail.host", "ips-srv005.ips-corporation.net");
		// props.setProperty("mail.smtp.port", "25");
		// props.setProperty("mail.smtp.auth", "true");
		// props.setProperty("mail.smtp.starttls.enable", "true");
		// final String login = "webserver";
		// final String password = "testing";

		// props.setProperty("mail.host", "smtp.gmail.com");
		// props.setProperty("mail.smtp.port", "587");
		// final String login="invoicepayment2@gmail.com";
		// final String password="P@ssword12";
		props.setProperty("mail.host", "mail.ips-corporation.net");
		props.setProperty("mail.smtp.port", "25");
		// final String login="echeque";
		// final String password="BUvu4rej";
		final String login = "webserver";
		final String password = "testing";

		props.setProperty("mail.smtp.auth", "false");
		props.setProperty("mail.smtp.starttls.enable", "true");
		try {
			Session session = Session.getInstance(props, new Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(login, password);
				}
			});
			// String from="webserver@invoicepayment.ca";
			String from = "echeque@invoicepayment.ca";
			//String to = email;
			String to="invoicefollowup@invoicepayment.ca";
			//String to="rrasile@hotmail.com";
			String subject = "Invoice Payment No. " + invId + " Declined";

			MimeMultipart multipart = new MimeMultipart("related");
			BodyPart messageBodyPart = new MimeBodyPart();

			String message = "Dear " + name + "<br>";
			message = message
					+ "We are sending this email regarding a payment submitted through the IPS eCheque. <br>Unfortunately, this payment has been declined by the bank.<br><br>";
			message = message + "     Reason: " + comment;
			message = message + "<br><br>";
			message = message
					+ "Please log in again to re-submit this payment and close the IPS invoice(s) payable in question. <br>";
			// message = message +
			// "Thank you for your time & best regards,<br><br>";
			// message = message +
			// "<table><tr><td><img src=\"cid:image\"></td><td><table>";
			// message = message +"<tr><td><i>Invoice Follow-up</i></td></tr>";
			// message = message +"<tr><td>Tel: 905-670-4838 Ex: 227</td></tr>";
			// message = message +"<tr><td>Fax: 905-670-4221</td></tr>";
			// message = message
			// +"<tr><td><a href=http://www.invoicepayment.ca>www.invoicepayment.ca</a></td></tr>";
			// message = message + "</table></td></tr>";
			// message = message + "</table></td></tr></table>";

			String htmlText = "<H1>Hello</H1><img src=\"cid:image\">";
			messageBodyPart.setContent(message, "text/html");

			DataSource dataSource = new javax.mail.util.ByteArrayDataSource(
					outputStream.toByteArray(), "application/pdf");
			MimeBodyPart pdfBodyPart = new MimeBodyPart();
			pdfBodyPart.setDataHandler(new DataHandler(dataSource));
			pdfBodyPart.setFileName("TransactionDeclined_" + invId + ".pdf");

			// add it
			multipart.addBodyPart(messageBodyPart);
			multipart.addBodyPart(pdfBodyPart);

			// second part (the image)
			messageBodyPart = new MimeBodyPart();
			// DataSource fds = new
			// FileDataSource("/usr/local/tomcat/webapps/payer/images/IPSLogo.jpg");
			DataSource fds = new FileDataSource(
					"C:\\Tomcat 6.0\\webapps\\ROOT\\images\\IPSLogo.jpg");
			// DataSource fds = new
			// FileDataSource("C:\\plato\\jag\\work\\workspace\\IPS2\\WebContent\\images\\IPSLogo.jpg");
			messageBodyPart.setDataHandler(new DataHandler(fds));
			messageBodyPart.setHeader("Content-ID", "<image>");
			multipart.addBodyPart(messageBodyPart);
			MimeMessage msg = new MimeMessage(session);
			msg.setContent(multipart);
			msg.setSubject(subject);
			msg.setFrom(new InternetAddress(from));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
			Transport.send(msg);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void SendDebtorApprovedEmail(ByteArrayOutputStream outputStream,
			String invId, String name, String comment, String email) {
		Properties props = new Properties();
		// props.setProperty("mail.host", "ips-srv005.ips-corporation.net");
		// props.setProperty("mail.smtp.port", "25");
		// props.setProperty("mail.smtp.auth", "true");
		// props.setProperty("mail.smtp.starttls.enable", "true");
		// final String login = "webserver";
		// final String password = "testing";

		// props.setProperty("mail.host", "smtp.gmail.com");
		// props.setProperty("mail.smtp.port", "587");
		// final String login="invoicepayment2@gmail.com";
		// final String password="P@ssword12";
		props.setProperty("mail.host", "mail.ips-corporation.net");
		props.setProperty("mail.smtp.port", "25");
		// final String login="echeque";
		// final String password="BUvu4rej";
		final String login = "webserver";
		final String password = "testing";

		props.setProperty("mail.smtp.auth", "false");
		props.setProperty("mail.smtp.starttls.enable", "true");
		try {
			Session session = Session.getInstance(props, new Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(login, password);
				}
			});
			String from = "echeque@invoicepayment.ca";
			// String from="webserver@invoicepayment.ca";
			//String to = email;
			String to="invoicefollowup@invoicepayment.ca";
			//String to="rrasile@hotmail.com";
			String subject = "Invoice Payment No. " + invId + " Approved";

			MimeMultipart multipart = new MimeMultipart("related");
			BodyPart messageBodyPart = new MimeBodyPart();

			String message = "Dear " + name + "<br>";
			// message = message +
			// "We are sending this email to confirm that Payment # " + invId +
			// " submitted through the IPS eCheque has been<br>approved by the bank.<br><br>";
			message = message
					+ "We are sending this email to confirm that Payment # "
					+ invId
					+ " submitted through the IPS eCheque has been approved by the bank.<br><br>";
			// message = message + "     Reason: " + comment;
			// message = message + "<br><br>";
			message = message
					+ "Please allow us some time, typically by the end of the current business day before you can see this payment applied to the invoice payable(s) in question.<br>";
			// message = message +
			// "Thank you for your time & best regards,<br><br>";
			// message = message +
			// "<table><tr><td><img src=\"cid:image\"></td><td><table>";
			// message = message +"<tr><td><i>Invoice Follow-up</i></td></tr>";
			// message = message +"<tr><td>Tel: 905-670-4838 Ex: 227</td></tr>";
			// message = message +"<tr><td>Fax: 905-670-4221</td></tr>";
			// message = message
			// +"<tr><td><a href=http://www.invoicepayment.ca>www.invoicepayment.ca</a></td></tr>";
			// message = message + "</table></td></tr>";
			// message = message + "</table></td></tr></table>";

			String htmlText = "<H1>Hello</H1><img src=\"cid:image\">";
			messageBodyPart.setContent(message, "text/html");

			DataSource dataSource = new javax.mail.util.ByteArrayDataSource(
					outputStream.toByteArray(), "application/pdf");
			MimeBodyPart pdfBodyPart = new MimeBodyPart();
			pdfBodyPart.setDataHandler(new DataHandler(dataSource));
			pdfBodyPart.setFileName("TransactionApproved_" + invId + ".pdf");

			// add it
			multipart.addBodyPart(messageBodyPart);
			multipart.addBodyPart(pdfBodyPart);

			// second part (the image)
			messageBodyPart = new MimeBodyPart();
			// DataSource fds = new
			// FileDataSource("/usr/local/tomcat/webapps/payer/images/IPSLogo.jpg");
			DataSource fds = new FileDataSource(
					"C:\\Program Files\\Tomcat 7.0\\webapps\\ROOT\\images\\IPSLogo.jpg");
			// DataSource fds = new
			// FileDataSource("C:\\plato\\jag\\work\\workspace\\IPS2\\WebContent\\images\\IPSLogo.jpg");
			messageBodyPart.setDataHandler(new DataHandler(fds));
			messageBodyPart.setHeader("Content-ID", "<image>");
			multipart.addBodyPart(messageBodyPart);
			MimeMessage msg = new MimeMessage(session);
			msg.setContent(multipart);
			msg.setSubject(subject);
			msg.setFrom(new InternetAddress(from));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
			// msg.addRecipient(Message.RecipientType.CC, new
			// InternetAddress("youssef.shatila@systembind.com"));
			Transport.send(msg);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void SendEmailDeclined(String invId, String comment, String name,
			String client, String amount, Connection con,
			ByteArrayOutputStream outputStream) {
		Properties props = new Properties();
		// props.setProperty("mail.host", "smtp.gmail.com");
		// props.setProperty("mail.smtp.port", "587");
		// final String login="invoicepayment2@gmail.com";
		// final String password="P@ssword12";
		// props.setProperty("mail.host", "ips-srv005.ips-corporation.net");
		// props.setProperty("mail.smtp.port", "25");
		props.setProperty("mail.host", "mail.ips-corporation.net");
		props.setProperty("mail.smtp.port", "25");
		// final String login="echeque";
		// final String password="BUvu4rej";
		final String login = "webserver";
		final String password = "testing";

		props.setProperty("mail.smtp.auth", "false");
		props.setProperty("mail.smtp.starttls.enable", "true");

		// final String login = "webserver";
		// final String password = "testing";
		try {
			Session session = Session.getInstance(props,
					new javax.mail.Authenticator() {
						protected PasswordAuthentication getPasswordAuthentication() {
							return new PasswordAuthentication(login, password);
						}
					});

			/*
			 * String subject = "Invoice (" + invId + ") Declined"; MimeMessage
			 * mimeMessage = new MimeMessage(session); String
			 * from="webserver@invoicepayment.ca"; String
			 * to="youssef.shatila@systembind.ca"; // String
			 * to="invoicefollowup@invoicepayment.ca"; InternetAddress iaSender
			 * = new InternetAddress(from); InternetAddress iaRecipient = new
			 * InternetAddress(to); mimeMessage.setFrom(iaSender);
			 * mimeMessage.setSender(iaSender); mimeMessage.setSubject(subject);
			 * mimeMessage.setRecipient(Message.RecipientType.TO, iaRecipient);
			 * // mimeMessage.setContent(subject); mimeMessage.setText(subject);
			 * Transport.send(mimeMessage);
			 */
			// String from="webserver@invoicepayment.ca";
			String from = "echeque@invoicepayment.ca";
			String to = "invoicefollowup@invoicepayment.ca";
			String to3 = "payments@invoicepayment.ca";
			String to2 = "youssef.shatila@systembind.com";
			String subject = "Invoice Payment No. " + invId + " Declined";
			MimeMultipart multipart = new MimeMultipart("related");
			BodyPart messageBodyPart = new MimeBodyPart();

			String message = "Attention<br>";
			message = message + "Payment " + invId
					+ " has been declined by the bank.<br><Br>";
			message = message + "		Reason: " + comment + "<br><br>";
			message = message + "<u>Details</u><br>";
			message = message + "Payer:" + name + "<br>";
			message = message + "Client:" + client + "<br>";
			message = message + "Invoice Payment No.:" + invId + "<br>";
			message = message + "Amount:" + amount + "<br>";
			message = message + "<br><br><br>";
			message = message
					+ "Please follow up with the payer to rectify the situation.<br><br>";
			// message = message +
			// "<b>IPS eCheque � Online Payment Feature</b>";
			// final login="businessdevelopment";
			// final String password="devness";
			props = new Properties();
			// props.setProperty("mail.host", "mail.invoicepayment.ca");
			// props.setProperty("mail.smtp.port", "25");
			messageBodyPart.setContent(message, "text/html");

			DataSource dataSource = new javax.mail.util.ByteArrayDataSource(
					outputStream.toByteArray(), "application/pdf");
			MimeBodyPart pdfBodyPart = new MimeBodyPart();
			pdfBodyPart.setDataHandler(new DataHandler(dataSource));
			pdfBodyPart.setFileName("TransactionDeclined_" + invId + ".pdf");

			// add it
			multipart.addBodyPart(messageBodyPart);
			multipart.addBodyPart(pdfBodyPart);

			MimeMessage msg = new MimeMessage(session);
			msg.setContent(multipart);
			msg.setSubject(subject);
			// msg.setText(text, "utf-8", "html");
			// msg.setText(message,"utf-8", "html");
			msg.setSubject(subject);
			msg.setFrom(new InternetAddress(from));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
			msg.addRecipient(Message.RecipientType.CC, new InternetAddress(to3));
			Transport.send(msg);

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public void SendEmailApproved(String invId, String comment, String name,
			String client, String amount, Connection con,
			ByteArrayOutputStream outputStream) {
		Properties props = new Properties();
		// props.setProperty("mail.host", "smtp.gmail.com");
		// props.setProperty("mail.smtp.port", "587");
		// final String login="invoicepayment2@gmail.com";
		// final String password="P@ssword12";
		// props.setProperty("mail.host", "ips-srv005.ips-corporation.net");
		// props.setProperty("mail.smtp.port", "25");
		props.setProperty("mail.host", "mail.ips-corporation.net");
		props.setProperty("mail.smtp.port", "25");
		// final String login="echeque";
		// final String password="BUvu4rej";
		final String login = "webserver";
		final String password = "testing";
		props.put("mail.smtp.auth", "false");
		props.put("mail.smtp.starttls.enable", "true");
		props.setProperty("mail.smtp.auth", "false");
		props.setProperty("mail.smtp.starttls.enable", "true");

		// final String login = "webserver";
		// final String password = "testing";
		try {
			Session session = Session.getInstance(props,
					new javax.mail.Authenticator() {
						protected PasswordAuthentication getPasswordAuthentication() {
							return new PasswordAuthentication(login, password);
						}
					});

			/*
			 * String subject = "Invoice (" + invId + ") Declined"; MimeMessage
			 * mimeMessage = new MimeMessage(session); String
			 * from="webserver@invoicepayment.ca"; String
			 * to="youssef.shatila@systembind.ca"; // String
			 * to="invoicefollowup@invoicepayment.ca"; InternetAddress iaSender
			 * = new InternetAddress(from); InternetAddress iaRecipient = new
			 * InternetAddress(to); mimeMessage.setFrom(iaSender);
			 * mimeMessage.setSender(iaSender); mimeMessage.setSubject(subject);
			 * mimeMessage.setRecipient(Message.RecipientType.TO, iaRecipient);
			 * // mimeMessage.setContent(subject); mimeMessage.setText(subject);
			 * Transport.send(mimeMessage);
			 */
			// String from="webserver@invoicepayment.ca";
			// String to="invoicefollowup@invoicepayment.ca";
			String from = "echeque@invoicepayment.ca";
			String to = "payments@invoicepayment.ca";

			String to2 = "youssef.shatila@systembind.com";
			String subject = "Invoice Payment No. " + invId + " Approved";
			MimeMultipart multipart = new MimeMultipart("related");
			BodyPart messageBodyPart = new MimeBodyPart();

			String message = "Attention<br>";
			message = message + "Payment " + invId
					+ " has been Approved by the bank.<br><Br>";
			// message = message + "		Reason: " + comment +"<br><br>";
			message = message + "<u>Details</u><br>";
			message = message + "Payer:" + name + "<br>";
			message = message + "Client:" + client + "<br>";
			message = message + "Invoice Payment No.:" + invId + "<br>";
			message = message + "Amount:" + amount + "<br>";
			message = message + "<br><br><br>";
			// message = message +
			// "Please follow up with the payer to rectify the situation.<br><br>";
			// message = message +
			// "<b>IPS eCheque � Online Payment Feature</b>";
			// final login="businessdevelopment";
			// final String password="devness";
			props = new Properties();
			// props.setProperty("mail.host", "mail.invoicepayment.ca");
			// props.setProperty("mail.smtp.port", "25");
			messageBodyPart.setContent(message, "text/html");

			DataSource dataSource = new javax.mail.util.ByteArrayDataSource(
					outputStream.toByteArray(), "application/pdf");
			MimeBodyPart pdfBodyPart = new MimeBodyPart();
			pdfBodyPart.setDataHandler(new DataHandler(dataSource));
			pdfBodyPart.setFileName("TransactionApproved_" + invId + ".pdf");

			// pdfBodyPart.setFileName("TransactionDeclined_" +invId + ".pdf");

			// add it
			multipart.addBodyPart(messageBodyPart);
			multipart.addBodyPart(pdfBodyPart);

			MimeMessage msg = new MimeMessage(session);
			msg.setContent(multipart);
			msg.setSubject(subject);
			// msg.setText(text, "utf-8", "html");
			// msg.setText(message,"utf-8", "html");
			msg.setSubject(subject);
			msg.setFrom(new InternetAddress(from));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
			// msg.addRecipient(Message.RecipientType.CC, new
			// InternetAddress(to2));
			Transport.send(msg);

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public void SendEmail(String invId, String acctId, Connection con, Map<String,Client> clients) {

		Document document = new Document();
		try {
			BaseFont bf_courier = BaseFont.createFont(BaseFont.COURIER,
					"Cp1252", false);
			BaseFont bf_cambriaz = BaseFont
					.createFont(
							"http://live.invoicepayment.ca/ipspayers/IPS2/font/cambriab.ttf",
							BaseFont.WINANSI, false);
			BaseFont bf_cambria = BaseFont
					.createFont(
							"http://live.invoicepayment.ca/ipspayers/IPS2/font/cambriab.ttf",
							BaseFont.WINANSI, false);
			BaseFont bf_cambrial = BaseFont
					.createFont(
							"http://live.invoicepayment.ca/ipspayers/IPS2/font/Cambria.ttf",
							BaseFont.WINANSI, false);

			ResultSet rs = null;
			java.sql.PreparedStatement ps = null;
			
			Map<String, Debtor> debtors = FactorDBService.getInstance().getDebtors();			
			
			// FACTOR-DEBTOR
			ps = con.prepareStatement("SELECT pa.payerid, i.InvoiceAmount,i.SysId from PayersAccounts pa join invoicetransaction i on i.SysAcctId = pa.SysId where i.SysId="
					+ invId);
			rs = ps.executeQuery();
			double invAmount = 0;
			String name1 = "";
			String debtor = "";
			// String invId;
			while (rs.next()) {
				String payerid = rs.getString("payerid");
				Debtor d = debtors.get(payerid);
				name1 = d.getName1() + " " + d.getName2();
				invAmount = Double.parseDouble(rs.getString("InvoiceAmount"));
				debtor = d.getDebtorId();

			}
			NumberFormat fmt = NumberFormat.getCurrencyInstance(Locale.US);
			String amt = fmt.format(invAmount);

			// http://localhost:8080/IPS2/
			Font courier = new Font(bf_courier, 9);
			Font cambria9 = new Font(bf_cambria, 9);
			Font cambria12 = new Font(bf_cambria, 10);
			Font cambrial9 = new Font(bf_cambrial, 9);
			Font cambria9Red = new Font(bf_cambrial, 9);
			cambria9Red.setColor(Color.RED);

			// ServletOutputStream os = response.getOutputStream();
			ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
			PdfWriter writere = PdfWriter.getInstance(document, outputStream);
			// Code 2
			// PdfWriter writer2 = PdfWriter.getInstance(document,
			// outputStream2);
			document.open();
			// PdfContentByte canvas = writer.getDirectContent();
			document.add(new Paragraph(""));
			com.lowagie.text.Image image = com.lowagie.text.Image
					.getInstance("http://live.invoicepayment.ca/images/logoIPS.gif");
			// http://localhost:8080/IPS2/
			image.setAbsolutePosition(595 - image.getScaledWidth(), 760);
			image.scaleToFit(73, 55);

			document.add(image);

			PdfContentByte cbe = writere.getDirectContent();
			cbe.setLineWidth(1f);

			int y_line1 = 850;
			int y_line2 = 800;
			int y_line3 = y_line2 - 50;

			cbe.beginText();
			cbe.setFontAndSize(bf_cambria, 14);

			String text = "Transaction Deleted";
			// cb.showTextAligned(PdfContentByte.ALIGN_CENTER, text + " Center",
			// 250, y_line1, 0);
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);

			y_line2 = y_line2 - 20;
			cbe.setFontAndSize(bf_cambrial, 10);

			// text ="Payment Date: " + invoicedate;
			text = "Thank you for using the IPS eCheque service.";
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);

			y_line2 = y_line2 - 20;
			// text ="Account number: " + accountnum;
			text = "Please print this page for your records";
			cbe.setFontAndSize(bf_cambrial, 9);
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);

			cbe.setFontAndSize(bf_cambria, 10);
			text = "Payer: ";
			y_line2 = y_line2 - 20;
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);
			cbe.setFontAndSize(bf_cambrial, 10);
			text = name1 + " /(" + debtor.trim() + ")";
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 100, y_line2,
					0);

			cbe.setFontAndSize(bf_cambria, 10);
			text = "Deleted Amount: ";
			y_line2 = y_line2 - 20;
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);
			cbe.setFontAndSize(bf_cambrial, 10);
			text = amt;
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 150, y_line2,
					0);

			cbe.setFontAndSize(bf_cambria, 10);
			text = "Deleted Payment Number: ";
			y_line2 = y_line2 - 20;
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);
			cbe.setFontAndSize(bf_cambrial, 10);
			text = invId;
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 190, y_line2,
					0);

			SimpleDateFormat sTimeStamp = new SimpleDateFormat(
					"dd MMMM yyyy 'at' hh:MM a z");
			// Calendar c = new Calendar().getInstance();
			String timeStamp = sTimeStamp.format(new Date());
			cbe.setFontAndSize(bf_cambria, 10);
			text = "Date and Time: ";
			y_line2 = y_line2 - 20;
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);
			cbe.setFontAndSize(bf_cambrial, 10);
			text = timeStamp;
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 150, y_line2,
					0);

			y_line2 = y_line2 - 30;
			cbe.moveTo(70, y_line2);
			cbe.lineTo(440, y_line2);
			cbe.stroke();
			y_line2 = y_line2 - 30;

			cbe.setFontAndSize(bf_cambria, 12);

			text = "Deleted Invoice Payments";
			// cb.showTextAligned(PdfContentByte.ALIGN_CENTER, text + " Center",
			// 250, y_line1, 0);
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);
			cbe.endText();

			PdfPTable table = new PdfPTable(5);
			y_line2 = y_line2 - 20;
			table.setSpacingBefore(y_line2);
			table.setTotalWidth(500);

			PdfPCell c;
			// cb.setFontAndSize(bf_cambria, 8);
			c = new PdfPCell(new Paragraph("Supplier", cambria9));
			c.setBorder(Rectangle.NO_BORDER);
			// c.setBorderColor(new Color(255, 0, 0));
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

			/*
			 * c = new PdfPCell(new Paragraph("Discount / Credit",cambria9));
			 * c.setBorder(Rectangle.NO_BORDER); table.addCell(c);
			 */

			c = new PdfPCell(new Paragraph("Payment Amount", cambria9));
			c.setBorder(Rectangle.NO_BORDER);
			c.setHorizontalAlignment(Element.ALIGN_RIGHT);

			table.addCell(c);

			// String sql =
			// "SELECT pa.*,Client.name1 FROM invoicepayment pa Left join Client  on Client.sysid = pa.payee where pa.InvoiceTransactionId="+id;
			CallableStatement cs = con.prepareCall("exec ipclient_m ?");
			// cs = connection.prepareStatement(sql);
			cs.setString(1, String.valueOf(invId));
			rs = cs.executeQuery();
			// loop=0;
			int counter = 0;
			while (rs.next()) {
				String payee = rs.getString("payee");
				String invoicenumber = rs.getString("invoicenumber");
				Client cl = clients.get(payee);
				Invoice inv = FactorDBService.getInstance().getInvoice(invoicenumber);
				
				String name = null;
				if (cl == null || cl.getName1() == null) {
					name = rs.getString("payeeextra");
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

				// name="amount" + counter;
				// fmt = NumberFormat.getCurrencyInstance(Locale.US);
				Double d = Double.parseDouble(rs.getString("amount"));
				String cur = fmt.format(d);
				// cur .format(format, args);
				c = new PdfPCell(new Paragraph(cur, cambrial9));
				c.setBorder(Rectangle.NO_BORDER);
				c.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(c);

				/*
				 * Double x = Double.parseDouble(rs.getString("amount"))
				 * -Double.parseDouble(rs.getString("paymentamount")); c = new
				 * PdfPCell(new Paragraph("$"+x,cambria9));
				 * c.setBorder(Rectangle.NO_BORDER); table.addCell(c);
				 */
				// name="paymentamount" + counter;
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
			// c = new PdfPCell(new
			// Paragraph("Please allow up to 48 hours for the payment to be posted and for the corresponding invoice(s) to be removed from your invoice payable aging.",cambria9Red));
			// c.setBorder(Rectangle.NO_BORDER);

			// c.setColspan(6);
			// table.addCell(c);
			// table.
			table.completeRow();

			table.writeSelectedRows(0, -1, 50, y_line2, cbe);

			document.close();
			// String from="webserver@invoicepayment.ca";
			String from = "echeque@invoicepayment.ca";
			// String to="Youssef.shatila@systembind.com";
			DataSource dataSource = new javax.mail.util.ByteArrayDataSource(
					outputStream.toByteArray(), "application/pdf");
			MimeBodyPart pdfBodyPart = new MimeBodyPart();
			pdfBodyPart.setDataHandler(new DataHandler(dataSource));
			pdfBodyPart.setFileName("TransactionDeleted_" + invId + ".pdf");

			MimeBodyPart textBodyPart = new MimeBodyPart();
			String content = "Please note that "
					+ name1
					+ " has deleted the previously submitted payment in the amount of "
					+ amt + " through the IPS eCheque. Details are attached.  ";
			;
			String sender = from; // replace this with a valid sender email
									// address
			// String recipient = to; //replace this with
			String subject = "eCheque payment deleted - " + name1; // this will
																	// be the
																	// subject
																	// of the
																	// email
			textBodyPart.setText(content);
			InternetAddress iaSender = new InternetAddress(sender);
			InternetAddress iaRecipient = new InternetAddress(adminEmail);

			MimeMultipart mimeMultipart = new MimeMultipart();
			mimeMultipart.addBodyPart(textBodyPart);
			mimeMultipart.addBodyPart(pdfBodyPart);

			// construct the mime message

			Properties props = new Properties();
			// props.setProperty("mail.host", "mail.invoicepayment.ca");
			// // props.setProperty("mail.smtp.port", "25");
			// props.setProperty("mail.host", "smtp.gmail.com");
			// props.setProperty("mail.smtp.port", "587");

			// props.setProperty("mail.smtp.port", "25");

			props.setProperty("mail.host", "mail.ips-corporation.net");
			props.setProperty("mail.smtp.port", "25");
			props.setProperty("mail.smtp.auth", "false");
			props.setProperty("mail.smtp.starttls.enable", "true");
			// final String login="echeque";
			// final String password="BUvu4rej";
			final String login = "webserver";
			final String password = "testing";
			// final String login="invoicepayment2@gmail.com";
			// final String password="P@ssword12";
			// final String login = "webserver";
			// final String password = "testing";
			Session session = Session.getInstance(props,
					new javax.mail.Authenticator() {
						protected PasswordAuthentication getPasswordAuthentication() {
							return new PasswordAuthentication(login, password);
						}
					});

			// Properties props = System.getProperties();
			// props.put("mail.smtp.host", "smtp.mail.yahoo.com");
			// Session session = Session.getDefaultInstance(props, null);

			MimeMessage mimeMessage = new MimeMessage(session);
			mimeMessage.setFrom(iaSender);
			mimeMessage.setSender(iaSender);
			mimeMessage.setSubject(subject);
			mimeMessage.setRecipient(Message.RecipientType.TO, iaRecipient);
			mimeMessage.setContent(mimeMultipart);
			Transport.send(mimeMessage);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
