using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using System.Data.SqlClient;
using System.Data;

namespace devexpress.Reports
{
    public partial class Order : DevExpress.XtraReports.UI.XtraReport
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
               
        public Order()
        {
            InitializeComponent();                      
        }

        int counter = 1;
        int prevId = 1;

        private void xrLabel37_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            (sender as XRControl).Text = System.Convert.ToString(counter);

            if (Convert.ToInt32(GetCurrentColumnValue("ShipperID")) > 0)
            {
                int id = (int)this.GetCurrentColumnValue("ShipperID");

                if (id != prevId)
                {
                    prevId = id;
                    counter++;
                }
            }
        }

        private void xrLabel36_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            GroupField groupField = new GroupField("ShipperID");
            GroupHeader1.GroupFields.Add(groupField);
        }

        private void xrLabel16_PrintOnPage(object sender, PrintOnPageEventArgs e)
        {
            e.Cancel = e.PageIndex != 0;          
        }          

        private void xrPageBreak1_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            if ((lblCountryName.Text != "United States") && (lblCountryName.Text != "Brazil"))
            {
                xrPageBreak1.Visible = false;                
            }
        }        

        private void xrSubreport1_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            if ((lblCountryName.Text != "United States") && (lblCountryName.Text != "Brazil"))
            {
                xrSubreport1.Visible = false;
            }

            if (lblCountryName.Text == "United States")
            {
                xrSubreport1.ReportSource = new Reports.TermUS();
            }

            if (lblCountryName.Text == "Brazil")
            {
                xrSubreport1.ReportSource = new Reports.TermBR();
            }
        }

        //Discount Unit
        private void xrLabel18_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            //if (xrLabel26.Text == "0,00")
            //{
            //    e.Cancel = true;
            //}
        }
        private void xrLabel26_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            //if (xrLabel26.Text == "0,00")
            //{
            //    e.Cancel = true;
            //}
        }

        //Total Unit
        private void xrLabel54_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            //e.Cancel = Detail.Report.RowCount == 1 ? true : false;

            //if (xrLabel39.Text == "1")
            //{
            //    e.Cancel = true;
            //}
        }
        private void xrLabel53_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            //FormattingRule rule = new FormattingRule();
            //this.FormattingRuleSheet.Add(rule);

            //// Specify the rule's properties.
            //rule.DataSource = this.DataSource;
            //rule.DataMember = this.DataMember;
            //rule.Condition = "[][[ShipperID] == [Parameters.ShipperID]].Count() == 1";
            //rule.Formatting.Visible = DevExpress.Utils.DefaultBoolean.False;            

            //// Apply this rule to the detail band.
            //this.xrLabel53.FormattingRules.Add(rule);

            //e.Cancel = Detail.Report.RowCount == 1 ? true : false;

            //if (xrLabel39.Text == "1")
            //{
            //    e.Cancel = true;
            //}
        }

        //Total Item
        private void xrLabel27_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            //e.Cancel = Detail.Report.RowCount == 1 ? true : false;

            //if (xrLabel39.Text == "1")
            //{
            //    e.Cancel = true;
            //}
        }
        private void xrLabel38_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            //e.Cancel = Detail.Report.RowCount == 1 ? true : false;

            //if (xrLabel39.Text == "1")
            //{
            //    e.Cancel = true;
            //}
        }

        private void Detail_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            //if (Detail.Report.RowCount == 1)
            //{
            //    xrLabel38.Visible = false;
            //    xrLabel27.Visible = false;
            //    xrLabel53.Visible = false;
            //    xrLabel54.Visible = false;
            //}
        }

        private void Order_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            //FormattingRule rule = new FormattingRule();
            //this.FormattingRuleSheet.Add(rule);

            //// Specify the rule's properties.
            //rule.DataSource = this.DataSource;
            //rule.DataMember = this.DataMember;
            //rule.Condition = "[UnitPrice] >= 30";
            //rule.Formatting.BackColor = Color.WhiteSmoke;
            //rule.Formatting.ForeColor = Color.IndianRed;
            //rule.Formatting.Font = new Font("Arial", 10, FontStyle.Bold);

            //// Apply this rule to the detail band.
            //this.Detail.FormattingRules.Add(rule);
        }

        private void GroupHeader1_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            //currentCategory.Value = GetCurrentColumnValue("Category");
        }

        //double totalUnits = 0;
        //private void xrLabel26_SummaryRowChanged(object sender, EventArgs e)
        //{
        //    totalUnits += Convert.ToDouble(GetCurrentColumnValue("Discount"));
        //}

        //private void xrLabel26_SummaryGetResult(object sender, SummaryGetResultEventArgs e)
        //{
        //    e.Result = Math.Ceiling(totalUnits);
        //    e.Handled = true;
        //}  
    }
}
