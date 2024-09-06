<%@ Page Title="" Language="C#" MasterPageFile="~/Master/AdminMaster.Master" AutoEventWireup="true" CodeBehind="StudentProgress.aspx.cs" Inherits="Language.Discovery.Admin.StudentProgress" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <style>
        .arrow-up {
  width: 0; 
  height: 0; 
  border-left: 5px solid transparent;
  border-right: 5px solid transparent;
  
  border-bottom: 5px solid black;
}

.arrow-down {
  width: 0; 
  height: 0; 
  border-left: 20px solid transparent;
  border-right: 20px solid transparent;
  
  border-top: 20px solid #f00;
}
    </style>
    <asp:HiddenField ID="hdnSelectSchool" runat="server" value="[Select School]"  meta:resourcekey="hdnSelectSchoolResource1" />

    <table>
        <tr>
            <td>
                <asp:Label ID="lblSchool" runat="server" Text="School" meta:resourcekey="lblSchoolResource1"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlSchool" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlSchool_SelectedIndexChanged" meta:resourcekey="ddlSchoolResource1"></asp:DropDownList>
                <asp:CompareValidator ID="CompareValidator1" ClientIDMode="Static"  runat="server" ErrorMessage="School is required." ControlToValidate="ddlSchool" ValueToCompare="0" Operator="NotEqual" ValidationGroup="v" ForeColor="Red" meta:resourcekey="CompareValidator1Resource1">*</asp:CompareValidator>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblExport" runat="server" Text="Export" meta:resourcekey="lblSchoolResource1"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlExport" runat="server" Width="90%">
                    <asp:ListItem Text="Excel" Value="Excel" meta:resourcekey="ListItemResource1"></asp:ListItem>
                    <asp:ListItem Text="PDF" Value="PDF" meta:resourcekey="ListItemResource2"></asp:ListItem>
                </asp:DropDownList>

            </td>
            <td><asp:Button ID="btnExport" runat="server" Text="Export" OnClick="btnExport_Click" Enabled="false"/></td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" Enabled="false"/>
            </td>
        </tr>
        <tr>
            <td><asp:Label ID="lblInfo" runat="server" Text="Save Success" EnableViewState="false" ForeColor="Green" Visible="false" meta:resourcekey="lblInfoResource1"></asp:Label></td>
        </tr>
    </table>
      <div style="width:80%;">
                    <asp:GridView ID="grdResult" runat="server" 
                        GridLines="Both" Width="100%" Height="300px"
                        EmptyDataText="No record to display." AutoGenerateColumns="False" 
                        ShowFooter="True" AllowSorting="true"
                        BackColor="White" BorderColor="#336666"
                        DataKeyNames="UserID" OnSorting="grdResult_Sorting"
                        BorderWidth="3px" OnRowDataBound="grdResult_RowDataBound" meta:resourcekey="grdResultResource1">
                        <RowStyle BackColor="White" ForeColor="#333333"  Font-Size="Small"/>
                        <FooterStyle BackColor="White" ForeColor="#333333"   Height="100%" />
                        <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Right" />
                        <SelectedRowStyle BackColor="#339966" Font-Bold="False" ForeColor="White" />
                        <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingHeaderStyle CssClass="arrow-up" />
                        <SortedDescendingHeaderStyle CssClass="arrow-down" />
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Label ID="lblUserID" runat="server" style="display:none;"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="0px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Furigana"  SortExpression="Furigana" meta:resourcekey="TemplateFieldResource2">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtFurigana" runat="server" Width="90%"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Palaygo ID" SortExpression="UserName" meta:resourcekey="TemplateFieldResource3">
                                <ItemTemplate>
                                    <asp:Label ID="lblUserName" runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="2016" SortExpression="Custom1" meta:resourcekey="TemplateFieldResource10">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtCustom1" runat="server" MaxLength="8" Width="90%"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="2017" SortExpression="Custom2" meta:resourcekey="TemplateFieldResource10">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtCustom2" MaxLength="8" runat="server" Width="90%"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="2018" SortExpression="Custom3" meta:resourcekey="TemplateFieldResource10">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtCustom3" MaxLength="8" runat="server" Width="90%"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Note 1" SortExpression="Note1" meta:resourcekey="TemplateFieldResource10">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtNote1" runat="server" Width="90%" TextMode="MultiLine" MaxLength="50"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Note 2" SortExpression="Note2" meta:resourcekey="TemplateFieldResource10">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtNote2" runat="server" Width="90%" TextMode="MultiLine" MaxLength="50"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Note 3" SortExpression="Note3" meta:resourcekey="TemplateFieldResource11">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtNote3" runat="server" Width="90%" TextMode="MultiLine" MaxLength="50"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Note 4" SortExpression="Note4" meta:resourcekey="TemplateFieldResource12">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtNote4" runat="server" Width="90%" TextMode="MultiLine" MaxLength="50"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
</asp:Content>
