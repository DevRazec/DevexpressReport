using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace devexpress
{
    public partial class Site : System.Web.UI.MasterPage
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                FillMenu();
            }
        }       

        protected void FillMenu()
        {
            SqlCommand comm = new SqlCommand();

            comm.Connection = con;

            comm.CommandText = "select pg.PageID, pg.Url, pg.Name, pg.Icon from Pages pg " +
                               "join Rules ru on pg.PageID = ru.PageID " +                              
                               "where ru.RuleName = 'Menu'";
                        
            con.Open();
            SqlDataReader reader = comm.ExecuteReader();
            Repeater1.DataSource = reader;
            Repeater1.DataBind();
        }
    }
}