package ProcessAcctData;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.awt.Color;
import java.sql.CallableStatement;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Connection;
import javax.servlet.ServletConfig;
import javax.servlet.ServletOutputStream;

//import com.mysql.jdbc.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.text.DateFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;

import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfWriter;
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.HeaderFooter;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.Rectangle;
import com.lowagie.text.Section;
import com.lowagie.text.Table;

import java.util.Properties;

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
 * Servlet implementation class GeneratedInvoice
 */
public class GeneratedInvoicef extends HttpServlet {
	protected String adminEmail = null;
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GeneratedInvoicef() {
		super();
		// TODO Auto-generated constructor stub
	}

	public void init(ServletConfig servletConfig) throws ServletException {
		this.adminEmail = "payments@invoicepayment.ca";// servletConfig.getInitParameter("email");
		// sc = servletConfig.getServletContext();
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
		
		Connection connection = null;
		try {
			
			Class.forName(DBProperties.JDBC_SQLSERVER_DRIVER);
			connection = (Connection) DriverManager.getConnection(DBProperties.CONNECTION_SQLSERVER_URL, DBProperties.USERNAME_SQLSERVER, DBProperties.PASSWORD_SQLSERVER);


			response.setContentType("application/pdf"); // Code 1
			Document document = new Document();
			String id = request.getParameter("hiddenId");
			// try{
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

			// http://localhost:8080/IPS2/
			// Font courier = new Font(bf_courier,9);
			Font cambria9 = new Font(bf_cambria, 9);
			Font cambria12 = new Font(bf_cambria, 10);
			Font cambrial9 = new Font(bf_cambrial, 9);
			Font cambria9Red = new Font(bf_cambrial, 9);
			cambria9Red.setColor(Color.RED);

			ServletOutputStream os = response.getOutputStream();
			// ByteArrayOutputStream os = new ByteArrayOutputStream();
			PdfWriter writer = PdfWriter.getInstance(document, os);
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

			PdfContentByte cb = writer.getDirectContent();
			PdfContentByte cbe = writere.getDirectContent();
			cb.setLineWidth(1f);
			// int y_line1 = 850;
			int y_line2 = 800;
			// int y_line3 = y_line2 - 50;
			cb.beginText();
			cb.setFontAndSize(bf_cambria, 14);
			cbe.beginText();
			cbe.setFontAndSize(bf_cambria, 14);

			String text = "Transaction termin�e";
			// cb.showTextAligned(PdfContentByte.ALIGN_CENTER, text + " Center",
			// 250, y_line1, 0);
			cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);

			y_line2 = y_line2 - 20;
			cb.setFontAndSize(bf_cambriaz, 10);
			cbe.setFontAndSize(bf_cambriaz, 10);

			// text ="Payment Date: " + invoicedate;
			text = "Nous vous remercions d�avoir utilis� le service de ch�que �lectronique IPS.";
			cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);

