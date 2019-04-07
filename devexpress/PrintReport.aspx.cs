using devexpress.Reports;
using DevExpress.XtraReports.UI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace devexpress
{
    public partial class PrintReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Params["Param1"].ToString() == "Order")
            {                
                Order reportOrder = new Order();
                reportOrder.Parameters["OrderID"].Value = Convert.ToInt32(Request.Params["Param2"].ToString());
                ASPxDocumentViewer1.Report = reportOrder;               
            }

            if (Request.Params["Param1"].ToString() == "Products")
            {               
                ASPxDocumentViewer1.ReportTypeName = "devexpress.Reports.ProductList";   
            }                      
        }
    }
}