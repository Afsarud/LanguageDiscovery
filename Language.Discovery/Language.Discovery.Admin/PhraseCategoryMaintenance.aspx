<%@ Page Title="" Language="C#" MasterPageFile="~/Master/AdminMaster.Master" AutoEventWireup="true" CodeBehind="PhraseCategoryMaintenance.aspx.cs" Inherits="Language.Discovery.Admin.PhraseCategoryMaintenance" EnableEventValidation="false" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
     <div style="width:100%;border:1px solid black;text-align:center;">
        <asp:Label ID="lblTitle" runat="server" Text="Category Maintenance" meta:resourcekey="lblTitleResource1"></asp:Label>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
    <style>
         #sortable { list-style-type:decimal-leading-zero; margin: 0; padding: 0;  }
        #sortable li { margin: 0 3px 3px 3px; padding: 0.4em; padding-left: 1.5em; font-size:small; height: 12px; }
        /* #sortable li span { position: absolute; margin-left: -1.3em; }
         .sortable-placeholder {display: none;}*/
    </style>
    <script>
      

        function Sortable() {
            $('ol').sortable({ placeholder: "ui-state-highlight" });
        }
        
        function GetNewOrder() {
            var result = $('ol').sortable("toArray");
            $('#hdnNewOrder').val(result.toString());
        }
    </script>
    <asp:HiddenField ID="hdnNewOrder" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdnSelectSchool" runat="server" meta:resourcekey="hdnSelectSchoolResource1" />
    <asp:HiddenField ID="hdnAll" runat="server" meta:resourcekey="hdnAllResource1" />
    <table style="width:100%;">
        <tr>
            <td style="width:50%">
                <asp:UpdatePanel ID="upSearch" runat="server"  UpdateMode="Conditional">
                    <ContentTemplate>
                       <fieldset class="fieldset">
                            <asp:HiddenField ID="hdnPhraseCategoryHeaderID" runat="server" />
                            <legend><asp:Label ID="lblLegend" runat="server" Text="Search" meta:resourcekey="lblLegendResource1"></asp:Label></legend>
                             <table>
                                <tr>
                                    <td><asp:Label ID="lblSearchLanguage" runat="server" meta:resourcekey="lblSearchLanguageResource1">Language</asp:Label></td>
                                    <td><asp:DropDownList ID="ddlSearchLanguage" runat="server" meta:resourcekey="ddlSearchLanguageResource1"></asp:DropDownList></td>
                                    <td><asp:Label ID="lblSearchLevel" runat="server" meta:resourcekey="lblSearchLevelResource1">Level</asp:Label></td>
                                    <td><asp:DropDownList ID="ddlSearchLevel" runat="server" meta:resourcekey="ddlSearchLevelResource1"></asp:DropDownList></td>
                                    <td><asp:Label ID="lblTopCategorySearch" runat="server" meta:resourcekey="lblTopCategoryResource1">Top Category</asp:Label></td>
                                    <td><asp:DropDownList ID="ddlSearchTopCategory" runat="server"></asp:DropDownList></td>
                                </tr>
                                 <tr>
                                    <td><asp:Label ID="lblSearchSchool" runat="server" meta:resourcekey="lblSearchSchoolResource1">School</asp:Label></td>
                                    <td><asp:DropDownList ID="ddlSearchSchool" runat="server" meta:resourcekey="ddlSearchSchoolResource1"></asp:DropDownList></td>
                                    <td><asp:Label ID="lblCategory" runat="server" meta:resourcekey="lblCategoryResource1">Category</asp:Label></td>
                                    <td><asp:TextBox ID="txtSearchCategory" runat="server" meta:resourcekey="txtSearchCategoryResource1"></asp:TextBox></td>
                                    <td><asp:Button ID="btnSearch" runat="server" Text="Search" 
                                    OnClick="btnSearch_Click" meta:resourcekey="btnSearchResource1" /></td>
                                 </tr>
                            </table>
        
                            <asp:GridView ID="grdResult" runat="server" DataKeyNames="PhraseCategoryID"
                                    GridLines="Horizontal" Width="80%" Height="300px"
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
                                        <asp:TemplateField  ShowHeader="False" meta:resourcekey="TemplateFieldResource1" >
                                            <ItemTemplate>
                                                <asp:HiddenField ID="hdnSearchPhraseCategoryHeaderID" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"GroupID").ToString() %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="PhraseCategoryCode" HeaderText="Category" meta:resourcekey="BoundFieldResource1" >
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
                                    <td><asp:Label ID="lblTopCategory" runat="server" meta:resourcekey="lblTopCategoryResource1">Top Category</asp:Label></td>
                                    <td><asp:DropDownList ID="ddlTopCategory" runat="server" meta:resourcekey="ddlTopCategoryResource1"></asp:DropDownList></td>
                                </tr>
                                <tr>
                                    <td><asp:Label ID="lblSchool" runat="server" meta:resourcekey="lblSchoolResource1">School</asp:Label></td>
                                    <td><asp:DropDownList ID="ddlSchool" runat="server" meta:resourcekey="ddlSchoolResource1"></asp:DropDownList></td>
                                </tr>
                                <tr>
                                    <td><asp:Label ID="lblLevel" runat="server" meta:resourcekey="lblLevelResource1">Level</asp:Label></td>
                                    <td><asp:DropDownList ID="ddlLevel" runat="server" meta:resourcekey="ddlLevelResource1"></asp:DropDownList></td>
                                </tr>
                                <tr>
                                    <td><asp:Label ID="lblEnglish" runat="server" meta:resourcekey="lblEnglishResource1">English</asp:Label></td>
                                    <td><asp:TextBox ID="txtEnglish" runat="server" Width="402px" meta:resourcekey="txtEnglishResource1"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="English is required" ControlToValidate="txtEnglish" ValidationGroup="v" meta:resourcekey="RequiredFieldValidator1Resource1">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td><asp:Label ID="lblHideInScheduler" runat="server" meta:resourcekey="lblHideInSchedulerResource1">Hide in Scheduler</asp:Label></td>
                                    <td><asp:CheckBox ID="chkHideInScheduler" runat="server" Text="" /></td>
                                </tr>
                            </table>
                        <fieldset style="border:1px solid black;">
                                <legend><asp:Label ID="lblTranslationLegend" runat="server" Text="Translation" meta:resourcekey="lblTranslationLegendResource1"></asp:Label></legend>
                            <table>
                                <tr>
                                    <td><asp:Label ID="lblLanguage" runat="server" Text="Language" meta:resourcekey="lblLanguageResource1"></asp:Label></td>
                                    <td><asp:DropDownList ID="ddlLanguage" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlLanguage_SelectedIndexChanged"></asp:DropDownList></td>
                                </tr>
                                <tr><td colspan="2" style="height:20px;"></td></tr>
                                <tr>
                                    <td><asp:Label ID="lblHiragana" runat="server" meta:resourcekey="lblHiraganaResource1">Japanese</asp:Label></td>
                                    <td><asp:TextBox ID="txtHiragana" runat="server" Width="402px" meta:resourcekey="txtHiraganaResource1"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Japanese is required" ControlToValidate="txtHiragana" ValidationGroup="v" meta:resourcekey="RequiredFieldValidator3Resource1" Enabled="False">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td><asp:Label ID="lblKanji" runat="server" meta:resourcekey="lblKanjiResource1">Kanji</asp:Label></td>
                                    <td><asp:TextBox ID="txtKanji" runat="server" Width="402px" meta:resourcekey="txtKanjiResource1"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td><asp:Label ID="lblRomanji" runat="server" meta:resourcekey="lblRomanjiResource1">Romanji</asp:Label></td>
                                    <td><asp:TextBox ID="txtRomanji" runat="server" Width="402px" meta:resourcekey="txtRomanjiResource1"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td><asp:Label ID="lblFolderName" runat="server" meta:resourcekey="lblFolderNameResource1">Folder Name</asp:Label></td>
                                    <td><asp:TextBox ID="txtFolderName" runat="server" Width="402px" meta:resourcekey="txtFolderNameResource1"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                    <fieldset style="border:inset 1px solid;">
                                        <legend>Demo Settings</legend>
                                        <asp:CheckBox ID="chkIsDemo" runat="server" Text="Demo" /><br />
                                        <asp:CheckBox ID="chkDisplayInUI" runat="server" Text="Display in UI" />
                                    </fieldset>

                                    </td>
                                </tr>
                            </table>
                        </fieldset>
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
            <td style="width:50%">
                <asp:UpdatePanel ID="upOrder" runat="server"  UpdateMode="Conditional">
                    <ContentTemplate>
                        <fieldset>
                            <legend><asp:Label ID="lblSorter" runat="server" Text="Sorter" meta:resourcekey="lblSorterResource1"></asp:Label></legend>
                            <div style="overflow:scroll;height:700px;">
                                <asp:Repeater ID="rptCategory" runat="server">
                                    <HeaderTemplate>
                                        <ol id="sortable" style="margin-left:100px;width:300px;margin-top:50px;">
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <li class="ui-state-default" id='<%# Eval("GroupID") %>'>
                                            <asp:HiddenField ID="hdnPhraseCategoryHeaderID" runat="server" Value='<%# Eval("GroupID") %>' />
                                            <asp:Label ID="lblCategory" runat="server" Text='<%# Eval("PhraseCategoryCode") %>' meta:resourcekey="lblCategoryResource2"></asp:Label>
                                        </li>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        </ol>
                                    </FooterTemplate>
                                </asp:Repeater>
                            </div>
                             <asp:Button ID="btnUpdateOrder" runat="server" Text="Save Order" OnClick="btnUpdateOrder_Click" OnClientClick="GetNewOrder();" meta:resourcekey="btnUpdateOrderResource1" />
                            </fieldset>
                </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
</asp:Content>
