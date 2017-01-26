package com.ips.servlet;

import java.io.IOException;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Date;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ips.database.DBProperties;
import com.ips.database.FactorDBService;
import com.ips.database.SqlServerDBService;
import com.ips.model.Client;
import com.ips.model.Debtor;
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

import java.sql.ResultSet;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Locale;
import java.util.Map;

/**
 * Servlet implementation class ReportGenerator
 */
public class AdminReport extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminReport() {
        super();
        // TODO Auto-generated constructor stub
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
	

	int norows=0;
	Document document = null;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection connection=null;
		 String  sql;
		try{
			
				Map<String,Client> clients = FactorDBService.getInstance().getClients();
				Map<String, Debtor> debtors = FactorDBService.getInstance().getDebtors();

				
				connection = SqlServerDBService.getInstance().openConnection();
				
				String dateFrom = request.getParameter("datepickerstart");
	            String dateEnd = request.getParameter("datepickerend");
				String payer="";
				String account ="";
				String currency = "";
				String debtor ="";
				response.setContentType("application/pdf"); // Code 1
				document = new Document();
				BaseFont bf_courier = BaseFont.createFont(BaseFont.COURIER, "Cp1252", false);
				BaseFont bf_helv = BaseFont.createFont(BaseFont.HELVETICA, "Cp1252", false);
				BaseFont bf_cambrial = BaseFont.createFont("http://live.invoicepayment.ca/ipspayers/IPS2/font/Cambria.ttf", BaseFont.WINANSI, false);
				BaseFont bf_cambria = BaseFont.createFont("http://live.invoicepayment.ca/ipspayers/IPS2/font/cambriab.ttf", BaseFont.WINANSI,false);
				Font courier = new Font(bf_courier,9);
				Font helv = new Font(bf_helv, 9);
				Font cambria9 = new Font(bf_cambria,9);
				Font cambrial9 = new Font(bf_cambrial,9);
				int y_line2=800;
				PdfWriter writer =	PdfWriter.getInstance(document,
				response.getOutputStream()); // Code 2
				document.open();
				document.add(new Paragraph(""));
				com.lowagie.text.Image image =
				com.lowagie.text.Image.getInstance("http://live.invoicepayment.ca/images/logoIPS.gif");
				image.setAbsolutePosition(595 - image.getScaledWidth(),760);
				image.scaleToFit(73, 55);
				document.add(image);
				PdfContentByte cb = writer.getDirectContent();
				cb.setLineWidth(1f);
				cb.beginText();
				cb.setFontAndSize(bf_cambria, 14);
				String text = "Payments Report";
				cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text , 60, y_line2, 0);
				text = "Please print this page for your records.";
				y_line2 = y_line2 - 20;
				cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text , 60, y_line2, 0);
				cb.setFontAndSize(bf_cambria, 10);
				text = "Start Date: ";
				y_line2 = y_line2 - 20;
				cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text , 60, y_line2, 0);
				cb.setFontAndSize(bf_cambrial, 10);
				text = dateFrom;
				cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text , 120, y_line2, 0);
				cb.setFontAndSize(bf_cambria, 10);
				text = "End Date: ";
				y_line2 = y_line2 - 20;
				cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text , 60, y_line2, 0);
				cb.setFontAndSize(bf_cambrial, 10);
				text = dateEnd;
				cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text , 120, y_line2, 0);
				y_line2 = y_line2 - 20;
				cb.setLineWidth(2f);
				cb.moveTo(62, y_line2);
				cb.lineTo(500, y_line2);
				cb.stroke();
				cb.setFontAndSize(bf_cambria, 10);
				String sortby = request.getParameter("sortby");
				y_line2 = y_line2 - 30;
				if (sortby.equals("byDate")){
						text = "By Date: ";
						cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text , 60, y_line2, 0);
						y_line2 = y_line2 - 2;
						cb.setLineWidth(1f);
						cb.moveTo(62, y_line2);
						cb.lineTo(100, y_line2);
						cb.stroke();
						
						// case when Client.name1 is null then payee COLLATE DATABASE_DEFAULT else Client.Name1 COLLATE DATABASE_DEFAULT end as name1
						// d.name1 + ' ' + d.name2 +' (' + d.DebtorId + ')' as DebtorName
						// Left join Factor.dbo.Client  on Client.sysid = ip.payee left join Factor.dbo.Debtor d on pa.payerid = d.Sysid
						
						// FACTOR-CLIENT-DEBTOR
						sql= "SELECT it.InvoiceDate ,ip.InvId, ip.payee,"
								+ "ip.Amount,ip.PaymentAmount,it.SysId,ip.comments,it.status " 
								+ "FROM invoicepayment ip join invoicetransaction it on it.SysId = ip.InvoiceTransactionId join PayersAccounts pa on pa.sysid = it.SysAcctId "
								+ "where isnumeric(ip.payee)=1" ;			 
						
						// RR - deleted comment 
						
						String declined = request.getParameter("declined");
						String status = "(";
						boolean useStatus = false;
						if("ON".equals(declined)){
							useStatus = true;
							status = status + "'Declined',";
						}
						String deleted = request.getParameter("deleted");
						if("ON".equals(deleted)){
							status = status +"'Deleted',";
							useStatus = true;
						}
						String approved = request.getParameter("approved");
						if("ON".equals(approved)){
							status = status +"'Approved',";
							useStatus = true;
						}
						String submitted = request.getParameter("submtted");
						if("ON".equals(submitted)){
							status = status + "'Submitted',";
							useStatus = true;
						}
						if (useStatus){
							status = status.substring(0,status.length() -1);
							status = status + ")";
							sql = sql + " and it.status in "+ status;
						}
						PdfPTable table = CreateTable("", y_line2,dateFrom,dateEnd,cambria9,cambrial9,sql,true,true, clients, debtors);
						if (norows>12){
							table.writeSelectedRows(0, 12, 60,  y_line2 , cb);
							document.newPage();
							int r = norows % 12;
							int morePages = (norows - r)/12;
							int pagesDone =1;
							while (pagesDone<morePages+1){
									table.writeSelectedRows(12*pagesDone, 12*pagesDone+12, 60,  y_line2 , cb);
									document.newPage();
									pagesDone = pagesDone+1;
							}
						}else{
							table.writeSelectedRows(0, -1, 20,  y_line2 , cb);
						}
				}
				else{
					text = "By Supplier:";
					cb.showTextAligned(PdfContentByte.ALIGN_LEFT, text , 60, y_line2, 0);
					y_line2 = y_line2 - 2;
					cb.setLineWidth(1f);
					cb.moveTo(62, y_line2);
					cb.lineTo(115, y_line2);
					cb.stroke();
					cb.endText();
                    java.sql.Date dateSqlEnd2=null;
					java.sql.Date dateSqlFrom2=null;
					if (dateEnd !=null && dateEnd.length()>0){
						java.util.Date dateEnd2;
						java.util.Date dateFrom2;
						SimpleDateFormat dateFormat = new SimpleDateFormat( "yyyy-MM-dd" );
						dateFrom2 = dateFormat.parse(dateFrom);
						dateEnd2 = dateFormat.parse(dateEnd);
						dateSqlFrom2 = new Date(dateFrom2.getTime());
						dateSqlEnd2 = new Date(dateEnd2.getTime());
						Calendar cd = Calendar.getInstance();
						cd.setTime(dateFormat.parse(dateEnd));
					}
					
					// FACTOR-CLIENT
					
					sql= "select distinct payee from invoicepayment ip join invoicetransaction it on it.SysId = ip.InvoiceTransactionId "
							+ "join PayersAccounts pa on pa.SysId = it.SysAcctId  where isnumeric(ip.payee)=1 "
							+ "and it.InvoiceDate between ? and ? "; 
					PreparedStatement ps = connection.prepareStatement(sql);
					ps.setDate(1, dateSqlFrom2);
					ps.setDate(2, dateSqlEnd2);
					ResultSet  rs3 = ps.executeQuery();
					while (rs3.next()){
						String payee = rs3.getString("payee");
						Client client = clients.get(payee);
						text = client.getName1() + " " + client.getName2();
						y_line2 = y_line2 -20;
						
						// FACTOR-DEBTOR
						
						// d.name1 + ' ' + d.name2 +' (' + d.DebtorId + ')' as DebtorName
						sql= "SELECT it.InvoiceDate ,ip.InvId,ip.Amount,ip.PaymentAmount,it.SysId,ip.comments,it.status, pa.payerid "
								+ "FROM invoicepayment ip join invoicetransaction it on it.SysId = ip.InvoiceTransactionId join PayersAccounts pa on pa.sysid = it.SysAcctId "
								//+ "join Factor.dbo.Debtor d on pa.payerid = d.Sysid "
								+ "where  isnumeric(ip.payee)=1 and ip.payee = " + payee ;
						String declined = request.getParameter("declined");
						String status = "(";
						boolean useStatus = false;
						if("ON".equals(declined)){
							useStatus = true;
							status = status + "'Declined',";
						}
						String deleted = request.getParameter("deleted");
						if("ON".equals(deleted)){
							status = status +"'Deleted',";
							useStatus = true;
						}
						String approved = request.getParameter("approved");
						if("ON".equals(approved)){
							status = status +"'Approved',";
							useStatus = true;
						}
						String submitted = request.getParameter("submtted");
						if("ON".equals(submitted)){
							status = status + "'Submitted',";
							useStatus = true;
						}
						if (useStatus){
							status = status.substring(0,status.length() -1);
							status = status + ")";
							sql = sql + " and it.status in "+ status;
						}
						PdfPTable table = CreateTable(text,y_line2,dateFrom,dateEnd,cambria9,cambrial9,sql,false,false, clients, debtors);
						if (norows>12){
							table.writeSelectedRows(0, 12, 60,  y_line2 , cb);
							document.newPage();
							int r = norows % 12;
							int morePages = (norows - r)/12;
							int pagesDone =1;
							while (pagesDone<morePages+1){
								table.writeSelectedRows(12*pagesDone, 12*pagesDone+12, 60,  y_line2 , cb);
								document.newPage();
								pagesDone = pagesDone+1;
							}
						}else{
							table.writeSelectedRows(0, -1, 20,  y_line2 , cb);
						}
						y_line2 = y_line2 -10 - norows*27;
					}
				}
				document.close();

		}
	    catch(SQLException e){ 
			e.printStackTrace();
		}
	    catch(ClassNotFoundException e1){
	    	e1.printStackTrace();
	    }
	    catch(Exception e){
				e.printStackTrace();
		}
    	finally{
    		 SqlServerDBService.getInstance().releaseConnection(connection);

    	}
	}

	PdfPTable CreateTable(String name,int y_line2,String dateFrom,String dateEnd, Font cambria9,Font cambrial9,String sql,boolean showDebtor,boolean orderByDate, Map<String,Client> clients, Map<String,Debtor> debtors)
	{
		Connection connection=null;
		norows=0;
		PdfPTable table=null;
		try{
			connection = SqlServerDBService.getInstance().openConnection();
			int columns =0;
			if (showDebtor){
				columns=8;
			}else{
				columns=7;
			}
			table = new PdfPTable(columns);
			y_line2 = y_line2 - 20;
			table.setTotalWidth(500);
			table.setSpacingBefore(y_line2);
			if (!showDebtor){
				Paragraph p = new  Paragraph(name,cambria9);
		     	PdfPCell  c = new PdfPCell (p);
				c.setBorder(Rectangle.NO_BORDER);
				c.setColspan(columns);
				table.addCell(c);
				}
			Paragraph p = new  Paragraph("Date",cambria9);
			PdfPCell  c = new PdfPCell (p);
			c.setBorder(Rectangle.NO_BORDER);
			c.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c);
			p = new  Paragraph("Invoice No.",cambria9);
			p.setFont(cambria9);
			c = new PdfPCell (p);
			c.setBorder(Rectangle.NO_BORDER);
			c.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c);
			if (showDebtor){
				p = new  Paragraph("Supplier",cambria9);
				p.setFont(cambria9);
				c = new PdfPCell (p);
				c.setBorder(Rectangle.NO_BORDER);
				c.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(c);
			}
			p = new  Paragraph("Debtor",cambria9);
			p.setFont(cambria9);
			c = new PdfPCell (p);
			c.setBorder(Rectangle.NO_BORDER);
			c.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c);
			p = new  Paragraph("Amount",cambria9);
			p.setFont(cambria9);
			c = new PdfPCell (p);
			c.setBorder(Rectangle.NO_BORDER);
			c.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c);
			p = new  Paragraph("Payment Amount",cambria9);
			p.setFont(cambria9);
			c = new PdfPCell (p);
			c.setBorder(Rectangle.NO_BORDER);
			c.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c);
			p = new  Paragraph("Confirmation No.",cambria9);
			p.setFont(cambria9);
			c = new PdfPCell (p);
			c.setBorder(Rectangle.NO_BORDER);
			table.addCell(c);
			p = new Paragraph("Status",cambria9);
			p.setFont(cambria9);
			c= new PdfPCell(p);
			c.setBorder(Rectangle.NO_BORDER);
			table.addCell(c);
			if (dateFrom !=null && dateFrom.length()>0)
				sql = sql +" and it.InvoiceDate >= '"+ dateFrom +"' ";
			if (dateEnd !=null && dateEnd.length()>0){
				SimpleDateFormat dateFormat = new SimpleDateFormat( "yyyy-MM-dd" );
				Calendar cd = Calendar.getInstance();
				cd.setTime(dateFormat.parse(dateEnd));
				cd.add(Calendar.DATE, 1);
				java.util.Date dt = cd.getTime();
				String dateEnd2 = dateFormat.format(dt);
				sql = sql +" and it.InvoiceDate < '"+ dateEnd2 +"' ";
			}
			
			sql = sql + " order by it.InvoiceDate";
			//if(orderByDate){
			//	sql = sql + " order by it.InvoiceDate";
			//}
			//else{
			//	sql = sql + " order by d.name1,d.name2";
			// 
			//}
			PreparedStatement  ps = connection.prepareStatement(sql);
			ResultSet  rs = ps.executeQuery();
			while (rs.next()){
				java.util.Date date2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("InvoiceDate"));
				SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm");
				String datep = simpleDateFormat.format(date2);
				p = new  Paragraph(datep,cambrial9);
	            p.setFont(cambria9);
	            c = new PdfPCell (p);
	            c.setBorder(Rectangle.NO_BORDER);
	            c.setHorizontalAlignment(Element.ALIGN_CENTER);
	            table.addCell(c);
	            p = new  Paragraph(rs.getString("InvId"),cambrial9);
	            p.setFont(cambria9);
	            c = new PdfPCell (p);
	            c.setBorder(Rectangle.NO_BORDER);
	            c.setHorizontalAlignment(Element.ALIGN_CENTER);
	            table.addCell(c);
	            if (showDebtor){
	            	String payee = rs.getString("payee");
	            	Client client = clients.get(payee);
	            	
	            	String nameToUse = client.getName1();
	            	if (nameToUse == null || nameToUse.length() == 0) {
	            		nameToUse = payee;
	            	}
	            	p = new  Paragraph(nameToUse,cambrial9);
	            	p.setFont(cambria9);
	            	c = new PdfPCell (p);
	            	c.setBorder(Rectangle.NO_BORDER);
	            	c.setHorizontalAlignment(Element.ALIGN_CENTER);
	            	table.addCell(c);
	            }
	            
	            String payerid = rs.getString("payerid");
	            Debtor debtor = debtors.get(payerid);
	            String debtorname = debtor.getName1() + " " + debtor.getName2() + " (" + debtor.getDebtorId() + ")"; 
	         	p = new  Paragraph(debtorname,cambrial9);
	         	p.setFont(cambria9);
	         	c = new PdfPCell (p);
	         	c.setBorder(Rectangle.NO_BORDER);
	         	c.setHorizontalAlignment(Element.ALIGN_CENTER);
	         	table.addCell(c);
	         	NumberFormat fmt = NumberFormat.getCurrencyInstance(Locale.US);
	         	Double d = Double.parseDouble(rs.getString("Amount")) ;
	         	String cur = fmt.format(d);
             	p = new  Paragraph(cur,cambrial9);
             	p.setFont(cambria9);
             	c = new PdfPCell (p);
             	c.setBorder(Rectangle.NO_BORDER);
             	c.setHorizontalAlignment(Element.ALIGN_RIGHT);
             	table.addCell(c);
             	d = Double.parseDouble(rs.getString("PaymentAmount")) ;
		        cur = fmt.format(d);
	            p = new  Paragraph(cur,cambrial9);
	            p.setFont(cambria9);
			    c = new PdfPCell (p);
			    c.setBorder(Rectangle.NO_BORDER);
			    c.setHorizontalAlignment(Element.ALIGN_RIGHT);
			    table.addCell(c);
			    p = new  Paragraph(rs.getString("SysId"),cambrial9);
			    p.setFont(cambria9);
			    c = new PdfPCell (p);
			    c.setBorder(Rectangle.NO_BORDER);
			    c.setHorizontalAlignment(Element.ALIGN_CENTER);
			    table.addCell(c);
	            p = new Paragraph(rs.getString("status"),cambrial9);
	            p.setFont(cambria9);
	            c = new PdfPCell (p);
	            c.setBorder(Rectangle.NO_BORDER);
	            c.setHorizontalAlignment(Element.ALIGN_LEFT);
	            table.addCell(c);
	            if (rs.getString("Comments").length()>0){
	            	p = new  Paragraph(rs.getString("Comments"),cambrial9);
	            	p.setFont(cambria9);
	            	c = new PdfPCell (p);
	            	c.setColspan(columns);
	            	c.setBorder(Rectangle.NO_BORDER);
	            	c.setPaddingLeft(50);
	            	table.addCell(c);
	            	//norows = norows+1;
	            }
	            norows=norows+1;
	    	}

	   table.completeRow();

	}
	catch(Exception e){e.printStackTrace();}
	finally{
		 SqlServerDBService.getInstance().releaseConnection(connection);
	}
	return table;

	}

}
