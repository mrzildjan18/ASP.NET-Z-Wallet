﻿using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace Z_Wallet
{
    public partial class Dashboard : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Z-WalletConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if the user is logged in
            if (Session["AccountNumber"] == null)
            {
                Response.Redirect("Default.aspx"); // Redirect to the login page
            }
            else
            {
                if (!IsPostBack)
                {
                    // Retrieve and display the user's account information
                    int AccountNumber = (int)Session["AccountNumber"];
                    DataTable accountData = GetUserAccountData(AccountNumber);

                    if (accountData.Rows.Count > 0)
                    {
                        DataRow row = accountData.Rows[0];
                        lblAccountNumber.Text = row["AccountNumber"].ToString();
                        lblName.Text = string.Format("{0} {1}", row["FirstName"].ToString(), row["LastName"].ToString());
                        lblDateRegistered.Text = ((DateTime)row["SignUpDateTime"]).ToString("MMM dd, yyyy");
                        lblCurrentBalance.Text = string.Format("₱ {0:N2}", Convert.ToDecimal(row["CurrentBalance"]));
                        lblTotalSendMoney.Text = string.Format("₱ {0:N2}", Convert.ToDecimal(row["TotalSendMoney"]));
                        lblTotalReceiveMoney.Text = string.Format("₱ {0:N2}", Convert.ToDecimal(row["TotalReceiveMoney"]));
                        lblTotalCashIn.Text = string.Format("₱ {0:N2}", Convert.ToDecimal(row["TotalCashIn"]));
                        lblTotalCashout.Text = string.Format("₱ {0:N2}", Convert.ToDecimal(row["TotalCashOut"]));
                    }
                }
            }
        }

        private DataTable GetUserAccountData(int AccountNumber)
        {

            DataTable accountData = new DataTable();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Users WHERE AccountNumber = @AccountNumber";

                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@AccountNumber", AccountNumber);

                SqlDataAdapter adapter = new SqlDataAdapter(command);
                adapter.Fill(accountData);
            }

            return accountData;
        }
    }
}
