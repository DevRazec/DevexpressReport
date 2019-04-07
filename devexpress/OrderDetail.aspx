﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrderDetail.aspx.cs" Inherits="devexpress.OrderDetail" %>

<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.17.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="css/bootstrap.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">

        <script type="text/javascript">
                        
            function OnCloseClick(s, e) {
                GridOrderDetail.CancelEdit();
                window.parent.PopupOrderDetail.Hide();
            }                                                             

            function OnCustomButtonClick(s, e) {
                if (e.buttonID == "New") {
                    GridOrderDetail.PerformCallback('Save:New');
                }
            }        

        </script>

        <nav class="navbar-lower" role="navigation">
            <div class="panel panel-default">
                <div class="panel-heading2">

                    <a class="btn">
                        <h4>Order Detail</h4>
                    </a>

                    <dx:ASPxButton ID="btnSave" runat="server" EnableTheming="false" CssClass="btn btn-success btn-sm"
                        Text="Save" UseSubmitBehavior="false" AutoPostBack="false" Width="120px">
                        <ClientSideEvents Click="function(s, e) { GridOrderDetail.PerformCallback('Save:Save'); }" />
                    </dx:ASPxButton>

                    <dx:ASPxButton ID="btnClose" runat="server" EnableTheming="false" CssClass="btn btn-warning btn-sm"
                        Text="Close" UseSubmitBehavior="false" AutoPostBack="false" Width="120px">
                        <ClientSideEvents Click="function(s, e) { OnCloseClick(s, e); }" />
                    </dx:ASPxButton>
                                       
                    <dx:ASPxButton ID="btnProduct" runat="server" EnableTheming="false" CssClass="btn btn-danger btn-sm"
                        Text="Add Product" UseSubmitBehavior="false" AutoPostBack="false" Width="120px">
                        <ClientSideEvents Click="function(s, e) { Popup.SetContentUrl('Products.aspx'); Popup.Show(); }" />
                    </dx:ASPxButton>

                    <dx:ASPxButton ID="btnShipper" runat="server" EnableTheming="false" CssClass="btn btn-primary btn-sm"
                        Text="Add Shipper" UseSubmitBehavior="false" AutoPostBack="false" Width="120px">
                        <ClientSideEvents Click="function(s, e) { Popup.SetContentUrl('Shippers.aspx'); Popup.Show(); }" />
                    </dx:ASPxButton>

                </div>
            </div>
        </nav>

        <dx:ASPxHiddenField ID="ListIdRowsChanged" ClientInstanceName="ListIdRowsChanged" runat="server"></dx:ASPxHiddenField>

        <div>
            <dx:ASPxGridView ID="GridOrderDetail" runat="server" AutoGenerateColumns="False" DataSourceID="DBOrderDetail" KeyFieldName="OrderDetailID" Width="100%" ViewStateMode="Disabled"
                ClientInstanceName="GridOrderDetail"
                OnInitNewRow="GridOrderDetail_InitNewRow"
                OnRowInserting="GridOrderDetail_RowInserting"
                OnCustomCallback="GridOrderDetail_CustomCallback"
                OnCustomColumnGroup="GridOrderDetail_CustomColumnGroup"
                OnCustomColumnSort="GridOrderDetail_CustomColumnSort">

                <Columns>

                    <dx:GridViewCommandColumn ShowSelectCheckbox="true" VisibleIndex="0" Width="60px">
                        <HeaderTemplate>
                            <dx:ASPxCheckBox ID="chkSelectAll" runat="server" ToolTip="Select All"
                                ClientSideEvents-CheckedChanged="function(s,e){GridOrderDetail.SelectAllRowsOnPage(s.GetChecked());}">
                            </dx:ASPxCheckBox>
                        </HeaderTemplate>
                    </dx:GridViewCommandColumn>

                    <dx:GridViewCommandColumn ShowDeleteButton="True" ShowNewButton="False" VisibleIndex="1">
                        <CustomButtons>
                            <dx:GridViewCommandColumnCustomButton ID="New" Text="New" Visibility="AllDataRows">
                            </dx:GridViewCommandColumnCustomButton>
                        </CustomButtons>
                    </dx:GridViewCommandColumn>

                    <dx:GridViewDataTextColumn FieldName="OrderDetailID" ReadOnly="True" VisibleIndex="2" Visible="false">
                        <EditFormSettings Visible="False" />
                    </dx:GridViewDataTextColumn>

                    <dx:GridViewDataTextColumn FieldName="OrderID" VisibleIndex="3" Visible="false">
                        <EditFormSettings Visible="false" />
                    </dx:GridViewDataTextColumn>

                    <dx:GridViewDataSpinEditColumn FieldName="SortShipper" Caption="Sort Shipper" VisibleIndex="4" Width="100px" Visible="false" ReadOnly="true">
                        <EditFormSettings Visible="false" />
                        <PropertiesSpinEdit SpinButtons-ClientVisible="false" Increment="0" MinValue="0" SpinButtons-ShowIncrementButtons="false" NumberType="Integer"
                            MaxValue="2147483647" AllowNull="false" AllowMouseWheel="false" ClientInstanceName="colSortShipper">
                        </PropertiesSpinEdit>
                    </dx:GridViewDataSpinEditColumn>

                    <dx:GridViewDataSpinEditColumn FieldName="SortProduct" Caption="Sort Product" VisibleIndex="4" SortIndex="1" SortOrder="Ascending" Width="100px">
                        <EditFormSettings Visible="true" />
                        <DataItemTemplate>
                            <dx:ASPxSpinEdit ID="spinSortProduct" runat="server" Number="0" MaxValue="99" MinValue="0" AllowNull="false" AllowMouseWheel="false" ClientInstanceName="spinSortProduct"
                                SpinButtons-ShowIncrementButtons="false" MaxLength="2" SpinButtons-ClientVisible="false" Increment="0" HorizontalAlign="Center" Width="100%"
                                Value='<%# Eval("SortProduct") %>'>
                            </dx:ASPxSpinEdit>
                        </DataItemTemplate>
                        <PropertiesSpinEdit SpinButtons-ClientVisible="false" Increment="0" MinValue="0" SpinButtons-ShowIncrementButtons="false"
                            MaxValue="2147483647" AllowNull="false" AllowMouseWheel="false">
                        </PropertiesSpinEdit>
                    </dx:GridViewDataSpinEditColumn>

                    <dx:GridViewDataComboBoxColumn FieldName="ShipperID" Caption="Shipper Name" VisibleIndex="5" GroupIndex="0" ShowInCustomizationForm="True" Visible="true">
                        <EditFormSettings Visible="True" />
                        <PropertiesComboBox DataSourceID="DBShipper" ValueField="ShipperID" ValueType="System.Int32" TextField="ShipperName" TextFormatString="{0} | {1}"
                            EnableCallbackMode="true" CallbackPageSize="10" DropDownStyle="DropDown" LoadDropDownOnDemand="true" DataSecurityMode="Strict">
                            <Columns>
                                <dx:ListBoxColumn FieldName="ShipperID" Caption="Shipper ID" />
                                <dx:ListBoxColumn FieldName="ShipperName" Caption="Shipper Name" />
                            </Columns>
                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" Display="Dynamic" SetFocusOnError="true">
                                <RequiredField IsRequired="true" ErrorText="This is required" />
                            </ValidationSettings>
                            <InvalidStyle BackColor="LightPink" />
                        </PropertiesComboBox>
                        <Settings SortMode="Custom" />
                        <Settings AllowSort="False" AllowGroup="True" AllowHeaderFilter="False" />
                    </dx:GridViewDataComboBoxColumn>

                    <dx:GridViewDataComboBoxColumn FieldName="ProductID" Caption="Product Name" VisibleIndex="6" ShowInCustomizationForm="True" Width="300px">
                        <DataItemTemplate>
                            <dx:ASPxComboBox ID="cboProduct" runat="server" DataSourceID="DBProduct" ValueField="ProductID" ValueType="System.Int32" TextFormatString="{0} | {1}"
                                EnableCallbackMode="true" CallbackPageSize="10" DropDownStyle="DropDown" LoadDropDownOnDemand="true" DataSecurityMode="Strict" Width="100%"
                                Value='<%# Eval("ProductID") %>' ClientInstanceName="cboProduct">
                                <Columns>
                                    <dx:ListBoxColumn FieldName="ProductName" Caption="Product Name" />
                                    <dx:ListBoxColumn FieldName="UnitPrice" Caption="Price" />
                                </Columns>
                                <ValidationSettings ErrorDisplayMode="ImageWithTooltip" Display="Dynamic" SetFocusOnError="true" ValidationGroup="a">
                                    <RequiredField IsRequired="true" ErrorText="This is required" />
                                </ValidationSettings>
                                <InvalidStyle BackColor="LightPink" />
                            </dx:ASPxComboBox>
                        </DataItemTemplate>

                        <PropertiesComboBox DataSourceID="DBProduct" ValueField="ProductID" ValueType="System.Int32" TextField="ProductName" TextFormatString="{0} | {1}"
                            EnableCallbackMode="true" CallbackPageSize="10" DropDownStyle="DropDown" LoadDropDownOnDemand="true" DataSecurityMode="Strict">
                            <Columns>
                                <dx:ListBoxColumn FieldName="ProductName" Caption="Product Name" />
                                <dx:ListBoxColumn FieldName="UnitPrice" Caption="Price" />
                            </Columns>
                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" Display="Dynamic" SetFocusOnError="true">
                                <RequiredField IsRequired="true" ErrorText="This is required" />
                            </ValidationSettings>
                            <InvalidStyle BackColor="LightPink" />                            
                        </PropertiesComboBox>
                    </dx:GridViewDataComboBoxColumn>

                    <dx:GridViewDataSpinEditColumn FieldName="Quantity" VisibleIndex="7" ShowInCustomizationForm="True" Visible="false" ReadOnly="true">
                        <EditFormSettings Visible="false" />
                        <PropertiesSpinEdit SpinButtons-ClientVisible="false" Increment="0" MinValue="1" SpinButtons-ShowIncrementButtons="false"
                            MaxValue="2147483647" AllowNull="false" AllowMouseWheel="false">
                        </PropertiesSpinEdit>
                    </dx:GridViewDataSpinEditColumn>

                    <dx:GridViewDataSpinEditColumn FieldName="DefaultPrice" Caption="Default Price" VisibleIndex="8" ReadOnly="true">
                        <DataItemTemplate>
                            <dx:ASPxSpinEdit ID="spinDefaultPrice" runat="server" Number="0" MaxValue="2147483647" MinValue="0" AllowNull="false" AllowMouseWheel="false" ClientInstanceName="spinDefaultPrice"
                                SpinButtons-ShowIncrementButtons="false" SpinButtons-ClientVisible="false" Increment="0" HorizontalAlign="Right" DisplayFormatInEditMode="true" Width="100%" ReadOnly="true"
                                DisplayFormatString="c2" Value='<%# Eval("DefaultPrice") %>'>
                            </dx:ASPxSpinEdit>
                        </DataItemTemplate>
                        <PropertiesSpinEdit DisplayFormatString="c2" DisplayFormatInEditMode="true" SpinButtons-ClientVisible="false" Increment="0" SpinButtons-ShowIncrementButtons="false"
                            MaxValue="2147483647" MinValue="0" AllowNull="false" AllowMouseWheel="false" NumberType="Float">
                        </PropertiesSpinEdit>
                    </dx:GridViewDataSpinEditColumn>

                    <dx:GridViewDataSpinEditColumn FieldName="UnitPrice" Caption="Unit Price" VisibleIndex="9" ShowInCustomizationForm="True">
                        <DataItemTemplate>
                            <dx:ASPxSpinEdit ID="spinUnitPrice" runat="server" MaxValue="2147483647" MinValue="0" AllowNull="false" AllowMouseWheel="false" ClientInstanceName="spinUnitPrice"
                                SpinButtons-ShowIncrementButtons="false" SpinButtons-ClientVisible="false" Increment="0" HorizontalAlign="Right" DisplayFormatInEditMode="true" Width="100%"
                                DisplayFormatString="c2" Value='<%# Eval("UnitPrice") %>'>
                            </dx:ASPxSpinEdit>
                        </DataItemTemplate>
                        <PropertiesSpinEdit DisplayFormatString="c2" DisplayFormatInEditMode="true" SpinButtons-ClientVisible="false" Increment="0" SpinButtons-ShowIncrementButtons="false"
                            MaxValue="2147483647" MinValue="0" AllowNull="false" AllowMouseWheel="false" NumberType="Float">
                        </PropertiesSpinEdit>

                    </dx:GridViewDataSpinEditColumn>

                    <dx:GridViewDataSpinEditColumn FieldName="Discount" Caption="Discount" VisibleIndex="10" ShowInCustomizationForm="True">
                        <DataItemTemplate>
                            <dx:ASPxSpinEdit ID="spinDiscount" runat="server" MaxValue="2147483647" MinValue="0" AllowNull="false" AllowMouseWheel="false" ClientInstanceName="spinDiscount"
                                SpinButtons-ShowIncrementButtons="false" SpinButtons-ClientVisible="false" Increment="0" HorizontalAlign="Right" DisplayFormatInEditMode="true" Width="100%"
                                DisplayFormatString="c2" Value='<%# Eval("Discount") %>'>
                            </dx:ASPxSpinEdit>
                        </DataItemTemplate>
                        <PropertiesSpinEdit DisplayFormatString="c2" DisplayFormatInEditMode="true" SpinButtons-ClientVisible="false" Increment="0" SpinButtons-ShowIncrementButtons="false"
                            MaxValue="2147483647" MinValue="0" AllowNull="false" AllowMouseWheel="false" NumberType="Float">
                        </PropertiesSpinEdit>

                        <GroupFooterTemplate>
                            <dx:ASPxSpinEdit ID="spinGroupDiscountTotal" runat="server" Number="0" MaxValue="2147483647" MinValue="0" AllowNull="false" AllowMouseWheel="false" ClientInstanceName="spinGroupDiscountTotal"
                                SpinButtons-ShowIncrementButtons="false" SpinButtons-ClientVisible="false" Increment="0" HorizontalAlign="Right" DisplayFormatInEditMode="true" Width="100%" ReadOnly="true"
                                DisplayFormatString="c2" Caption="Discount Total">
                                <CaptionSettings Position="Top" HorizontalAlign="Right" ShowColon="false" />
                            </dx:ASPxSpinEdit>
                        </GroupFooterTemplate>

                        <FooterTemplate>
                            <dx:ASPxSpinEdit ID="spinDiscountTotal" runat="server" Number="0" MaxValue="2147483647" MinValue="0" AllowNull="false" AllowMouseWheel="false" ClientInstanceName="spinDiscountTotal"
                                SpinButtons-ShowIncrementButtons="false" SpinButtons-ClientVisible="false" Increment="0" HorizontalAlign="Right" DisplayFormatInEditMode="true" Width="100%" ReadOnly="true"
                                DisplayFormatString="c2" Caption="Discount Total">
                                <CaptionSettings Position="Top" HorizontalAlign="Right" ShowColon="false" />
                            </dx:ASPxSpinEdit>
                        </FooterTemplate>

                    </dx:GridViewDataSpinEditColumn>

                    <dx:GridViewDataSpinEditColumn FieldName="Increase" Caption="Increase" VisibleIndex="11" ShowInCustomizationForm="True">
                        <DataItemTemplate>
                            <dx:ASPxSpinEdit ID="spinIncrease" runat="server" MaxValue="2147483647" MinValue="0" AllowNull="false" AllowMouseWheel="false" ClientInstanceName="spinIncrease"
                                SpinButtons-ShowIncrementButtons="false" SpinButtons-ClientVisible="false" Increment="0" HorizontalAlign="Right" DisplayFormatInEditMode="true" Width="100%"
                                DisplayFormatString="c2" Value='<%# Eval("Increase") %>'>
                            </dx:ASPxSpinEdit>
                        </DataItemTemplate>
                        <PropertiesSpinEdit DisplayFormatString="c2" DisplayFormatInEditMode="true" SpinButtons-ClientVisible="false" Increment="0" SpinButtons-ShowIncrementButtons="false"
                            MaxValue="2147483647" MinValue="0" AllowNull="false" AllowMouseWheel="false" NumberType="Float">
                        </PropertiesSpinEdit>

                        <GroupFooterTemplate>
                            <dx:ASPxSpinEdit ID="spinGroupIncreaseTotal" runat="server" Number="0" MaxValue="2147483647" MinValue="0" AllowNull="false" AllowMouseWheel="false" ClientInstanceName="spinGroupIncreaseTotal"
                                SpinButtons-ShowIncrementButtons="false" SpinButtons-ClientVisible="false" Increment="0" HorizontalAlign="Right" DisplayFormatInEditMode="true" Width="100%" ReadOnly="true"
                                DisplayFormatString="c2" Caption="Increase Total">
                                <CaptionSettings Position="Top" HorizontalAlign="Right" ShowColon="false" />
                            </dx:ASPxSpinEdit>
                        </GroupFooterTemplate>

                        <FooterTemplate>
                            <dx:ASPxSpinEdit ID="spinIncreaseTotal" runat="server" Number="0" MaxValue="2147483647" MinValue="0" AllowNull="false" AllowMouseWheel="false" ClientInstanceName="spinIncreaseTotal"
                                SpinButtons-ShowIncrementButtons="false" SpinButtons-ClientVisible="false" Increment="0" HorizontalAlign="Right" DisplayFormatInEditMode="true" Width="100%" ReadOnly="true"
                                DisplayFormatString="c2" Caption="Increase Total">
                                <CaptionSettings Position="Top" HorizontalAlign="Right" ShowColon="false" />
                            </dx:ASPxSpinEdit>
                        </FooterTemplate>

                    </dx:GridViewDataSpinEditColumn>

                    <dx:GridViewDataSpinEditColumn FieldName="TotalPrice" Caption="Total" VisibleIndex="12" ShowInCustomizationForm="True" ReadOnly="true">
                        <EditFormSettings Visible="false" />

                        <DataItemTemplate>
                            <dx:ASPxSpinEdit ID="spinRowTotal" runat="server" Number="0" MaxValue="2147483647" MinValue="0" AllowNull="false" AllowMouseWheel="false" ClientInstanceName="spinRowTotal"
                                SpinButtons-ShowIncrementButtons="false" SpinButtons-ClientVisible="false" Increment="0" HorizontalAlign="Right" DisplayFormatInEditMode="true" Width="100%" ReadOnly="false"
                                DisplayFormatString="c2" Value='<%# Eval("TotalPrice") %>'>
                            </dx:ASPxSpinEdit>
                        </DataItemTemplate>

                        <PropertiesSpinEdit DisplayFormatString="c2" DisplayFormatInEditMode="true" SpinButtons-ClientVisible="false" Increment="0" SpinButtons-ShowIncrementButtons="false"
                            MaxValue="2147483647" MinValue="0" AllowNull="false" AllowMouseWheel="false">
                        </PropertiesSpinEdit>

                        <GroupFooterTemplate>
                            <dx:ASPxSpinEdit ID="spinGroupTotal" runat="server" Number="0" MaxValue="2147483647" MinValue="0" AllowNull="false" AllowMouseWheel="false" ClientInstanceName="spinGroupTotal"
                                SpinButtons-ShowIncrementButtons="false" SpinButtons-ClientVisible="false" Increment="0" HorizontalAlign="Right" DisplayFormatInEditMode="true" Width="100%" ReadOnly="true"
                                DisplayFormatString="c2" Caption="Group Total">
                                <CaptionSettings Position="Top" HorizontalAlign="Right" ShowColon="false" />
                            </dx:ASPxSpinEdit>
                        </GroupFooterTemplate>

                        <FooterTemplate>
                            <dx:ASPxSpinEdit ID="spinGrandTotal" runat="server" Number="0" MaxValue="2147483647" MinValue="0" AllowNull="false" AllowMouseWheel="false" ClientInstanceName="spinGrandTotal"
                                SpinButtons-ShowIncrementButtons="false" SpinButtons-ClientVisible="false" Increment="0" HorizontalAlign="Right" DisplayFormatInEditMode="true" Width="100%" ReadOnly="true"
                                DisplayFormatString="c2" Caption="Grand Total">
                                <CaptionSettings Position="Top" HorizontalAlign="Right" ShowColon="false" />
                            </dx:ASPxSpinEdit>
                        </FooterTemplate>

                    </dx:GridViewDataSpinEditColumn>

                    <dx:GridViewDataSpinEditColumn FieldName="TotalCustomer" Caption="Total Customer" VisibleIndex="12" ShowInCustomizationForm="True" ReadOnly="true">
                        <EditFormSettings Visible="false" />

                        <DataItemTemplate>
                            <dx:ASPxSpinEdit ID="spinRowTotalCustomer" runat="server" Number="0" MaxValue="2147483647" MinValue="0" AllowNull="false" AllowMouseWheel="false" ClientInstanceName="spinRowTotalCustomer"
                                SpinButtons-ShowIncrementButtons="false" SpinButtons-ClientVisible="false" Increment="0" HorizontalAlign="Right" DisplayFormatInEditMode="true" Width="100%" ReadOnly="false"
                                DisplayFormatString="c2" Value='<%# Eval("TotalCustomer") %>'>
                            </dx:ASPxSpinEdit>
                        </DataItemTemplate>

                        <PropertiesSpinEdit DisplayFormatString="c2" DisplayFormatInEditMode="true" SpinButtons-ClientVisible="false" Increment="0" SpinButtons-ShowIncrementButtons="false"
                            MaxValue="2147483647" MinValue="0" AllowNull="false" AllowMouseWheel="false">
                        </PropertiesSpinEdit>

                        <GroupFooterTemplate>
                            <dx:ASPxSpinEdit ID="spinGroupTotalCustomer" runat="server" Number="0" MaxValue="2147483647" MinValue="0" AllowNull="false" AllowMouseWheel="false" ClientInstanceName="spinGroupTotalCustomer"
                                SpinButtons-ShowIncrementButtons="false" SpinButtons-ClientVisible="false" Increment="0" HorizontalAlign="Right" DisplayFormatInEditMode="true" Width="100%" ReadOnly="true"
                                DisplayFormatString="c2" Caption="Total Customer">
                                <CaptionSettings Position="Top" HorizontalAlign="Right" ShowColon="false" />
                            </dx:ASPxSpinEdit>
                        </GroupFooterTemplate>

                        <FooterTemplate>
                            <dx:ASPxSpinEdit ID="spinGrandTotalCustomer" runat="server" Number="0" MaxValue="2147483647" MinValue="0" AllowNull="false" AllowMouseWheel="false" ClientInstanceName="spinGrandTotalCustomer"
                                SpinButtons-ShowIncrementButtons="false" SpinButtons-ClientVisible="false" Increment="0" HorizontalAlign="Right" DisplayFormatInEditMode="true" Width="100%" ReadOnly="true"
                                DisplayFormatString="c2" Caption="Total Customer">
                                <CaptionSettings Position="Top" HorizontalAlign="Right" ShowColon="false" />
                            </dx:ASPxSpinEdit>
                        </FooterTemplate>

                        <CellStyle BackColor="#D9534F"></CellStyle>
                        <FooterCellStyle BackColor="#D9534F"></FooterCellStyle>
                        <GroupFooterCellStyle BackColor="#D9534F"></GroupFooterCellStyle>

                    </dx:GridViewDataSpinEditColumn>

                    <dx:GridViewDataTextColumn FieldName="Observation" VisibleIndex="13" Visible="false">
                    </dx:GridViewDataTextColumn>

                </Columns>

                <ClientSideEvents CustomButtonClick="OnCustomButtonClick" />

                <Templates>
                    <GroupRowContent>
                        <table>
                            <tr>
                                <td>
                                    <dx:ASPxSpinEdit ID="spinSortShipper" runat="server" Number="0" MaxValue="99" MinValue="0" AllowNull="false" AllowMouseWheel="false" ClientInstanceName="spinSortShipper"
                                        SpinButtons-ShowIncrementButtons="false" MaxLength="2" SpinButtons-ClientVisible="false" Increment="0" HorizontalAlign="Center" Width="70px" Caption="Sort"
                                        Value='<%# Eval("SortShipper") %>'>
                                        <CaptionSettings Position="Top" />
                                        <CaptionStyle ForeColor="White"></CaptionStyle>
                                    </dx:ASPxSpinEdit>
                                </td>
                                <td>
                                    <dx:ASPxComboBox ID="cboShipper" runat="server" Caption="Shipper Name" DataSourceID="DBShipper" ValueField="ShipperID" ValueType="System.Int32" TextFormatString="{0} | {1}"
                                        EnableCallbackMode="true" CallbackPageSize="10" DropDownStyle="DropDown" LoadDropDownOnDemand="true" DataSecurityMode="Strict" ClientInstanceName="cboShipper" Width="300px"
                                        Value='<%# Eval("ShipperID") %>'>
                                        <Columns>
                                            <dx:ListBoxColumn FieldName="ShipperID" Caption="Shipper ID" />
                                            <dx:ListBoxColumn FieldName="ShipperName" Caption="Shipper Name" />
                                        </Columns>
                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" Display="Dynamic" SetFocusOnError="true" ValidationGroup="a">
                                            <RequiredField IsRequired="true" ErrorText="This is required" />
                                        </ValidationSettings>
                                        <InvalidStyle BackColor="LightPink" />
                                        <CaptionSettings Position="Top" />
                                        <CaptionStyle ForeColor="White"></CaptionStyle>
                                    </dx:ASPxComboBox>
                                </td>
                                <td>
                                    <dx:ASPxSpinEdit ID="spinQuantity" runat="server" Number="0" MaxValue="99" MinValue="0" AllowNull="false" AllowMouseWheel="false" ClientInstanceName="spinQuantity"
                                        SpinButtons-ShowIncrementButtons="false" MaxLength="2" SpinButtons-Enabled="false" Increment="0" HorizontalAlign="Center" Width="70px" Caption="Quantity"
                                        Value='<%# Eval("Quantity") %>'>
                                        <CaptionSettings Position="Top" />
                                        <CaptionStyle ForeColor="White"></CaptionStyle>                                        
                                    </dx:ASPxSpinEdit>
                                </td>
                                <td>
                                    <dx:ASPxSpinEdit ID="spinUnitPriceGroup" runat="server" Number="0" MaxValue="2147483647" MinValue="0" AllowNull="false" AllowMouseWheel="false" ClientInstanceName="spinUnitPriceGroup"
                                        SpinButtons-ShowIncrementButtons="false" SpinButtons-ClientVisible="false" Increment="0" HorizontalAlign="Right" DisplayFormatInEditMode="true" Width="150px" ReadOnly="true"
                                        DisplayFormatString="c2" Caption="Unit Price Group">
                                        <CaptionSettings Position="Top" />
                                        <CaptionStyle ForeColor="White"></CaptionStyle>
                                    </dx:ASPxSpinEdit>
                                </td>
                                <td>
                                    <dx:ASPxSpinEdit ID="spinUnitDiscountTotal" runat="server" Number="0" MaxValue="2147483647" MinValue="0" AllowNull="false" AllowMouseWheel="false" ClientInstanceName="spinUnitDiscountTotal"
                                        SpinButtons-ShowIncrementButtons="false" SpinButtons-ClientVisible="false" Increment="0" HorizontalAlign="Right" DisplayFormatInEditMode="true" Width="150px" ReadOnly="true"
                                        DisplayFormatString="c2" Caption="Unit Discount Total">
                                        <CaptionSettings Position="Top" />
                                        <CaptionStyle ForeColor="White"></CaptionStyle>
                                    </dx:ASPxSpinEdit>
                                </td>
                                <td>
                                    <dx:ASPxSpinEdit ID="spinUnitIncreaseTotal" runat="server" Number="0" MaxValue="2147483647" MinValue="0" AllowNull="false" AllowMouseWheel="false" ClientInstanceName="spinUnitIncreaseTotal"
                                        SpinButtons-ShowIncrementButtons="false" SpinButtons-ClientVisible="false" Increment="0" HorizontalAlign="Right" DisplayFormatInEditMode="true" Width="150px" ReadOnly="true"
                                        DisplayFormatString="c2" Caption="Unit Increase Total">
                                        <CaptionSettings Position="Top" />
                                        <CaptionStyle ForeColor="White"></CaptionStyle>
                                    </dx:ASPxSpinEdit>
                                </td>
                                <td>
                                    <dx:ASPxSpinEdit ID="spinUnitTotal" runat="server" Number="0" MaxValue="2147483647" MinValue="0" AllowNull="false" AllowMouseWheel="false" ClientInstanceName="spinUnitTotal"
                                        SpinButtons-ShowIncrementButtons="false" SpinButtons-ClientVisible="false" Increment="0" HorizontalAlign="Right" DisplayFormatInEditMode="true" Width="150px" ReadOnly="true"
                                        DisplayFormatString="c2" Caption="Unit Total">
                                        <CaptionSettings Position="Top" />
                                        <CaptionStyle ForeColor="White"></CaptionStyle>
                                    </dx:ASPxSpinEdit>
                                </td>
                            </tr>
                        </table>
                    </GroupRowContent>
                </Templates>

                <SettingsEditing Mode="PopupEditForm" EditFormColumnCount="1">
                </SettingsEditing>

                <SettingsPopup>
                    <EditForm Width="600" HorizontalAlign="Center" VerticalAlign="WindowCenter" Modal="true" AllowResize="true" />
                </SettingsPopup>

                <SettingsDetail ShowDetailButtons="false" ShowDetailRow="false" AllowOnlyOneMasterRowExpanded="false" />

                <Settings ShowFooter="true" ShowGroupPanel="false" ShowGroupFooter="VisibleAlways" ShowGroupButtons="false" ShowStatusBar="Hidden" ShowGroupedColumns="true" />

                <SettingsPager PageSize="9999" Visible="False">
                    <PageSizeItemSettings ShowAllItem="true"></PageSizeItemSettings>
                </SettingsPager>

                <SettingsBehavior AutoExpandAllGroups="true" AllowGroup="true" EnableCustomizationWindow="true" ColumnResizeMode="Control" AllowSort="false" AllowDragDrop="false" AllowFocusedRow="true" />

                <%--<TotalSummary>
                    <dx:ASPxSummaryItem FieldName="TotalPrice" ShowInColumn="TotalPrice" SummaryType="Sum" DisplayFormat="Total: {0:c2}" />
                </TotalSummary>--%>


                <%--<GroupSummary>
                    <dx:ASPxSummaryItem FieldName="TotalPrice" ShowInGroupFooterColumn="TotalPrice" SummaryType="Sum" DisplayFormat="Total: {0:c2}" />
                </GroupSummary>--%>

                <Styles AlternatingRow-Enabled="True">
                    <GroupRow BackColor="#5cb85c" Font-Bold="true" ForeColor="White"></GroupRow>
                    <Footer BackColor="#5cb85c"></Footer>
                </Styles>

            </dx:ASPxGridView>

            <asp:SqlDataSource ID="DBOrderDetail" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                DeleteCommand="DELETE FROM [OrderDetails] WHERE [OrderDetailID] = @OrderDetailID"
                InsertCommand="INSERT INTO [OrderDetails] ([OrderID], [SortShipper], [SortProduct], [ShipperID], [ProductID], [Quantity], [DefaultPrice], [UnitPrice], [Discount], [Increase], [TotalPrice], [TotalCustomer], [Observation]) VALUES (@OrderID, @SortShipper, @SortProduct, @ShipperID, @ProductID, @Quantity, @DefaultPrice, @UnitPrice, @Discount, @Increase, @TotalPrice, @TotalCustomer, @Observation)"
                SelectCommand="SELECT od.OrderDetailID, od.OrderID, od.SortShipper, od.SortProduct, od.ShipperID, od.ProductID, od.Quantity, od.DefaultPrice, od.UnitPrice, od.Discount, od.Increase, od.TotalPrice, od.TotalCustomer, od.Observation, sp.ShipperName FROM [OrderDetails] od
                               join Shippers sp on od.ShipperID = sp.ShipperID
                               WHERE [OrderID] = @OrderID"
                UpdateCommand="UPDATE [OrderDetails] SET [OrderID] = @OrderID, [SortShipper] = @SortShipper, [SortProduct] = @SortProduct, [ShipperID] = @ShipperID, [ProductID] = @ProductID, [Quantity] = @Quantity, [DefaultPrice] = @DefaultPrice, [UnitPrice] = @UnitPrice, [Discount] = @Discount, [Increase] = @Increase, [TotalPrice] = @TotalPrice, [TotalCustomer] = @TotalCustomer, [Observation] = @Observation WHERE [OrderDetailID] = @OrderDetailID">
                <SelectParameters>
                    <asp:Parameter Name="OrderID" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="OrderDetailID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="OrderID" Type="Int32" />
                    <asp:Parameter Name="SortShipper" Type="Int32" />
                    <asp:Parameter Name="SortProduct" Type="Int32" />
                    <asp:Parameter Name="ShipperID" Type="Int32" />
                    <asp:Parameter Name="ProductID" Type="Int32" />
                    <asp:Parameter Name="Quantity" Type="Int32" />
                    <asp:Parameter Name="DefaultPrice" Type="Double" />
                    <asp:Parameter Name="UnitPrice" Type="Double" />
                    <asp:Parameter Name="Discount" Type="Double" />
                    <asp:Parameter Name="Increase" Type="Double" />
                    <asp:Parameter Name="TotalPrice" Type="Double" />
                    <asp:Parameter Name="TotalCustomer" Type="Double" />
                    <asp:Parameter Name="Observation" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="OrderID" Type="Int32" />
                    <asp:Parameter Name="SortShipper" Type="Int32" />
                    <asp:Parameter Name="SortProduct" Type="Int32" />
                    <asp:Parameter Name="ShipperID" Type="Int32" />
                    <asp:Parameter Name="ProductID" Type="Int32" />
                    <asp:Parameter Name="Quantity" Type="Int32" />
                    <asp:Parameter Name="DefaultPrice" Type="Double" />
                    <asp:Parameter Name="UnitPrice" Type="Double" />
                    <asp:Parameter Name="Discount" Type="Double" />
                    <asp:Parameter Name="Increase" Type="Double" />
                    <asp:Parameter Name="TotalPrice" Type="Double" />
                    <asp:Parameter Name="TotalCustomer" Type="Double" />
                    <asp:Parameter Name="Observation" Type="String" />
                    <asp:Parameter Name="OrderDetailID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="DBProduct" runat="server" EnableCaching="true" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                SelectCommand="SELECT ProductID, ProductName, CAST(UnitPrice AS decimal(10,2)) as UnitPrice FROM [Products]"></asp:SqlDataSource>

            <asp:SqlDataSource ID="DBCountry" runat="server" EnableCaching="true" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                SelectCommand="SELECT * FROM [Countries]"></asp:SqlDataSource>

            <asp:SqlDataSource ID="DBCategory" runat="server" EnableCaching="true" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                SelectCommand="SELECT * FROM [Categories]"></asp:SqlDataSource>

            <asp:SqlDataSource ID="DBShipper" runat="server" EnableCaching="true" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                SelectCommand="SELECT * FROM [Shippers]"></asp:SqlDataSource>

        </div>

        <dx:ASPxPopupControl ID="Popup" runat="server" HeaderText="" AllowDragging="false" PopupAnimationType="Fade" ClientInstanceName="Popup" EnableViewState="false" ShowOnPageLoad="false"
            PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="800px" Height="800px" Modal="true" CloseAction="CloseButton" CloseOnEscape="true" ShowCloseButton="true" LoadContentViaCallback="None">
            <ContentCollection>
                <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxPopupControl>

    </form>
</body>
</html>
