package com.ips.servlet;

import java.awt.Color;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.sql.CallableStatement;

import java.sql.ResultSet;
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
import java.sql.Connection;
//import com.mysql.jdbc.PreparedStatement;
import java.sql.PreparedStatement;

/**
 * Servlet implementation class DeletedInvoicef
 */
public class DeletedInvoicef extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DeletedInvoicef() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		Connection connection = null;
		String invId = request.getParameter("hiddenId");
		try {
			connection = SqlServerDBService.getInstance().openConnection();
			Map<String,Client> clients = FactorDBService.getInstance().getClients();
			response.setContentType("application/pdf"); // Code 1
			// response.setHeader("Content-Disposition ,filename=\"" +
			// "text.pdf" + "\"");

			// response.setHeader("Content-Disposition", "attachment;filename="
			// + "test" + ".pdf");

			Document document = new Document();

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
			PdfWriter writer = PdfWriter.getInstance(document,
			// ByteArrayOutputStream os = new ByteArrayOutputStream();
					response.getOutputStream()); // Code 2
			document.open();

			ResultSet rs = null;
			java.sql.PreparedStatement ps = null;
			
			// FACTOR-DEBTOR
			ps = connection
					.prepareStatement("SELECT i.InvoiceAmount,i.SysId, pa.PayerId from PayersAccounts pa join invoicetransaction i on i.SysAcctId = pa.SysId where i.SysId="
							+ invId);
			rs = ps.executeQuery();
			double invAmount = 0;
			String name1 = "";
			String debtor = "";
			// String invId;
			Map<String,Debtor> debtors = FactorDBService.getInstance().getDebtors();			
			while (rs.next()) {
				String payerId = rs.getString("payerid");
				Debtor d = debtors.get(payerId);
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

			// PdfContentByte canvas = writer.getDirectContent();
			document.add(new Paragraph(""));
			com.lowagie.text.Image image = com.lowagie.text.Image
					.getInstance("http://live.invoicepayment.ca/images/logoIPS.gif");
			// http://localhost:8080/IPS2/
			image.setAbsolutePosition(595 - image.getScaledWidth(), 760);
			image.scaleToFit(73, 55);

			document.add(image);

			PdfContentByte cbe = writer.getDirectContent();
			cbe.setLineWidth(1f);

			int y_line1 = 850;
			int y_line2 = 800;
			int y_line3 = y_line2 - 50;

			cbe.beginText();
			cbe.setFontAndSize(bf_cambria, 14);

			String text = "Transaction supprim�e";
			// cb.showTextAligned(PdfContentByte.ALIGN_CENTER, text + " Center",
			// 250, y_line1, 0);
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);

			y_line2 = y_line2 - 20;
			cbe.setFontAndSize(bf_cambrial, 10);

			// text ="Payment Date: " + invoicedate;
			text = "Nous vous remercions d�avoir utilis� le service de ch�que �lectronique IPS.";
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);

			y_line2 = y_line2 - 20;
			// text ="Account number: " + accountnum;
			text = "Veuillez imprimer cette page pour vos dossiers.";
			cbe.setFontAndSize(bf_cambrial, 9);
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);

			cbe.setFontAndSize(bf_cambria, 10);
			text = "Payeur: ";
			y_line2 = y_line2 - 20;
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);
			cbe.setFontAndSize(bf_cambrial, 10);
			text = name1 + " /(" + debtor.trim() + ")";
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 100, y_line2,
					0);

			cbe.setFontAndSize(bf_cambria, 10);
			text = "Montant supprim� : ";
			y_line2 = y_line2 - 20;
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);
			cbe.setFontAndSize(bf_cambrial, 10);
			text = amt;
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 150, y_line2,
					0);

			cbe.setFontAndSize(bf_cambria, 10);
			text = "Num�ro du paiement supprim� : ";
			y_line2 = y_line2 - 20;
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);
			cbe.setFontAndSize(bf_cambrial, 10);
			text = "        " + invId;
			cbe.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 190, y_line2,
					0);

			SimpleDateFormat sTimeStamp = new SimpleDateFormat(
					"dd MMMM yyyy 'at' hh:MM a z");
			// Calendar c = new Calendar().getInstance();
			String timeStamp = sTimeStamp.format(new Date());
			cbe.setFontAndSize(bf_cambria, 10);
			text = "Date et heure : ";
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

			text = "Paiements de facture supprim�s:";
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
			CallableStatement cs = connection.prepareCall("{call ipclient_m(?)}");
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
				
				// table.addCell(String.valueOf(id));
				// table.addCell("Amount");

				// c = new PdfPCell(new
				// Paragraph(rs.getString("SysId"),cambrial9));
				// c.setBorder(Rectangle.NO_BORDER);
				// table.addCell(c);

				// name="clientid" + counter;
				
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
			// ByteArrayOutputStream os = new ByteArrayOutputStream();
			// ServletOutputStream servletOutputStream =
			// response.getOutputStream();
			// servletOutputStream.write(bytes, 0, bytes.length);
			// servletOutputStream.flush();
			// servletOutputStream.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlServerDBService.getInstance().releaseConnection(connection);
		}

	}
}
