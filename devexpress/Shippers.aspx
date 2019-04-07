<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Shippers.aspx.cs" Inherits="devexpress.Shippers" %>

<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.17.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <dx:ASPxGridView ID="GridShipper" runat="server" AutoGenerateColumns="False" DataSourceID="DBShipper" KeyFieldName="ShipperID" ClientInstanceName="GridShipper" Width="100%">            
            <Columns>
                <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="ShipperID" ReadOnly="True" VisibleIndex="1" Settings-AllowAutoFilter="False">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ShipperName" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
            </Columns>
            <Settings ShowFilterRow="True" />
        </dx:ASPxGridView>

        <asp:SqlDataSource ID="DBShipper" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            DeleteCommand="DELETE FROM [Shippers] WHERE [ShipperID] = @ShipperID" 
            InsertCommand="INSERT INTO [Shippers] ([ShipperName]) VALUES (@ShipperName)" 
            SelectCommand="SELECT * FROM [Shippers]" 
            UpdateCommand="UPDATE [Shippers] SET [ShipperName] = @ShipperName WHERE [ShipperID] = @ShipperID">
            <DeleteParameters>
                <asp:Parameter Name="ShipperID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="ShipperName" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="ShipperName" Type="String" />
                <asp:Parameter Name="ShipperID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