			y_line2 = y_line2 - 20;
			// text ="Account number: " + accountnum;
			text = "Veuillez imprimer cette page pour vos dossiers.";
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
			// String sql =
			// "SELECT d.Name1 , d.Name2, d.DebtorId,i.InvoiceDate,i.InvoiceAmount,a.AccountNumber,a.CurrencyType FROM Debtor d join PayersAccounts a on a.PayerId = d.SysId join invoicetransaction i on i.SysAcctId = a.SysId where i.SysId="+id;
			CallableStatement cs = connection.prepareCall("exec citdebtor ?");
			cs.setInt(1, Integer.parseInt(id));
			// ps = connection.prepareStatement(sql);
			rs = cs.executeQuery();
			String totalpaymentoriginal = null;
			while (rs.next()) {
				name1 = rs.getString("Name1") + " " + rs.getString("Name2");
				totalpaymentoriginal = rs.getString("InvoiceAmount");
				text = "Payeur : " + rs.getString("Name1") + " "
						+ rs.getString("Name2") + " / ("
						+ rs.getString("DebtorId").trim() + ")";
				// text ="Total Amount: $" + totalpayment + " "+ currency ;
				cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60,
						y_line2, 0);
				cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60,
						y_line2, 0);
				text = "Montant du paiement : " + totalpaymentoriginal + " "
						+ rs.getString("CurrencyType");// rs.getString("InvoiceAmount")
				y_line2 = y_line2 - 20;
				cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60,
						y_line2, 0);
				cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60,
						y_line2, 0);

				text = "Exp�diteur Bank Account: "
						+ rs.getString("TransitNumber") + " "
						+ rs.getString("BranchCode") + " "
						+ rs.getString("AccountNumber") + " "
						+ rs.getString("CurrencyType");
				y_line2 = y_line2 - 20;
				cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60,
						y_line2, 0);
				cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60,
						y_line2, 0);

				text = "Destinataire : " + "Invoice Payment System Corporation";
				y_line2 = y_line2 - 20;
				cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60,
						y_line2, 0);
				cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60,
						y_line2, 0);

				text = "Num�ro de confirmation : " + id;
				y_line2 = y_line2 - 20;
				cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60,
						y_line2, 0);
				cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60,
						y_line2, 0);

				text = "Num�ro de confirmation : "
						+ rs.getString("InvoiceDate");
				y_line2 = y_line2 - 20;
				cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60,
						y_line2, 0);
				cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60,
						y_line2, 0);

				text = "NOTA :" + "";
				y_line2 = y_line2 - 20;
				cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60,
						y_line2, 0);
				cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60,
						y_line2, 0);
			}
			text = "Si vous souhaitez modifier ou supprimer ce paiement, il faut nous en aviser en";
			y_line2 = y_line2 - 20;
			cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 70, y_line2, 0);
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 70, y_line2, 0);

			text = "composant le 1-888-503-4528,poste 237 avant 16:30 HAE/HNE,ou en soumettant une ";
			y_line2 = y_line2 - 20;
			cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 70, y_line2, 0);
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 70, y_line2, 0);

			text = "demande en ligne avant 18:00,votre heure locale le m�me jour o� vous avez fait ";
			y_line2 = y_line2 - 20;
			cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 70, y_line2, 0);
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 70, y_line2, 0);

			text = "votre paiement.";
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

			// Code 3
			PdfPTable table = new PdfPTable(5);
			y_line2 = y_line2 - 20;
			table.setSpacingBefore(y_line2);
			table.setTotalWidth(500);

			// cb.setFontAndSize(bf_cambria, 8);
			Paragraph p = new Paragraph("Factures pay�es :", cambria12);
			// p.setFont(cambria9);
			PdfPCell c = new PdfPCell(p);

			c.setColspan(6);
			c.setBorder(Rectangle.NO_BORDER);

			table.addCell(c);
			// table.endHeaders();

			// c = new PdfPCell(new Paragraph("Confirmation No.",cambria9));
			// c.setBorder(Rectangle.NO_BORDER);
			// table.addCell(c);
			c = new PdfPCell(new Paragraph("Fournisseur", cambria9));
			c.setBorder(Rectangle.NO_BORDER);
			// c.setBorderColor(new Color(255, 0, 0));
			table.addCell(c);
			c = new PdfPCell(new Paragraph("N� de facture", cambria9));
			c.setBorder(Rectangle.NO_BORDER);
			table.addCell(c);
			c = new PdfPCell(new Paragraph("N� de bon de commande", cambria9));
			c.setBorder(Rectangle.NO_BORDER);
			table.addCell(c);
			c = new PdfPCell(new Paragraph("Montant", cambria9));
			c.setBorder(Rectangle.NO_BORDER);
			c.setHorizontalAlignment(Element.ALIGN_RIGHT);

			table.addCell(c);

			/*
			 * c = new PdfPCell(new Paragraph("Discount / Credit",cambria9));
			 * c.setBorder(Rectangle.NO_BORDER); table.addCell(c);
			 */

			c = new PdfPCell(new Paragraph("Montant du paiement", cambria9));
			c.setBorder(Rectangle.NO_BORDER);
			c.setHorizontalAlignment(Element.ALIGN_RIGHT);

			table.addCell(c);

			// String sql =
			// "SELECT pa.*,Client.name1 FROM invoicepayment pa Left join Client  on Client.sysid = pa.payee where pa.InvoiceTransactionId="+id;
			cs = connection.prepareCall("exec ipclient ?");
			// cs = connection.prepareStatement(sql);
			cs.setString(1, String.valueOf(id));
			rs = cs.executeQuery();
			// loop=0;
			int counter = 0;
			while (rs.next()) {
				// table.addCell(String.valueOf(id));
				// table.addCell("Amount");

				// c = new PdfPCell(new
				// Paragraph(rs.getString("SysId"),cambrial9));
				// c.setBorder(Rectangle.NO_BORDER);
				// table.addCell(c);

				// name="clientid" + counter;
				String name = rs.getString("name1");
				if (name == null)
					name = rs.getString("payee");
				c = new PdfPCell(new Paragraph(name, cambrial9));
				c.setBorder(Rectangle.NO_BORDER);
				table.addCell(c);

				c = new PdfPCell(
						new Paragraph(rs.getString("InvId"), cambrial9));
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
			// table.
			table.completeRow();
			table.writeSelectedRows(0, -1, 50, y_line2, cb);
			table.writeSelectedRows(0, -1, 50, y_line2, cbe);

			// document.add(table);

			/*
			 * Paragraph title = null; Chapter chapter = null; Section section =
			 * null; Section subsection = null; title = new
			 * Paragraph(String.format("Invoice Payment System"));
			 * writer.setBoxSize("art", new Rectangle(36, 54, 559, 788));
			 * document.add(chapter);
			 */
			document.close();
			String from = "webserver@invoicepayment.ca";
			String to2 = "Youssef.shatila@systembind.com";
			DataSource dataSource = new javax.mail.util.ByteArrayDataSource(
					outputStream.toByteArray(), "application/pdf");
			MimeBodyPart pdfBodyPart = new MimeBodyPart();
			pdfBodyPart.setDataHandler(new DataHandler(dataSource));
			pdfBodyPart.setFileName("PaymentConfirmation_" + id + ".pdf");

			MimeBodyPart textBodyPart = new MimeBodyPart();
			String content = "Please note that " + name1
					+ " has submitted a payment in the amount of "
					+ totalpaymentoriginal
					+ " through the IPS eCheque. Details are attached.";
			;
			String sender = from; // replace this with a valid sender email
									// address
			// String recipient = to; //replace this with
			String subject = "eCheque payment submitted � " + name1; // this
																		// will
																		// be
																		// the
																		// subject
																		// of
																		// the
																		// email
			textBodyPart.setText(content);
			InternetAddress iaSender = new InternetAddress(sender);
			InternetAddress iaRecipient = new InternetAddress(adminEmail);

			MimeMultipart mimeMultipart = new MimeMultipart();
			mimeMultipart.addBodyPart(textBodyPart);
			mimeMultipart.addBodyPart(pdfBodyPart);

			// construct the mime message

			Properties props = new Properties();
			props.setProperty("mail.host", "mail.ips-corporation.net");
			// // props.setProperty("mail.smtp.port", "25");
			// props.setProperty("mail.host", "smtp.gmail.com");
			// props.setProperty("mail.smtp.port", "587");
			props.setProperty("mail.smtp.port", "25");
			props.setProperty("mail.smtp.auth", "true");
			props.setProperty("mail.smtp.starttls.enable", "true");
			// final String login="invoicepayment2@gmail.com";
			// final String password="P@ssword12";
			final String login = "webserver";
			final String password = "testing";
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
			// mimeMessage.setRecipients(Message.RecipientType.CC,InternetAddress.parse("youssef.shatila@systembind.com"));
			// mimeMessage.setRecipients(Message.RecipientType.CC,InternetAddress.parse("suarez@invoicepayment.ca"));
			mimeMessage.setRecipients(Message.RecipientType.CC,
					InternetAddress.parse("ali@invoicepayment.ca"));
			mimeMessage.setContent(mimeMultipart);
			Transport.send(mimeMessage);

			/*
			 * String sql =
			 * "SELECT d.Name1 , d.Name2,i.InvoiceDate,i.InvoiceAmount,a.AccountNumber FROM Debtor d join PayersAccounts a on a.PayerId = d.SysId join invoicetransaction i on i.SysAcctId = a.SysId where i.SysId="
			 * +id; cs = connection.prepareCall("{call citdebtor(?)}");
			 * cs.setInt(1, id); //ps = connection.prepareStatement(sql); rs =
			 * cs.executeQuery(); String message="Transaction Complete<br>";
			 * 
			 * if (rs.next()) { message = message +
			 * "Thank you for using IPS eChque service.<br>"; message = message
			 * + "Please print this email for your records.<br>"; text =
			 * "Payer: " + rs.getString("Name1") + " " + rs.getString("Name2");
			 * message = message + text +"<br>"; text = "Payment Amount: $" +
			 * rs.getString("InvoiceAmount"); message = message + text +"<br>";
			 * text = "From: " + rs.getString("AccountNumber");; message =
			 * message + text +"<br>"; text = "To: " +
			 * "Invoice Payment System Corporation"; message = message + text
			 * +"<br>"; text = "Confirmation Number: " + id; message = message +
			 * text +"<br>"; text = "Date and Time: " +
			 * rs.getString("InvoiceDate"); message = message + text +"<br>";
			 * text = "Note:" + ""; message = message + text +"<br>"; text =
			 * "If you need to have this payment modified or deleted, you must advise us by "
			 * ; message = message + text +"<br>"; text =
			 * "calling us at 1-888-503-4528 ext. 237 no later than 4:30pm EDT/EST, or by "
			 * ; message = message + text +"<br>"; text =
			 * "making an online request by 6:00 pm your local time on the same day you "
			 * ; message = message + text +"<br>"; text =
			 * "submitted your payment. "; message = message + text +"<br>";
			 * message = message +"<hr><br>"; message = message +
			 * "Paid Invoices<br>";
			 * 
			 * sql =
			 * "SELECT pa.*,Client.name1 FROM invoicepayment pa Left join Client  on Client.sysid = pa.payee where pa.InvoiceTransactionId="
			 * +id; cs = connection.prepareCall("{call ipclient(?)}"); //ps =
			 * connection.prepareStatement(sql);
			 * cs.setString(1,String.valueOf(id)); rs = cs.executeQuery(); //
			 * loop=0; counter=0; message = message +
			 * "<table border=0 cellpadding=5 cellspacing=5>"; message = message
			 * + "<tr>"; message = message + "<td>Invoice NO.</td>"; message =
			 * message + "<td>Supplier</td>"; message = message +
			 * "<td>Amount</td>"; message = message +
			 * "<td>Discount/Credit</td>"; message = message +
			 * "<td>Payment Amount</td>"; message = message + "</tr>"; while
			 * (rs.next()) { message = message + "<tr>"; message = message +
			 * "<td>" +rs.getString("SysId")+"</td>"; message = message + "<td>"
			 * +rs.getString("name1")+"</td>"; message = message + "<td>"
			 * +rs.getString("amount")+"</td>"; Double x =
			 * Double.parseDouble(rs.getString("amount"))
			 * -Double.parseDouble(rs.getString("paymentamount")); message =
			 * message + "<td>$" + x +"</td>"; message = message + "<td>$"
			 * +rs.getString("paymentamount")+"</td>"; message = message +
			 * "</tr>"; } message = message + "</table>"; }
			 * subject="Invoice Payment"; //final login="businessdevelopment";
			 * //final String password="devness"; props = new Properties(); //
			 * props.setProperty("mail.host", "mail.invoicepayment.ca"); //
			 * props.setProperty("mail.smtp.port", "25");
			 * props.setProperty("mail.host", "smtp.gmail.com");
			 * props.setProperty("mail.smtp.port", "587");
			 * props.setProperty("mail.smtp.auth", "true");
			 * props.setProperty("mail.smtp.starttls.enable", "true"); session =
			 * Session.getDefaultInstance(props, new javax.mail.Authenticator()
			 * { protected PasswordAuthentication getPasswordAuthentication() {
			 * return new PasswordAuthentication(login,password); } });
			 * 
			 * MimeMessage msg = new MimeMessage(session); // msg.setText(text,
			 * "utf-8", "html"); msg.setText(message,"utf-8", "html");
			 * msg.setSubject(subject); msg.setFrom(new InternetAddress(from));
			 * msg.addRecipient(Message.RecipientType.TO, new
			 * InternetAddress(to)); Transport.send(msg);
			 */

			// request.getRequestDispatcher("/PaymentResponse.jsp").forward(request,
			// response);

			// }
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

		}
	}

}
