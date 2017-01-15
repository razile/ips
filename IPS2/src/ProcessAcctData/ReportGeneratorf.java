package ProcessAcctData;

import java.io.IOException;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

import java.sql.CallableStatement;
import java.io.*;
//import com.mysql.jdbc.Connection;

import java.sql.ResultSet;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.Map;

/**
 * Servlet implementation class ReportGenerator
 */
public class ReportGeneratorf extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ReportGeneratorf() {
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


	int norows = 0;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		Connection connection = null;
		String sql;
		PdfWriter writer;
		try {
			
			Map<String,Client> clients = DBClientDebtorService.getInstance().getClients();
		
			Class.forName(DBProperties.JDBC_SQLSERVER_DRIVER);
			connection = (Connection) DriverManager.getConnection(DBProperties.CONNECTION_SQLSERVER_URL, DBProperties.USERNAME_SQLSERVER, DBProperties.PASSWORD_SQLSERVER);

			String dateFrom = request.getParameter("datepickerstart");
			String dateEnd = request.getParameter("datepickerend");
			String acctId = request.getParameter("chkAccount");
			String payerid = request.getParameter("payerid");
			// String sql2 =
			// "Select * from PayersAccounts pa join Debtor d on pa.payerid = d.Sysid where d.SysId = "
			// + payerid;
			CallableStatement cs = connection.prepareCall("exec padebtor ?,? ");
			// PreparedStatement ps2 = connection.prepareStatement(sql2);
			cs.setString(1, payerid);
			cs.setString(2, acctId);
			ResultSet rs2 = cs.executeQuery();// ps2.executeQuery();
			String payer = "";
			String account = "";
			String currency = "";
			String debtor = "";
			if (rs2 != null && rs2.next()) {
				payer = rs2.getString("name1") + " " + rs2.getString("name2");
				account = rs2.getString("AccountNumber");
				currency = rs2.getString("CurrencyType");
				debtor = rs2.getString("DebtorId");
			}
			response.setContentType("application/pdf"); // Code 1
			Document document = new Document();
			// try{
			BaseFont bf_courier = BaseFont.createFont(BaseFont.COURIER,
					"Cp1252", false);
			BaseFont bf_helv = BaseFont.createFont(BaseFont.HELVETICA,
					"Cp1252", false);
			BaseFont bf_cambrial = BaseFont
					.createFont(
							"http://live.invoicepayment.ca/ipspayers/IPS2/font/Cambria.ttf",
							BaseFont.WINANSI, false);
			BaseFont bf_cambria = BaseFont
					.createFont(
							"http://live.invoicepayment.ca/ipspayers/IPS2/font/cambriab.ttf",
							BaseFont.WINANSI, false);
			// http://localhost:8080/IPS2/
			Font courier = new Font(bf_courier, 9);
			Font helv = new Font(bf_helv, 9);
			Font cambria9 = new Font(bf_cambria, 9);
			Font cambrial9 = new Font(bf_cambrial, 9);
			int y_line2 = 800;
			writer = PdfWriter
					.getInstance(document, response.getOutputStream()); // Code
																		// 2
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
			cb.setLineWidth(1f);
			// int y_line2 = 800;
			cb.beginText();
			cb.setFontAndSize(bf_cambria, 14);
			String text = "Rapport sur les paiements";
			// cb.showTextAligned(PdfContentByte.ALIGN_CENTER, text + " Center",
			// 250, y_line1, 0);
			cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);
			y_line2 = y_line2 - 20;
			cb.setFontAndSize(bf_cambrial, 10);
			// text ="Payment Date: " + invoicedate;
			text = "Nous vous remercions d�avoir utilis� le service de ch�que �lectronique IPS.";
			cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);
			text = "Veuillez imprimer cette page pour vos dossiers.";
			y_line2 = y_line2 - 20;
			cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);

			cb.setFontAndSize(bf_cambria, 10);
			text = "Payeur : ";
			y_line2 = y_line2 - 20;
			cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);

			cb.setFontAndSize(bf_cambrial, 10);
			text = payer + " /(" + debtor.trim() + ")";
			cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 100, y_line2, 0);

			cb.setFontAndSize(bf_cambria, 10);
			text = "Exp�diteur Bank Account: ";
			y_line2 = y_line2 - 20;
			cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);
			cb.setFontAndSize(bf_cambrial, 10);
			text = "       " + account + " " + currency;
			cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 170, y_line2, 0);

			cb.setFontAndSize(bf_cambria, 10);
			text = "Du : ";
			y_line2 = y_line2 - 20;
			cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);
			cb.setFontAndSize(bf_cambrial, 10);
			text = dateFrom;
			cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 120, y_line2, 0);

			cb.setFontAndSize(bf_cambria, 10);
			text = "Au : ";
			y_line2 = y_line2 - 20;
			cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60, y_line2, 0);
			cb.setFontAndSize(bf_cambrial, 10);
			text = dateEnd;
			cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 120, y_line2, 0);

			y_line2 = y_line2 - 20;
			cb.setLineWidth(2f);
			cb.moveTo(62, y_line2);
			cb.lineTo(500, y_line2);
			cb.stroke();

			cb.setFontAndSize(bf_cambria, 10);
			String sortby = request.getParameter("sortby");
			y_line2 = y_line2 - 30;

			if (sortby.equals("byDate")) {
				text = "Par date :";
				cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60,
						y_line2, 0);
				y_line2 = y_line2 - 2;
				cb.setLineWidth(1f);
				cb.moveTo(62, y_line2);
				cb.lineTo(100, y_line2);
				cb.stroke();
				
				
				// FACTOR-CLIENT
				sql = "SELECT it.InvoiceDate ,ip.InvId,ip.Amount,ip.PaymentAmount, ip.payee, it.SysId,ip.comments,it.status FROM invoicepayment ip join invoicetransaction it on it.SysId = ip.InvoiceTransactionId join PayersAccounts pa  on pa.sysid = it.SysAcctId  where pa.sysid="
						+ acctId;
				
				String declined = request.getParameter("declined");
				String status = "(";
				boolean useStatus = false;
				if ("ON".equals(declined)) {
					useStatus = true;
					status = status + "'Declined',";
				}
				String deleted = request.getParameter("deleted");
				if ("ON".equals(deleted)) {
					status = status + "'Deleted',";
					useStatus = true;
				}
				String submitted = request.getParameter("submtted");
				if ("ON".equals(submitted)) {
					status = status + "'Submitted',";
					useStatus = true;
				}
				if (useStatus) {
					status = status.substring(0, status.length() - 1);
					status = status + ")";
					sql = sql + " and it.status in " + status;
				}
				PdfPTable table = CreateTable("", y_line2, dateFrom, dateEnd,
						acctId, cambria9, cambrial9, sql, true, clients);
				table.writeSelectedRows(0, -1, 60, y_line2, cb);

			} else {
				text = "Par Fournisseur :";
				cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text, 60,
						y_line2, 0);
				y_line2 = y_line2 - 2;
				cb.setLineWidth(1f);
				cb.moveTo(62, y_line2);
				cb.lineTo(115, y_line2);
				cb.stroke();
				cb.endText();
		
				String dateEnd2 = null;
				if (dateEnd != null && dateEnd.length() > 0) {

					SimpleDateFormat dateFormat = new SimpleDateFormat(
							"yyyy-MM-dd");
					Calendar cd = Calendar.getInstance();
					cd.setTime(dateFormat.parse(dateEnd));
					cd.add(Calendar.DATE, 1);
					Date dt = cd.getTime();
					dateEnd2 = dateFormat.format(dt);
					// sql = sql +" and it.InvoiceDate < '"+ dateEnd2 +"' ";
				}

				CallableStatement cs3 = connection
						.prepareCall("exec ippaclient ?,?,?");
				cs3.setString(1, payerid);
				cs3.setString(2, dateFrom);
				cs3.setString(3, dateEnd2);
				ResultSet rs3 = cs3.executeQuery();
				while (rs3.next()) {
					if ((rs3.getString("name1") == null)
							&& (rs3.getString("name2") == null))
						text = rs3.getString("payee");
					else
						text = rs3.getString("name1") + " "
								+ rs3.getString("name2");
					y_line2 = y_line2 - 20;
					sql = "SELECT it.InvoiceDate ,ip.InvId,ip.Amount,ip.PaymentAmount,it.SysId,ip.comments,it.status FROM invoicepayment ip join invoicetransaction it on it.SysId = ip.InvoiceTransactionId join PayersAccounts pa  on pa.sysid = it.SysAcctId where pa.sysid="
							+ acctId
							+ " and ip.sysid = "
							+ rs3.getString("sysid");
					PdfPTable table = CreateTable(text, y_line2, dateFrom,
							dateEnd, acctId, cambria9, cambrial9, sql, false, clients);
					table.writeSelectedRows(0, -1, 60, y_line2, cb);
					y_line2 = y_line2 - 10 - norows * 27;
				}
			}

			document.close();

		} catch (SQLException e) { // response.setContentType("text/html");
									// PrintWriter pw = response.getWriter();
									// pw.println(e);
			e.printStackTrace();
		} catch (ClassNotFoundException e1) {
			// response.setContentType("text/html");
			// PrintWriter pw = response.getWriter();
			// pw.println(e1);
			e1.printStackTrace();
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
			e.printStackTrace();
		} finally {
			try {
				if (connection != null)
					connection.close();
			} catch (Exception e) {
			}
		}
	}

	PdfPTable CreateTable(String name, int y_line2, String dateFrom,
			String dateEnd, String acctId, Font cambria9, Font cambrial9,
			String sql, boolean showDebtor, Map<String,Client> clients) {
		Connection connection = null;
		norows = 0;
		PdfPTable table = null;
		try {
			Class.forName(DBProperties.JDBC_SQLSERVER_DRIVER);
			connection = (Connection) DriverManager.getConnection(DBProperties.CONNECTION_SQLSERVER_URL, DBProperties.USERNAME_SQLSERVER, DBProperties.PASSWORD_SQLSERVER);
				

			int columns = 0;
			if (showDebtor) {
				columns = 7;
			} else {
				columns = 6;
			}
			table = new PdfPTable(columns);
			if (showDebtor) {
				table.setWidths(new float[] { 71f, 71f, 71f, 50f, 50f, 71f, 71f });
			}

			y_line2 = y_line2 - 20;
			table.setTotalWidth(500);
			table.setSpacingBefore(y_line2);
			if (!showDebtor) {
				Paragraph p = new Paragraph(name, cambria9);
				// p2.setFont(FontFactory.getFont(FontFactory.HELVETICA, 5));
				PdfPCell c = new PdfPCell(p);
				c.setBorder(Rectangle.NO_BORDER);
				c.setColspan(columns);
				table.addCell(c);

			}

			// Phrase p;

			Paragraph p = new Paragraph("Date", cambria9);
			// p2.setFont(FontFactory.getFont(FontFactory.HELVETICA, 5));
			PdfPCell c = new PdfPCell(p);
			c.setBorder(Rectangle.NO_BORDER);
			c.setHorizontalAlignment(Element.ALIGN_CENTER);

			table.addCell(c);

			p = new Paragraph("N� de facture", cambria9);
			p.setFont(cambria9);
			c = new PdfPCell(p);
			c.setBorder(Rectangle.NO_BORDER);
			c.setHorizontalAlignment(Element.ALIGN_CENTER);

			table.addCell(c);
			if (showDebtor) {
				p = new Paragraph("Fournisseur", cambria9);
				p.setFont(cambria9);

				c = new PdfPCell(p);
				c.setBorder(Rectangle.NO_BORDER);
				c.setHorizontalAlignment(Element.ALIGN_CENTER);

				table.addCell(c);
			}
			p = new Paragraph("Montant", cambria9);
			p.setFont(cambria9);
			c = new PdfPCell(p);
			c.setBorder(Rectangle.NO_BORDER);
			c.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c);
			/*
			 * p = new Paragraph("Discount/ credit",cambria9);
			 * p.setFont(cambria9); c = new PdfPCell (p);
			 * c.setBorder(Rectangle.NO_BORDER); table.addCell(c);
			 */
			p = new Paragraph("Montant du paiement", cambria9);
			p.setFont(cambria9);
			c = new PdfPCell(p);
			c.setBorder(Rectangle.NO_BORDER);
			c.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c);
			p = new Paragraph("N� de confirmation", cambria9);
			p.setFont(cambria9);
			c = new PdfPCell(p);
			c.setBorder(Rectangle.NO_BORDER);
			// c.
			table.addCell(c);
			p = new Paragraph("�tat", cambria9);
			p.setFont(cambria9);
			c = new PdfPCell(p);
			c.setBorder(Rectangle.NO_BORDER);
			table.addCell(c);
			// String acctId = request.getParameter("chkAccount");
			if (dateFrom != null && dateFrom.length() > 0)
				sql = sql + " and it.InvoiceDate >= '" + dateFrom + "' ";

			if (dateEnd != null && dateEnd.length() > 0) {

				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
				Calendar cd = Calendar.getInstance();
				cd.setTime(dateFormat.parse(dateEnd));
				cd.add(Calendar.DATE, 1);
				Date dt = cd.getTime();
				String dateEnd2 = dateFormat.format(dt);
				sql = sql + " and it.InvoiceDate < '" + dateEnd2 + "' ";
			}
			sql = sql + " order by it.InvoiceDate";

			PreparedStatement ps = connection.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			// loop=0;
			// counter=0;
			while (rs.next()) {
				Date date2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
						.parse(rs.getString("InvoiceDate"));

				SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
						"yyyy/MM/dd HH:mm");
				String datep = simpleDateFormat.format(date2);

				p = new Paragraph(datep, cambrial9);
				p.setFont(cambria9);
				c = new PdfPCell(p);
				c.setBorder(Rectangle.NO_BORDER);
				c.setHorizontalAlignment(Element.ALIGN_CENTER);

				table.addCell(c);

				p = new Paragraph(rs.getString("InvId"), cambrial9);
				p.setFont(cambria9);
				c = new PdfPCell(p);
				c.setBorder(Rectangle.NO_BORDER);
				c.setHorizontalAlignment(Element.ALIGN_CENTER);

				table.addCell(c);
				if (showDebtor) {
					String payee = rs.getString("payee");
	            	Client client = clients.get(payee);
	            	
	            	String nameToUse = client.getName1();
	            	if (nameToUse == null || nameToUse.length() == 0) {
	            		nameToUse = payee;
	            	}
	            	
					p = new Paragraph(nameToUse, cambrial9);
					p.setFont(cambria9);
					c = new PdfPCell(p);
					c.setBorder(Rectangle.NO_BORDER);
					c.setHorizontalAlignment(Element.ALIGN_CENTER);

					table.addCell(c);
				}
				NumberFormat fmt = NumberFormat.getCurrencyInstance(Locale.US);
				Double d = Double.parseDouble(rs.getString("Amount"));
				String cur = fmt.format(d);

				p = new Paragraph(cur, cambrial9);
				p.setFont(cambria9);
				c = new PdfPCell(p);
				c.setBorder(Rectangle.NO_BORDER);
				c.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(c);
				/*
				 * Double debt = Double.parseDouble(rs.getString("Amount"))-
				 * Double.parseDouble(rs.getString("PaymentAmount")); p = new
				 * Paragraph(debt.toString(),cambrial9); p.setFont(cambria9); c
				 * = new PdfPCell (p); c.setBorder(Rectangle.NO_BORDER);
				 * table.addCell(c);
				 */d = Double.parseDouble(rs.getString("PaymentAmount"));
				cur = fmt.format(d);
				p = new Paragraph(cur, cambrial9);
				p.setFont(cambria9);
				c = new PdfPCell(p);
				c.setBorder(Rectangle.NO_BORDER);
				c.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(c);
				p = new Paragraph(rs.getString("SysId"), cambrial9);
				p.setFont(cambria9);
				c = new PdfPCell(p);
				c.setBorder(Rectangle.NO_BORDER);
				c.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(c);
				p = new Paragraph(rs.getString("status"), cambrial9);
				p.setFont(cambria9);
				c = new PdfPCell(p);
				c.setBorder(Rectangle.NO_BORDER);
				c.setHorizontalAlignment(Element.ALIGN_LEFT);
				table.addCell(c);

				if (rs.getString("Comments").length() > 0) {
					p = new Paragraph(rs.getString("Comments"), cambrial9);
					p.setFont(cambria9);
					c = new PdfPCell(p);
					c.setColspan(columns);
					c.setBorder(Rectangle.NO_BORDER);
					c.setPaddingLeft(50);
					table.addCell(c);
					norows = norows + 1;
				}
				norows += 1;
			}
			norows += 1;
			table.completeRow();

		} catch (Exception e) {
		} finally {
			try {
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return table;

	}

}
