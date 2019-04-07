<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Customers.aspx.cs" Inherits="devexpress.Customers" %>

<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.17.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderContent" runat="server">

    <dx:ASPxGridView ID="GridCustomer" runat="server" AutoGenerateColumns="False" Width="100%" DataSourceID="DBCustomer" KeyFieldName="CustomerID" ClientInstanceName="GridCustomer">
        <Settings ShowFilterRow="True" />        
        <Columns>

            <dx:GridViewCommandColumn Name="Commands" Caption="Commands" ShowApplyFilterButton="true" ShowClearFilterButton="True" ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                <%--<CustomButtons>
                    <dx:GridViewCommandColumnCustomButton Text="Print" ID="Print" Visibility="AllDataRows"></dx:GridViewCommandColumnCustomButton>
                </CustomButtons>--%>
            </dx:GridViewCommandColumn>
            
            <dx:GridViewDataTextColumn FieldName="CustomerID" ReadOnly="True" VisibleIndex="1" Visible="False">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="CustomerName" Caption="Customer" VisibleIndex="2">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="Address" Caption="Address" VisibleIndex="3">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataComboBoxColumn FieldName="CountryID" Caption="Country" VisibleIndex="4">
                <PropertiesComboBox DataSourceID="DBCountry" ValueField="CountryID" ValueType="System.Int32" TextField="CountryName">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataTextColumn FieldName="Login" Caption="Login" VisibleIndex="5">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="Password" Caption="Password" VisibleIndex="6"  Settings-AllowAutoFilter="False">
                <PropertiesTextEdit Password="true"></PropertiesTextEdit>
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="Email" Caption="Email" VisibleIndex="7"  Settings-AllowAutoFilter="False">
            </dx:GridViewDataTextColumn>
        </Columns>
        <Settings ShowTitlePanel="true"/>
        <SettingsText Title="Customers" />
    </dx:ASPxGridView>

    <asp:SqlDataSource ID="DBCustomer" runat="server" EnableViewState="true" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT * FROM [Customers]"
        DeleteCommand="DELETE FROM [Customers] WHERE [CustomerID] = @CustomerID"
        InsertCommand="INSERT INTO [Customers] ([CountryID], [CustomerName], [Address], [Login], [Password], [Email]) VALUES (@CountryID, @CustomerName, @Address, @Login, @Password, @Email)"
        UpdateCommand="UPDATE [Customers] SET [CountryID] = @CountryID, [CustomerName] = @CustomerName, [Address] = @Address, [Login] = @Login, [Password] = @Password, [Email] = @Email WHERE [CustomerID] = @CustomerID">
        <DeleteParameters>
            <asp:Parameter Name="CustomerID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="CountryID" Type="Int32" />
            <asp:Parameter Name="CustomerName" Type="String" />
            <asp:Parameter Name="Address" Type="String" />
            <asp:Parameter Name="Login" Type="String" />
            <asp:Parameter Name="Password" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="CountryID" Type="Int32" />
            <asp:Parameter Name="CustomerName" Type="String" />
            <asp:Parameter Name="Address" Type="String" />
            <asp:Parameter Name="Login" Type="String" />
            <asp:Parameter Name="Password" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="CustomerID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="DBCountry" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT * FROM [Countries]"></asp:SqlDataSource>

</asp:Content>
