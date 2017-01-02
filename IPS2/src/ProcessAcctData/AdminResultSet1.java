package ProcessAcctData;

public class AdminResultSet1 {
	String  invoiceDate;
	String invId;
	String  name1; //client
	String  name2; //client
	String  amount;
	String  paymentAmount;
	String sysId;
	String  comments; 
	String  status;
	String  debtorName;  //debtor
	
	public AdminResultSet1(String invoiceDate,String invId, String name1,String name2, String amount, String paymentAmount,
			String sysId, String comments,String status, String debtorName ){
		this.invoiceDate = invoiceDate;
		this.invId = invId;
		this.name1 = name1;
		this.name2 = name2;
		this.amount = amount;
		this.paymentAmount = paymentAmount;
		this.sysId = sysId;
		this.comments = comments;
		this.status = status;
		this.debtorName = debtorName;
	}
}
