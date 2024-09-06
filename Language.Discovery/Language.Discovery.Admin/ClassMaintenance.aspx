.<%@ Page Title="" Language="C#" MasterPageFile="~/Master/AdminMaster.Master" AutoEventWireup="true" CodeBehind="ClassMaintenance.aspx.cs" Inherits="Language.Discovery.Admin.ClassMaintenance" EnableEventValidation="false" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
     <div style="width:100%;border:1px solid black;text-align:center;">
            <asp:Label ID="lblTitle" runat="server" Text="Class Maintenance" meta:resourcekey="lblTitleResource1"></asp:Label>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <div>
        <asp:HiddenField ID="hdnSelectSchool" runat="server" meta:resourcekey="hdnSelectSchoolResource1" />
  <table style="width:100%;">
        <tr>
            <td style="width:50%">
               
                <asp:UpdatePanel ID="upSearch" runat="server"  UpdateMode="Conditional">
                    <ContentTemplate>
                        <fieldset class="fieldset">
                            <legend>
                                <asp:Label ID="lblLegend" runat="server" Text="Search" meta:resourcekey="lblLegendResource1"></asp:Label></legend>
                             <table>
                                <tr>
                                    <td><asp:Label ID="lblSearchType" runat="server" meta:resourcekey="lblSearchTypeResource1">Class</asp:Label></td>
                                    <td><asp:TextBox ID="txtSearchClass" runat="server" meta:resourcekey="txtSearchClassResource1"></asp:TextBox></td>
                                    <td><asp:DropDownList ID="ddlSearchSchool" runat="server" meta:resourcekey="ddlSearchSchoolResource1"></asp:DropDownList></td>
                                    <td><asp:Button ID="btnSearch" runat="server" Text="Search" 
                                    OnClick="btnSearch_Click" meta:resourcekey="btnSearchResource1" /></td>
                                </tr>
                            </table>
        
                            <asp:GridView ID="grdResult" runat="server" DataKeyNames="ClassID"
                                    GridLines="Horizontal" Width="80%" Height="200px"
                                    EmptyDataText="No record to display." AutoGenerateColumns="False" AllowPaging="True" 
                                    onpageindexchanging="grdResult_PageIndexChanging"
                                    onrowdatabound="grdResult_RowDataBound" 
                                    onselectedindexchanged="grdResult_SelectedIndexChanged" ShowFooter="True"
                                    BackColor="White" BorderColor="#336666"
                                    BorderWidth="3px" meta:resourcekey="grdResultResource1">
                                    <PagerSettings Mode="NumericFirstLast" />
                                    <RowStyle BackColor="White" ForeColor="#333333"  Font-Size="Small"/>
                                    <FooterStyle BackColor="White" ForeColor="#333333"   Height="100%" />
                                    <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Right" />
                                    <SelectedRowStyle BackColor="#339966" Font-Bold="False" ForeColor="White" />
                                    <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                                    <Columns>
                                        <asp:BoundField DataField="ClassName" HeaderText="Class" meta:resourcekey="BoundFielClassNamedResource1" >
                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                        </asp:BoundField>
                                    </Columns>
                                </asp:GridView>
                        </fieldset>
                    </ContentTemplate>  
                </asp:UpdatePanel>
                 <br />
                <asp:UpdatePanel ID="upDetail" runat="server"  UpdateMode="Conditional">
                    <ContentTemplate>
                        <fieldset>
                            <legend>
                                <asp:Label ID="lblDataEntryLegend" runat="server" Text="Data Entry" meta:resourcekey="lblDataEntryLegendResource1"></asp:Label></legend>
                            <table>
                                <tr>
                                    <td><asp:Label ID="lblSchool" runat="server" meta:resourcekey="lblSchoolResource1">School</asp:Label></td>
                                    <td><asp:DropDownList ID="ddlSchool" runat="server" meta:resourcekey="ddlSchoolResource1"></asp:DropDownList>
                                        <asp:CompareValidator ID="cvschool" ClientIDMode="Static" runat="server" ErrorMessage="School is required." ControlToValidate="ddlSchool" ValueToCompare="0" Operator="NotEqual" ValidationGroup="v" ForeColor="Red" meta:resourcekey="cvschoolResource1" >*</asp:CompareValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td><asp:Label ID="lblClass" runat="server" meta:resourcekey="lblClassResource1">Class</asp:Label></td>
                                     <td><asp:TextBox ID="txtClass" runat="server" Width="560px" meta:resourcekey="txtClassResource1"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Class is required" ControlToValidate="txtClass" ValidationGroup="v" ForeColor="Red" meta:resourcekey="RequiredFieldValidator2Resource1">*</asp:RequiredFieldValidator>
                                     </td>   
                                </tr>
                            </table>

                            <asp:Label ID="lblMessage" runat="server" Visible="False" EnableViewState="False" Text="Action Error." meta:resourcekey="lblMessageResource1"></asp:Label><br />
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="v" ForeColor="Red" BorderStyle="Solid" BorderWidth="1px" HeaderText="Please Check your inputs." meta:resourcekey="ValidationSummary1Resource1" />

                            <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" ValidationGroup="v" meta:resourcekey="btnSaveResource1" />
                            <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click" meta:resourcekey="btnClearResource1" />
                            <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete?');" OnClick="btnDelete_Click" meta:resourcekey="btnDeleteResource1"
                                 />
                            </fieldset>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
          
        </tr>
    </table>
    </div>
</asp:Content>
