using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using System.Data;
using DevExpress.Data.Filtering.Helpers;
using DevExpress.Data.Filtering;
using DevExpress.Data.Browsing;

namespace devexpress.Reports
{
    public partial class Expenditure : DevExpress.XtraReports.UI.XtraReport {
        public Expenditure() {
            InitializeComponent();
            this.AfterPrint += Expenditure_AfterPrint;
        }
        void Expenditure_AfterPrint(object sender, EventArgs e) {
            //assign the calculated field result to the report parameter
            this.Parameters["TotalPriceExpen"].Value = GetCurrentColumnValue("TotalPriceExpenCalcField");
        }        
        private void ReportHeader_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e) {
            var product = GetCurrentColumnValue("ProductName");
            
            if (product == null)
            {
                e.Cancel = true;
            }
        }

        private void Detail_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e) {
            var product = GetCurrentColumnValue("ProductName");

            if (product == null)
            {
                e.Cancel = true;
            }
        }
        #region Sample

        //string labelTxt = ((DataRowView)GetCurrentRow()).Row["Price"].ToString();
        //DetailReport.GetCurrentRow().Row("ProductName").ToString()
        //double labelTxt = Convert.ToDouble(GetCurrentColumnValue("Price"));
        //if (labelTxt > 0)
        //{
        //    label.Visible = false;
        //}

        //string labelTxt = ((Detail)GetCurrentRow()).Row["ProductName"].ToString();
        //string labelTxt = Detail.GetCurrentColumnValue("ProductName").ToString();
        //string labelTxt = Detail.GetCurrentRow().Row("ProductName").ToString();
        //string labelTxt = Detail.GetCurrentColumnValue("ProductName").ToString();

        //DataRow[] rows = ((DataRowView)GetCurrentRow()).Row.GetChildRows("CategoriesProducts");

        //    if(rows.Length == 0)
        //        e.Cancel = true;

        #endregion
    }
}
