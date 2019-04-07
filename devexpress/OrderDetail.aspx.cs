using DevExpress.Web;
using DevExpress.XtraGrid;
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
    public partial class OrderDetail : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DBOrderDetail.SelectParameters["OrderID"].DefaultValue = Request.Params["OrderID"];
            }
        }

        protected void GridOrderDetail_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            e.NewValues["OrderID"] = DBOrderDetail.SelectParameters["OrderID"].DefaultValue;

            object rowKey = GridOrderDetail.GetRowValues(GridOrderDetail.FocusedRowIndex, GridOrderDetail.KeyFieldName);

            if (Convert.ToInt32(rowKey) > 0)
            {
                SqlCommand comm = new SqlCommand();
                comm.Connection = con;

                comm.CommandText = "select OrderDetailID, OrderID, ShipperID, ProductID, Quantity, SortShipper from OrderDetails where OrderDetailID = @OrderDetailID ";

                comm.Parameters.AddWithValue("@OrderDetailID", rowKey);
                con.Open();
                SqlDataReader reader = comm.ExecuteReader();
                var varTable = new DataTable();
                varTable.Load(reader);
                con.Close();
                if (varTable.Rows.Count > 0)
                {
                    e.NewValues["Quantity"] = Convert.ToInt32(varTable.Rows[0]["Quantity"].ToString());
                    e.NewValues["SortShipper"] = Convert.ToInt32(varTable.Rows[0]["SortShipper"].ToString());
                }
                else
                {
                    e.NewValues["Quantity"] = 1;
                    e.NewValues["SortShipper"] = 1;
                }
            }
        }

        protected void GridOrderDetail_InitNewRow(object sender, DevExpress.Web.Data.ASPxDataInitNewRowEventArgs e)
        {          
            object rowKey = GridOrderDetail.GetRowValues(GridOrderDetail.FocusedRowIndex, GridOrderDetail.KeyFieldName);

            if (Convert.ToInt32(rowKey) > 0)
            {
                SqlCommand comm = new SqlCommand();
                comm.Connection = con;

                comm.CommandText = "select OrderDetailID, OrderID, ShipperID, ProductID, Quantity, SortShipper from OrderDetails where OrderDetailID = @OrderDetailID ";

                comm.Parameters.AddWithValue("@OrderDetailID", rowKey);
                con.Open();
                SqlDataReader reader = comm.ExecuteReader();
                var varTable = new DataTable();
                varTable.Load(reader);
                con.Close();
                if (varTable.Rows.Count > 0)
                {
                    e.NewValues["ShipperID"] = Convert.ToInt32(varTable.Rows[0]["ShipperID"].ToString());
                }
            }
        }

        protected void GridOrderDetail_CustomColumnSort(object sender, CustomColumnSortEventArgs e)
        {
            int s1 = Convert.ToInt32(e.GetRow1Value("SortShipper"));
            int s2 = Convert.ToInt32(e.GetRow2Value("SortShipper"));

            int v1 = Convert.ToInt32(e.GetRow1Value("ShipperID"));
            int v2 = Convert.ToInt32(e.GetRow2Value("ShipperID"));

            if (e.Column.FieldName == "ShipperID")
            {
                e.Result = s1.CompareTo(s2);
                if (e.Result == 0)
                {
                    e.Result = v1.CompareTo(v2);
                }
                e.Handled = true;
            }
        }

        protected void GridOrderDetail_CustomColumnGroup(object sender, CustomColumnSortEventArgs e)
        {
            int s1 = Convert.ToInt32(e.GetRow1Value("SortShipper"));
            int s2 = Convert.ToInt32(e.GetRow2Value("SortShipper"));

            int v1 = Convert.ToInt32(e.GetRow1Value("ShipperID"));
            int v2 = Convert.ToInt32(e.GetRow2Value("ShipperID"));

            if (e.Column.FieldName == "ShipperID")
            {
                if (v1 == v2)
                    e.Result = (s1 != s2) ? 1 : 0;
                else
                    e.Result = 1;

                e.Handled = true;
            }
        }

        protected void GridOrderDetail_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        {
            string[] parameter = e.Parameters.Split(':');

            switch (parameter[0])
            {
                case ("Save"):
                                     
                    int rowKey;
                    int intSortShipper = 0;
                    int intQuantity = 0;
                    int intShipper = 0;

                    for (int i = 0; i < GridOrderDetail.VisibleRowCount; i++)
                    {
                        rowKey = Convert.ToInt32(GridOrderDetail.GetRowValues(Convert.ToInt32(i), "OrderDetailID"));

                        if (GridOrderDetail.IsGroupRow(i))
                        {
                            ASPxSpinEdit spinSortShipper = (ASPxSpinEdit)GridOrderDetail.FindGroupRowTemplateControl(i, "spinSortShipper");
                            ((IPostBackDataHandler)spinSortShipper).LoadPostData("spinSortShipper", Request.Form);
                            intSortShipper = Convert.ToInt32(spinSortShipper.Value);

                            ASPxComboBox cboShipper = (ASPxComboBox)GridOrderDetail.FindGroupRowTemplateControl(i, "cboShipper");
                            ((IPostBackDataHandler)cboShipper).LoadPostData("cboShipper", Request.Form);
                            intShipper = Convert.ToInt32(cboShipper.Value);

                            ASPxSpinEdit spinQuantity = (ASPxSpinEdit)GridOrderDetail.FindGroupRowTemplateControl(i, "spinQuantity");
                            ((IPostBackDataHandler)spinQuantity).LoadPostData("spinQuantity", Request.Form);
                            intQuantity = Convert.ToInt32(spinQuantity.Value);
                        }
                        if (!GridOrderDetail.IsGroupRow(i))
                        {
                            ASPxComboBox cboProduct = (ASPxComboBox)GridOrderDetail.FindRowCellTemplateControl(i, (GridViewDataComboBoxColumn)GridOrderDetail.Columns["ProductID"], "cboProduct");
                            ((IPostBackDataHandler)cboProduct).LoadPostData("cboProduct", Request.Form);

                            ASPxSpinEdit spinSortProduct = (ASPxSpinEdit)GridOrderDetail.FindRowCellTemplateControl(i, (GridViewDataSpinEditColumn)GridOrderDetail.Columns["SortProduct"], "spinSortProduct");
                            ((IPostBackDataHandler)spinSortProduct).LoadPostData("spinSortProduct", Request.Form);

                            ASPxSpinEdit spinDefaultPrice = (ASPxSpinEdit)GridOrderDetail.FindRowCellTemplateControl(i, (GridViewDataSpinEditColumn)GridOrderDetail.Columns["DefaultPrice"], "spinDefaultPrice");
                            ((IPostBackDataHandler)spinDefaultPrice).LoadPostData("spinDefaultPrice", Request.Form);

                            ASPxSpinEdit spinUnitPrice = (ASPxSpinEdit)GridOrderDetail.FindRowCellTemplateControl(i, (GridViewDataSpinEditColumn)GridOrderDetail.Columns["UnitPrice"], "spinUnitPrice");
                            ((IPostBackDataHandler)spinUnitPrice).LoadPostData("spinUnitPrice", Request.Form);

                            ASPxSpinEdit spinDiscount = (ASPxSpinEdit)GridOrderDetail.FindRowCellTemplateControl(i, (GridViewDataSpinEditColumn)GridOrderDetail.Columns["Discount"], "spinDiscount");
                            ((IPostBackDataHandler)spinDiscount).LoadPostData("spinDiscount", Request.Form);

                            ASPxSpinEdit spinIncrease = (ASPxSpinEdit)GridOrderDetail.FindRowCellTemplateControl(i, (GridViewDataSpinEditColumn)GridOrderDetail.Columns["Increase"], "spinIncrease");
                            ((IPostBackDataHandler)spinIncrease).LoadPostData("spinIncrease", Request.Form);

                            ASPxSpinEdit spinRowTotal = (ASPxSpinEdit)GridOrderDetail.FindRowCellTemplateControl(i, (GridViewDataSpinEditColumn)GridOrderDetail.Columns["TotalPrice"], "spinRowTotal");
                            ((IPostBackDataHandler)spinRowTotal).LoadPostData("spinRowTotal", Request.Form);

                            ASPxSpinEdit spinRowTotalCustomer = (ASPxSpinEdit)GridOrderDetail.FindRowCellTemplateControl(i, (GridViewDataSpinEditColumn)GridOrderDetail.Columns["TotalCustomer"], "spinRowTotalCustomer");
                            ((IPostBackDataHandler)spinRowTotalCustomer).LoadPostData("spinRowTotalCustomer", Request.Form);

                            SqlCommand comm = new SqlCommand();
                            comm.Connection = con;

                            comm.CommandText = "update OrderDetails set SortProduct = @SortProduct, DefaultPrice = @DefaultPrice, UnitPrice = @UnitPrice,Discount = @Discount, Increase = @Increase, TotalPrice = @TotalPrice, TotalCustomer = @TotalCustomer, SortShipper = @SortShipper, Quantity = @Quantity, ShipperID = @ShipperID, ProductID = @ProductID " +
                                               "where OrderDetailID = @OrderDetailID";

                            comm.Parameters.AddWithValue("@OrderDetailID", rowKey);

                            comm.Parameters.AddWithValue("@ShipperID", Convert.ToInt32(intShipper));
                            comm.Parameters.AddWithValue("@SortShipper", Convert.ToInt32(intSortShipper));
                            comm.Parameters.AddWithValue("@Quantity", Convert.ToInt32(intQuantity));

                            comm.Parameters.AddWithValue("@ProductID", Convert.ToInt32(cboProduct.Value));
                            comm.Parameters.AddWithValue("@SortProduct", Convert.ToInt32(spinSortProduct.Value));
                            comm.Parameters.AddWithValue("@DefaultPrice", Convert.ToDouble(spinDefaultPrice.Value));
                            comm.Parameters.AddWithValue("@UnitPrice", Convert.ToDouble(spinUnitPrice.Value));
                            comm.Parameters.AddWithValue("@Discount", Convert.ToDouble(spinDiscount.Value));
                            comm.Parameters.AddWithValue("@Increase", Convert.ToDouble(spinIncrease.Value));
                            comm.Parameters.AddWithValue("@TotalPrice", Convert.ToDouble(spinRowTotal.Value));
                            comm.Parameters.AddWithValue("@TotalCustomer", Convert.ToDouble(spinRowTotalCustomer.Value));

                            con.Open();
                            comm.ExecuteNonQuery();
                            con.Close();
                        }
                    }

                    ASPxSpinEdit spinDiscountTotal = (ASPxSpinEdit)GridOrderDetail.FindFooterCellTemplateControl((GridViewDataSpinEditColumn)GridOrderDetail.Columns["Discount"], "spinDiscountTotal");
                    ((IPostBackDataHandler)spinDiscountTotal).LoadPostData("spinDiscountTotal", Request.Form);

                    ASPxSpinEdit spinIncreaseTotal = (ASPxSpinEdit)GridOrderDetail.FindFooterCellTemplateControl((GridViewDataSpinEditColumn)GridOrderDetail.Columns["Increase"], "spinIncreaseTotal");
                    ((IPostBackDataHandler)spinIncreaseTotal).LoadPostData("spinIncreaseTotal", Request.Form);                                      

                    ASPxSpinEdit spinGrandTotal = (ASPxSpinEdit)GridOrderDetail.FindFooterCellTemplateControl((GridViewDataSpinEditColumn)GridOrderDetail.Columns["TotalPrice"], "spinGrandTotal");
                    ((IPostBackDataHandler)spinGrandTotal).LoadPostData("spinGrandTotal", Request.Form);

                    ASPxSpinEdit spinGrandTotalCustomer = (ASPxSpinEdit)GridOrderDetail.FindFooterCellTemplateControl((GridViewDataSpinEditColumn)GridOrderDetail.Columns["TotalCustomer"], "spinGrandTotalCustomer");
                    ((IPostBackDataHandler)spinGrandTotalCustomer).LoadPostData("spinGrandTotalCustomer", Request.Form);  

                    SqlCommand commTotal = new SqlCommand();
                    commTotal.Connection = con;
                    commTotal.CommandText = "update Orders set TotalDiscount = @TotalDiscount, TotalIncrease = @TotalIncrease, GrandTotal = @GrandTotal, TotalCustomer = @TotalCustomer " +
                                            "where OrderID = @OrderID";
                    commTotal.Parameters.AddWithValue("@OrderID", Convert.ToInt32(Request.Params["OrderID"]));
                    commTotal.Parameters.AddWithValue("@TotalDiscount", Convert.ToDouble(spinDiscountTotal.Value));
                    commTotal.Parameters.AddWithValue("@TotalIncrease", Convert.ToDouble(spinIncreaseTotal.Value));
                    commTotal.Parameters.AddWithValue("@GrandTotal", Convert.ToDouble(spinGrandTotal.Value));
                    commTotal.Parameters.AddWithValue("@TotalCustomer", Convert.ToDouble(spinGrandTotalCustomer.Value));                                    

                    con.Open();
                    commTotal.ExecuteNonQuery();
                    con.Close();

                    GridOrderDetail.DataBind();

                    switch (parameter[1])
                    {
                        case ("New"):
                            GridOrderDetail.AddNewRow();
                            break;
                    }
                      
                    break;
            }
        }       
    }
}