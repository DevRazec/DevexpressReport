<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Orders.aspx.cs" Inherits="devexpress.Orders" %>

<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.17.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%--<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMenu" runat="server">
</asp:Content>--%>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderContent" runat="server">

    <script type="text/javascript">

        function ShowPopupOrderDetail(OrderID) {
            PopupOrderDetail.SetContentUrl('OrderDetail.aspx?OrderID=' + OrderID)
            PopupOrderDetail.Show()
        }

        function ShowPopupPrintOrder(OrderID) {
            PopupOrderDetail.SetContentUrl('PrintReport.aspx?Param1=' + 'Order' + '&Param2=' + OrderID)
            PopupOrderDetail.Show()
        }

        function OnCustomButtonClick(s, e) {

            if (e.buttonID == "btnOrderDetail") {
                s.GetRowValues(e.visibleIndex, 'OrderID', ShowPopupOrderDetail);
            }
                       
            if (e.buttonID == "btnPrintOrder") {
                s.GetRowValues(e.visibleIndex, 'OrderID', ShowPopupPrintOrder);
            }

            if (e.buttonID == "btnPrintProducts") {
                PopupOrderDetail.SetContentUrl('PrintReport.aspx?Param1=' + 'Products')
                PopupOrderDetail.Show()
            }           
        }

    </script>

    <dx:ASPxGridView ID="GridOrder" runat="server" AutoGenerateColumns="False" DataSourceID="DBOrder" KeyFieldName="OrderID" Width="100%"
        ClientInstanceName="GridOrder">
        
        <Columns>
            <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="false" VisibleIndex="0" ShowClearFilterButton="true" ShowCancelButton="true" ShowUpdateButton="true">
                <CustomButtons>
                    <dx:GridViewCommandColumnCustomButton Text="Order Detail" ID="btnOrderDetail">
                    </dx:GridViewCommandColumnCustomButton>
                    <dx:GridViewCommandColumnCustomButton Text="Print Order" ID="btnPrintOrder">
                    </dx:GridViewCommandColumnCustomButton>
                    <dx:GridViewCommandColumnCustomButton Text="Print Products" ID="btnPrintProducts">
                    </dx:GridViewCommandColumnCustomButton>                    
                </CustomButtons>
            </dx:GridViewCommandColumn>

            <dx:GridViewDataSpinEditColumn FieldName="OrderID" ReadOnly="false" VisibleIndex="1">
                <EditFormSettings Visible="False" />
                <PropertiesSpinEdit SpinButtons-Enabled="false" Increment="0"
                    MaxValue="2147483647" AllowNull="false" AllowMouseWheel="false">
                </PropertiesSpinEdit>                
            </dx:GridViewDataSpinEditColumn>

            <dx:GridViewDataDateColumn FieldName="OrderDate" VisibleIndex="2" Settings-AllowAutoFilter="False">
                <PropertiesDateEdit DisplayFormatString="dd/MM/yyy" EditFormatString="dd/MM/yyyy">
                </PropertiesDateEdit>
            </dx:GridViewDataDateColumn>

            <dx:GridViewDataComboBoxColumn FieldName="CustomerID" Caption="Customer Name" VisibleIndex="3">
                <PropertiesComboBox DataSourceID="DBCustomer" ValueField="CustomerID" ValueType="System.Int32" TextFormatString="{0}"
                    EnableCallbackMode="true" CallbackPageSize="10" DropDownStyle="DropDown" LoadDropDownOnDemand="true">
                    <Columns>
                        <dx:ListBoxColumn FieldName="CustomerName" Caption="Customer Name" />
                    </Columns>
                    <ValidationSettings ErrorDisplayMode="ImageWithTooltip" Display="Dynamic" SetFocusOnError="true">
                        <RequiredField IsRequired="true" ErrorText="This is required" />
                    </ValidationSettings>
                    <InvalidStyle BackColor="LightPink" />
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataSpinEditColumn FieldName="GrandTotal" VisibleIndex="4" Settings-AllowAutoFilter="False">
                <EditFormSettings Visible="False" />
                <PropertiesSpinEdit SpinButtons-Enabled="false" Increment="0" DisplayFormatString="c2"
                    MaxValue="2147483647" AllowNull="false" AllowMouseWheel="false">
                </PropertiesSpinEdit>                
            </dx:GridViewDataSpinEditColumn>

        </Columns>
             
        <ClientSideEvents CustomButtonClick="OnCustomButtonClick" />
               
        <SettingsEditing Mode="PopupEditForm" EditFormColumnCount="1" />
        <SettingsBehavior AllowFocusedRow="true" ColumnResizeMode="Disabled" />
        <Settings ShowFilterRow="true" ShowTitlePanel="true"  />   
        <Styles AlternatingRow-Enabled="True"></Styles>    
        <SettingsText Title="Orders" PopupEditFormCaption="Edit Order" />
        <SettingsPager PageSize="10" Position="Bottom">
            <PageSizeItemSettings Items="10, 20, 50" Visible="true" />
        </SettingsPager>
        <SettingsPopup>
            <EditForm Width="400" Height="160" HorizontalAlign="Center" VerticalAlign="WindowCenter" Modal="true" AllowResize="true" />
        </SettingsPopup>
    </dx:ASPxGridView>

    <dx:ASPxPopupControl ID="PopupOrderDetail" runat="server" HeaderText="Order Detail" AllowDragging="false" PopupAnimationType="Fade" ClientInstanceName="PopupOrderDetail" EnableViewState="false" ShowOnPageLoad="false"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="1600px" Height="900px" Modal="true" CloseOnEscape="false" CloseAction="None" ShowCloseButton="false" LoadContentViaCallback="None">              
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">               
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>

    <asp:SqlDataSource ID="DBOrder" runat="server" EnableCaching="true" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        DeleteCommand="DELETE FROM [Orders] WHERE [OrderID] = @OrderID" 
        InsertCommand="INSERT INTO [Orders] ([CustomerID], [OrderDate]) VALUES (@CustomerID, @OrderDate)" 
        SelectCommand="SELECT * FROM [Orders]" 
        UpdateCommand="UPDATE [Orders] SET [CustomerID] = @CustomerID, [OrderDate] = @OrderDate WHERE [OrderID] = @OrderID">
        <DeleteParameters>
            <asp:Parameter Name="OrderID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="CustomerID" Type="Int32" />
            <asp:Parameter Name="OrderDate" Type="DateTime" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="CustomerID" Type="Int32" />
            <asp:Parameter Name="OrderDate" Type="DateTime" />
            <asp:Parameter Name="OrderID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="DBCustomer" runat="server" EnableCaching="true"
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT * FROM [Customers]"></asp:SqlDataSource>    

</asp:Content>
