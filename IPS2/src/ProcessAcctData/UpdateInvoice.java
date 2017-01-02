package ProcessAcctData;

import java.io.IOException;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;

/**
 * Servlet implementation class UpdateInvoice
 */
public class UpdateInvoice extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateInvoice() {
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
		// String connectionURL = "jdbc:mysql://localhost:3306/ipspayment";//
		// newData is the database
		String connectionURL = "jdbc:jtds:sqlserver://192.168.1.41/ipspayment";

		Connection connection = null;

		try {
			String act = request.getParameter("act");
			connection = (Connection) DriverManager.getConnection(
					connectionURL, "sa", "894xwhtm054ocwso");
			// connection = (Connection)
			// DriverManager.getConnection(connectionURL, "appdev", "8Ecrespe");
			// connection = (Connection)
			// DriverManager.getConnection(connectionURL, "root", "password");

			// Class.forName("com.mysql.jdbc.Driver");
			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			if (act.equals("update")) {
				int counter = Integer.parseInt(request.getParameter("counter"));
				int loop = 0;
				Double totalamount = 0.0;
				while (loop < counter) {
					String name = "invoiceid" + loop;
					String invid = request.getParameter(name);
					name = "paymentamount" + loop;
					String amount = request.getParameter(name);
					PreparedStatement pst = (PreparedStatement) connection
							.prepareStatement("update invoicepayment set paymentamount=? where SysId=?");// try2
																											// is
																											// the
																											// name
																											// of
																											// the
																											// table
					pst.setString(1, amount);
					pst.setString(2, invid);
					int i = pst.executeUpdate();
					totalamount += Double.parseDouble(amount);
					loop += 1;
				}
				PreparedStatement pst = (PreparedStatement) connection
						.prepareStatement("update invoicetransaction set invoiceamount=? where SysId=?");// try2
																											// is
																											// the
																											// name
																											// of
																											// the
																											// table
				pst.setDouble(1, totalamount);
				String id = request.getParameter("transactionid");
				pst.setString(2, id);
				int i = pst.executeUpdate();
			}
		} catch (Exception e) {
		} finally {
			try {
				connection.close();
			} catch (SQLException e) {
			}
		}
		javax.servlet.ServletContext context = getServletContext();

		String path = context.getInitParameter("IPS2Path").toString();

		request.getRequestDispatcher(path + "/ReviewPayment.jsp").forward(
				request, response);
	}

}
