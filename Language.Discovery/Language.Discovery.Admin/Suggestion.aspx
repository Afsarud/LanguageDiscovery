<%@ Page Title="" Language="C#" MasterPageFile="~/Master/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Suggestion.aspx.cs" Inherits="Language.Discovery.Admin.Suggestion" EnableEventValidation="false" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" ValidateRequest="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
 <div style="width:100%;border:1px solid black;text-align:center;">
            <asp:Label ID="lblTitle" runat="server" Text="Topic Update Tool" meta:resourcekey="lblTitleResource1"></asp:Label>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
     <script>
         function InitializeDate() {
             $("#txtSearchStartDate").datepicker({
                     dateFormat: 'dd/mm/yy',
                     defaultDate: "+1w",
                     changeMonth: true,
                     numberOfMonths: 1,
                     onClose: function (selectedDate) {
                         $("#txtSearchEndDate").datepicker("option", "minDate", selectedDate);
                     }
                 });
             $("#txtSearchEndDate").datepicker({
                 dateFormat: 'dd/mm/yy',
                     defaultDate: "+1w",
                     changeMonth: true,
                     numberOfMonths: 1,
                     onClose: function (selectedDate) {
                         $("#txtSearchStartDate").datepicker("option", "maxDate", selectedDate);
                     }
                 });
             $("#txtStartDate").datepicker({
                 dateFormat: 'dd/mm/yy',
                     defaultDate: "+1w",
                     changeMonth: true,
                     numberOfMonths: 1,
                     onClose: function (selectedDate) {
                         $("#txtEndDate").datepicker("option", "minDate", selectedDate);
                     }
                 });
             $("#txtEndDate").datepicker({
                 dateFormat: 'dd/mm/yy',
                     defaultDate: "+1w",
                     changeMonth: true,
                     numberOfMonths: 1,
                     onClose: function (selectedDate) {
                         $("#txtStartDate").datepicker("option", "maxDate", selectedDate);
                     }
                 });
         }

         function ConfirmDelete() {
             var s = $('#hdnPaletteSuggestionID').val();
             var result = false;

             if (s.length > 0) {
                 {
                     res = confirm("Are you sure you want to delete this record?");
                 }
             }
             else {
                 alert('Nothing to delete.');
             }
             return result;
         }
  </script>
    <table>
        <tr>
            <td>
                 <asp:UpdatePanel ID="upSearch" runat="server"  UpdateMode="Conditional">
                    <ContentTemplate>
                        <fieldset class="fieldset">
                             <asp:HiddenField ID="hdnAll" runat="server" meta:resourcekey="hdnAllResource1" />
                            <asp:HiddenField ID="hdnWordHeaderID" runat="server" />
                            <legend>
                                <asp:Label ID="lblSearchLegend" runat="server" Text="Search" meta:resourcekey="lblSearchLegendResource1"></asp:Label></legend>
                                <table>
                                <tr>
                                    <td><asp:Label ID="lblSearchText" runat="server" meta:resourcekey="lblSearchTextResource1">Word/Keyword</asp:Label></td>
                                    <td><asp:TextBox ID="txtWordKeywordName" runat="server" meta:resourcekey="txtWordKeywordNameResource1"></asp:TextBox></td>
                                    <td style="width:50px;"><asp:Label ID="lblSearchStartDate" runat="server" meta:resourcekey="lblSearchStartDateResource1">Start Date</asp:Label></td>
                                    <td><asp:TextBox ID="txtSearchStartDate" runat="server" ClientIDMode="Static" meta:resourcekey="txtSearchStartDateResource1"></asp:TextBox>
                                          <asp:RegularExpressionValidator ID="RegularExpressionValidator3" ControlToValidate = "txtSearchStartDate" ValidationGroup="s" ForeColor="Red"
                                                ValidationExpression = "^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$"
                                                runat="server" ErrorMessage="Invalid Start Date format. Valid Date Format dd/MM/yyyy" meta:resourcekey="RegularExpressionValidator3Resource1">*
                                                </asp:RegularExpressionValidator>

                                    </td>
                                    <td style="width:50px;"><asp:Label ID="lblSearchEndDate" runat="server" meta:resourcekey="lblSearchEndDateResource1">End Date</asp:Label></td>
                                    <td><asp:TextBox ID="txtSearchEndDate" runat="server" ClientIDMode="Static" meta:resourcekey="txtSearchEndDateResource1"></asp:TextBox>
                                          <asp:RegularExpressionValidator ID="RegularExpressionValidator4" ControlToValidate = "txtSearchEndDate" ValidationGroup="s" ForeColor="Red"
                                                ValidationExpression = "^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$"
                                                runat="server" ErrorMessage="Invalid End Date format. Valid Date Format dd/MM/yyyy" meta:resourcekey="RegularExpressionValidator4Resource1">*
                                                </asp:RegularExpressionValidator>

                                    </td>
                                </tr>
                                    <tr>
                                    <td><asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click"  ValidationGroup="s" meta:resourcekey="btnSearchResource1"/></td>

                                    </tr>
                            </table>
                                <asp:ValidationSummary ID="ValidationSummary2" runat="server"  ValidationGroup="s" HeaderText="Please review your inputs." ForeColor="Red" BorderWidth="1px" BorderStyle="Solid" meta:resourcekey="ValidationSummary2Resource1" />
                            <asp:GridView ID="grdResult" runat="server" DataKeyNames="PaletteSuggestionID,PaletteID"
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
                                        <asp:TemplateField HeaderText="Sentence" meta:resourcekey="TemplateFieldResource1" >
                                            <ItemTemplate>
                                                <asp:Label ID="lblSentence1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Sentence1").ToString() %>' meta:resourcekey="lblSentence1Resource1"></asp:Label> <br />
                                                <asp:Label ID="lblSentence2" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Sentence2").ToString() %>' meta:resourcekey="lblSentence2Resource1"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="StartDate" HeaderText="Start Date" DataFormatString="{0:dd/MM/yyyy}" meta:resourcekey="BoundFieldResource1" >
                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="EndDate" HeaderText="End Date" DataFormatString="{0:dd/MM/yyyy}" meta:resourcekey="BoundFieldResource2" >
                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                        </asp:BoundField>
                                    </Columns>
                                </asp:GridView>
                        </fieldset>
                    </ContentTemplate>  
                </asp:UpdatePanel>
             </td>
                     <td rowspan="3">
                 <asp:UpdatePanel ID="UpdatePanel2" runat="server"  UpdateMode="Conditional">
                    <ContentTemplate>
                        <fieldset class="fieldset">
                            <legend><asp:Label ID="lblDataEntryLegend" runat="server" Text="Data Entry" meta:resourcekey="lblDataEntryLegendResource1"></asp:Label></legend>     
                            <asp:HiddenField ID="hdnPaletteSuggestionID" runat="server" ClientIDMode="Static" />
                            <asp:TextBox ID="txtPaletteID" runat="server" style="display:none;" meta:resourcekey="txtPaletteIDResource1"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Palette is required" ControlToValidate="txtPaletteID" ValidationGroup="v" ForeColor="Red" Display="Dynamic" meta:resourcekey="RequiredFieldValidator3Resource1">*</asp:RequiredFieldValidator>

                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblStartDateLabel" runat="server" Text="Start Date" AssociatedControlID="txtStartDate" meta:resourcekey="lblStartDateLabelResource1"></asp:Label>
                                        <asp:TextBox ID="txtStartDate" ClientIDMode="Static" runat="server" meta:resourcekey="txtStartDateResource1"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Start Date is required" ControlToValidate="txtStartDate" ValidationGroup="v" ForeColor="Red" Display="Dynamic" meta:resourcekey="RequiredFieldValidator1Resource1">*</asp:RequiredFieldValidator>
                                          <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate = "txtStartDate" ValidationGroup="v" ForeColor="Red"
                                                ValidationExpression = "^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$"
                                                runat="server" ErrorMessage="Invalid Start Date format. Valid Date Format dd/MM/yyyy" meta:resourcekey="RegularExpressionValidator1Resource1">*
                                                </asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblEndDateLabel" runat="server" Text="End Date" AssociatedControlID="txtEndDate" meta:resourcekey="lblEndDateLabelResource1"></asp:Label>
                                        <asp:TextBox ID="txtEndDate" ClientIDMode="Static" runat="server" meta:resourcekey="txtEndDateResource1"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="End Date is required" ControlToValidate="txtEndDate" ValidationGroup="v" ForeColor="Red" Display="Dynamic" meta:resourcekey="RequiredFieldValidator2Resource1">*</asp:RequiredFieldValidator>
                                          <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ControlToValidate = "txtEndDate" ValidationGroup="v" ForeColor="Red"
                                                ValidationExpression = "^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$"
                                                runat="server" ErrorMessage="Invalid End Date format. Valid Date Format dd/MM/yyyy" meta:resourcekey="RegularExpressionValidator2Resource1">*
                                                </asp:RegularExpressionValidator>
                                    </td>

                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblFreeTextLabel" runat="server" Text="Phrase" meta:resourcekey="lblFreeTextLabelResource1"></asp:Label><br />
                                        <asp:TextBox ID="txtFreeText" runat="server" TextMode="MultiLine" Height="100px"  Width="577px" Enabled="False" meta:resourcekey="txtFreeTextResource1"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblTranslationLabel" runat="server" Text="Translation" meta:resourcekey="lblTranslationLabelResource1"></asp:Label><br />
                                        <asp:TextBox ID="txtTranslation" runat="server" TextMode="MultiLine" Height="100px"  Width="577px" Enabled="False" meta:resourcekey="txtTranslationResource1"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:CheckBox ID="chkActive" Text="Activate/Deactivate" runat="server" Visible="False" meta:resourcekey="chkActiveResource1" />
                                    </td>
                                </tr>
                            </table>                       

                            <asp:ValidationSummary ID="ValidationSummary1" runat="server"  ValidationGroup="v" HeaderText="Please review your inputs." ForeColor="Red" BorderWidth="1px" BorderStyle="Solid" meta:resourcekey="ValidationSummary1Resource1" />
                            <asp:Label ID="lblMessage" runat="server" Visible="False" EnableViewState="False" Text="Action Error." meta:resourcekey="lblMessageResource1"></asp:Label><br />

                            <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" ValidationGroup="v" meta:resourcekey="btnSaveResource1" />
                            <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click" meta:resourcekey="btnClearResource1" />
                            <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click" OnClientClick="return ConfirmDelete();" meta:resourcekey="btnDeleteResource1"/>

                        </fieldset>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td>
        <asp:UpdatePanel ID="upPaletteSearch" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <fieldset class="fieldset">
                    <asp:HiddenField ID="hdnPaletteID" runat="server" />
                    <legend>
                        <asp:Label ID="lblSearchLegend2" runat="server" Text="Search" meta:resourcekey="lblSearchLegend2Resource1"></asp:Label></legend>
                        <table>
                    
                        <tr>
                            <td><asp:Label ID="lblSearchLevel" runat="server" meta:resourcekey="lblSearchLevelResource1">Level</asp:Label></td>
                            <td><asp:DropDownList ID="ddlSearchLevel" runat="server" meta:resourcekey="ddlSearchLevelResource1"></asp:DropDownList></td>
                            <td><asp:Label ID="lblCategory" runat="server" meta:resourcekey="lblCategoryResource1">Category</asp:Label></td>
                            <td><asp:DropDownList ID="ddlSearchCategory" runat="server" meta:resourcekey="ddlSearchCategoryResource1"></asp:DropDownList></td>
                        </tr>
                            <tr>
                            <td><asp:Label ID="lblSearchSchool" runat="server" meta:resourcekey="lblSearchSchoolResource1">School</asp:Label></td>
                            <td><asp:DropDownList ID="ddlSearchSchool" runat="server" meta:resourcekey="ddlSearchSchoolResource1"></asp:DropDownList></td>
                            <td><asp:Label ID="lblWord" runat="server" meta:resourcekey="lblWordResource1">Word/Keyword</asp:Label></td>
                            <td><asp:TextBox ID="txtSearchWord" runat="server" meta:resourcekey="txtSearchWordResource1"></asp:TextBox></td>
                            <td><asp:Button ID="btnPaletteSearch" runat="server" Text="Search" 
                            OnClick="btnPaletteSearch_Click" meta:resourcekey="btnPaletteSearchResource1"/></td>
                            </tr>
                    </table>
        
                    <asp:GridView ID="grdPalette" runat="server" DataKeyNames="PaletteID"
                            GridLines="Horizontal" Width="80%" Height="300px"
                            EmptyDataText="No record to display." AutoGenerateColumns="False" AllowPaging="True" 
                            onpageindexchanging="grdPalette_PageIndexChanging"
                            onrowdatabound="grdPalette_RowDataBound" 
                            onselectedindexchanged="grdPalette_SelectedIndexChanged" 
                            OnRowCommand="grdPalette_RowCommand"
                            ShowFooter="True" AllowCustomPaging="True"
                            BackColor="White" BorderColor="#336666" 
                            BorderWidth="3px" meta:resourcekey="grdPaletteResource1">
                            <PagerSettings Mode="NumericFirstLast" />
                            <RowStyle BackColor="White" ForeColor="#333333"  Font-Size="Small"/>
                            <FooterStyle BackColor="White" ForeColor="#333333"   Height="100%" />
                            <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Right" />
                            <SelectedRowStyle BackColor="#339966" Font-Bold="False" ForeColor="White" />
                            <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                            <Columns>
                                <asp:TemplateField HeaderText="Sentence" meta:resourcekey="TemplateFieldResource2" >
                                    <ItemTemplate>
                                        <asp:Label ID="lblSentence1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Sentence1").ToString() %>' meta:resourcekey="lblSentence1Resource2"></asp:Label> <br />
                                        <asp:Label ID="lblSentence2" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Sentence2").ToString() %>' meta:resourcekey="lblSentence2Resource2"></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Left" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Add as Topic" meta:resourcekey="TemplateFieldResource3" >
                                    <ItemTemplate>
                                        <asp:Button ID="btnSelect" runat="server" Text="Add >>" CommandName="Add" OnClick="btnSelect_Click" meta:resourcekey="btnSelectResource1" />
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Left" />
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                </fieldset>
            </ContentTemplate>  
        </asp:UpdatePanel>
            </td>
   
        </tr>
    </table>

</asp:Content>
