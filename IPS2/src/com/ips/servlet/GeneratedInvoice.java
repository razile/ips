package com.ips.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.Color;
import java.sql.CallableStatement;
import java.sql.DriverManager;
import java.sql.Connection;
import javax.servlet.ServletConfig;
import javax.servlet.ServletOutputStream;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.text.NumberFormat;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfWriter;
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

import javax.mail.PasswordAuthentication;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.*;
import java.util.*;
import java.io.*;
import javax.activation.DataSource;
import javax.activation.DataHandler;
import javax.mail.internet.InternetAddress;

/**
 * Servlet implementation class GeneratedInvoice
 */
public class GeneratedInvoice extends HttpServlet {
	protected String adminEmail = null;
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GeneratedInvoice() {
		super();
		// TODO Auto-generated constructor stub
	}

	public void init(ServletConfig servletConfig) throws ServletException {
		this.adminEmail = "payments@invoicepayment.ca";// servletConfig.getInitParameter("email");
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
			
			connection = SqlServerDBService.getInstance().openConnection();
			
			Map<String,Client> clients = FactorDBService.getInstance().getClients();
			Map<String,Debtor> debtors = FactorDBService.getInstance().getDebtors();
			
			response.setContentType("application/pdf"); // Code 1
			Document document = new Document();
			String id = request.getParameter("hiddenId");
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
			ServletOutputStream os = response.getOutputStream();
			// ByteArrayOutputStream os = new ByteArrayOutputStream();
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
			CallableStatement cs = connection.prepareCall("exec citdebtor ?");
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
			text = "calling us at 1-888-503-4528 ext. 237 no later than 4:30pm EDT/EST, or by ";
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
			cs = connection.prepareCall("exec ipclient ?");
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
			String sender = from;
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
			Properties props = new Properties();
			props.setProperty("mail.host", "mail.ips-corporation.net");
			// props.setProperty("mail.smtp.port", "25");
			// props.setProperty("mail.host", "smtp.gmail.com");
			// props.setProperty("mail.smtp.port", "587");
			props.setProperty("mail.smtp.port", "25");
			props.setProperty("mail.smtp.auth", "false");
			props.setProperty("mail.smtp.starttls.enable", "false");
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
			MimeMessage mimeMessage = new MimeMessage(session);
			mimeMessage.setFrom(iaSender);
			mimeMessage.setSender(iaSender);
			mimeMessage.setSubject(subject);
			mimeMessage.setRecipient(Message.RecipientType.TO, iaRecipient);
			mimeMessage.setRecipients(Message.RecipientType.CC,
					InternetAddress.parse("youssef.shatila@systembind.com"));
			// mimeMessage.setRecipients(Message.RecipientType.CC,InternetAddress.parse("suarez@invoicepayment.ca"));
			//mimeMessage.setRecipients(Message.RecipientType.CC,
			//		InternetAddress.parse("ali@invoicepayment.ca"));
			mimeMessage.setContent(mimeMultipart);
			Transport.send(mimeMessage);
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
