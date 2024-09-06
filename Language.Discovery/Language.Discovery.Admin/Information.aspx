<%@ Page Title="" Language="C#" MasterPageFile="~/Master/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Information.aspx.cs" Inherits="Language.Discovery.Admin.Information" EnableEventValidation="false" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" ValidateRequest="false"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
     <div style="width:100%;border:1px solid black;text-align:center;">
            <asp:Label ID="lblTitle" runat="server" Text="Notice Update Tool" meta:resourcekey="lblTitleResource1"></asp:Label>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
     <table style="width:100%;">
        <tr>
            <td style="width:50%">
               
                <asp:UpdatePanel ID="upSearch" runat="server"  UpdateMode="Conditional">
                    <ContentTemplate>
                        <fieldset class="fieldset">
                            <asp:HiddenField ID="hdnPhraseCategoryHeaderID" runat="server" />
                            <legend>
                                <asp:Label ID="lblLegend" runat="server" Text="Search" meta:resourcekey="lblLegendResource1"></asp:Label></legend>
                             <table>
                                <tr>
                                    <td><asp:Label ID="lblSearchType" runat="server" meta:resourcekey="lblSearchTypeResource1">Type</asp:Label></td>
                                    <td><asp:DropDownList ID="ddlSearchType" runat="server" meta:resourcekey="ddlSearchTypeResource1">
                                        <asp:ListItem Text="All" Value="0" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                        <asp:ListItem Text="Notice" Value="Notice" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                        <asp:ListItem Text="News" Value="News" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                        </asp:DropDownList></td>
                                    <td><asp:Label ID="lblSearchActive" runat="server" meta:resourcekey="lblSearchActiveResource1">Active</asp:Label></td>
                                    <td><asp:DropDownList ID="ddlSearchActive" runat="server" meta:resourcekey="ddlSearchActiveResource1">
                                        <asp:ListItem Text="All" Value="-1" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                        <asp:ListItem Text="In Active" Value="0" meta:resourcekey="ListItemResource5"></asp:ListItem>
                                        <asp:ListItem Text="Active" Value="1" meta:resourcekey="ListItemResource6"></asp:ListItem>
                                        <asp:ListItem meta:resourcekey="ListItemResource7"></asp:ListItem>
                                        </asp:DropDownList>
                                        
                                    </td>
                                    <td><asp:Button ID="btnSearch" runat="server" Text="Search" 
                                    OnClick="btnSearch_Click" meta:resourcekey="btnSearchResource1" /></td>
                                </tr>
                            </table>
        
                            <asp:GridView ID="grdResult" runat="server" DataKeyNames="InfoID"
                                    GridLines="Horizontal" Width="80%" Height="200px"
                                    EmptyDataText="No record to display." AutoGenerateColumns="False" AllowPaging="True" 
                                    onpageindexchanging="grdResult_PageIndexChanging"
                                    onrowdatabound="grdResult_RowDataBound" 
                                    onselectedindexchanged="grdResult_SelectedIndexChanged" ShowFooter="True"
                                    BackColor="White" BorderColor="#336666"  AllowCustomPaging="True"
                                    BorderWidth="3px" meta:resourcekey="grdResultResource1">
                                    <PagerSettings Mode="NumericFirstLast" />
                                    <RowStyle BackColor="White" ForeColor="#333333"  Font-Size="Small"/>
                                    <FooterStyle BackColor="White" ForeColor="#333333"   Height="100%" />
                                    <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Right" />
                                    <SelectedRowStyle BackColor="#339966" Font-Bold="False" ForeColor="White" />
                                    <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                                    <Columns>
                                        <asp:BoundField DataField="InfoType" HeaderText="Type" meta:resourcekey="BoundFieldInfoTypeResource1" >
                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="InfoMessage" HeaderText="Message" meta:resourcekey="BoundFieldInfoMessageResource1" >
                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="IsActive" HeaderText="Active" meta:resourcekey="BoundFieldIsActiveResource1" >
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
                            <legend><asp:Label ID="lblDataEntryLegend" runat="server" Text="Data Entry" meta:resourcekey="lblDataEntryLegendResource1"></asp:Label></legend>
                            <table>
                                <tr>
                                    <td><asp:Label ID="lblType" runat="server" meta:resourcekey="lblTypeResource1">Type</asp:Label></td>
                                    <td><asp:DropDownList ID="ddlType" runat="server" meta:resourcekey="ddlTypeResource1">
                                        <asp:ListItem Text="Select Type" Value="0" meta:resourcekey="ListItemResource8"></asp:ListItem>
                                        <asp:ListItem Text="Notice" Value="Notice" meta:resourcekey="ListItemResource9"></asp:ListItem>
                                        <asp:ListItem Text="News" Value="News" meta:resourcekey="ListItemResource10"></asp:ListItem>
                                        </asp:DropDownList></td>
                                </tr>
                                <tr>
                                    <td><asp:Label ID="lblInfoMessage" runat="server" meta:resourcekey="lblInfoMessageResource1">Message</asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Height="100px" Width="560px" meta:resourcekey="txtMessageResource1"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Message is required" ControlToValidate="txtMessage" ValidationGroup="v" ForeColor="Red" meta:resourcekey="RequiredFieldValidator2Resource1">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td><asp:Label ID="lblImageFile" runat="server" meta:resourcekey="lblImageFileResource1">Image File</asp:Label></td>
                                    <td>
                                        <asp:FileUpload ID="fileUpload" runat="server" meta:resourcekey="fileUploadResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:CheckBox ID="chkActive" Text="Activate/DeActivate" runat="server" meta:resourcekey="chkActiveResource1" />
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
                        <Triggers>
                            <asp:PostBackTrigger ControlID="btnSave" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>
          
        </tr>
    </table>
</asp:Content>
