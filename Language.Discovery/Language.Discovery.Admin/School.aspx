
<%@ Page Title="" Language="C#" MasterPageFile="~/Master/AdminMaster.Master" AutoEventWireup="true" CodeBehind="School.aspx.cs" Inherits="Language.Discovery.Admin.School" EnableEventValidation="false" maintainScrollPositionOnPostback="true" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
         <div style="width:100%;border:1px solid black;text-align:center;">
            <asp:Label ID="lblTitle" runat="server" Text="School Settings" meta:resourcekey="lblTitleResource1"></asp:Label>
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <script src="../Scripts/jquery-1.8.2.js"></script>
    <script type="text/javascript">
        jQuery.fn.ForceNumericOnly =
            function()
            {
                return this.each(function()
                {
                    $(this).keydown(function(e)
                    {
                        var key = e.charCode || e.keyCode || 0;
                        // allow backspace, tab, delete, arrows, numbers and keypad numbers ONLY
                        // home, end, period, and numpad decimal
                        return (
                            key == 8 || 
                            key == 9 ||
                            key == 46 ||
                            key == 110 ||
                            key == 190 ||
                            (key >= 35 && key <= 40) ||
                            (key >= 48 && key <= 57) ||
                            (key >= 96 && key <= 105));
                    });
                });
            };

        $(function()
        {
            $('#txtLicense').ForceNumericOnly();
            $('#txtStartTime').ForceNumericOnly();
            $('#txtEndTime').ForceNumericOnly();
            $('#txtSchoolPallete').ForceNumericOnly();
            //$('#txtAfterSchool').ForceNumericOnly();
        });
        $(function () {
            $('body').on("change", '#chkSendPasswordToTeacher', function () {
                debugger;
                if (this.checked) 
                    ValidatorEnable(document.getElementById('rfvEmail'), true);
                else
                    ValidatorEnable(document.getElementById('rfvEmail'), false);
            });
        });
    </script>
        <asp:UpdatePanel ID="upSearch" runat="server"  UpdateMode="Conditional">
        <ContentTemplate>
           <fieldset class="fieldset">
               <asp:HiddenField ID="hdnSelectSchool" runat="server" meta:resourcekey="hdnSelectSchoolResource1" />
                <asp:HiddenField ID="hdnSchoolHeaderID" runat="server" />
                <asp:HiddenField ID="hdnSelectCountry" runat="server" meta:resourcekey="hdnSelectCountryResource1" />
               <asp:HiddenField ID="hdnSelectLevel" runat="server" meta:resourcekey="hdnSelectLevelResource1" />
               <asp:HiddenField ID="hdnAll" runat="server" meta:resourcekey="hdnAllResource1" />

                <legend>
                    <asp:Label ID="lblSearchLegend" runat="server" Text="Search" meta:resourcekey="lblSearchLegendResource1"></asp:Label></legend>
                 <table>
                    <tr>
                        <td><asp:Label ID="lblSearchSchoolLabel" runat="server" meta:resourcekey="lblSearchSchoolLabelResource1">School</asp:Label></td>
                        <td><asp:DropDownList ID="ddlSearchSchool" runat="server" meta:resourcekey="ddlSearchSchoolResource1"></asp:DropDownList></td>
                        <td><asp:Label ID="lblSearchSchoolCode" runat="server" meta:resourcekey="lblSearchSchoolCodeResource1">School Code</asp:Label></td>
                        <td><asp:TextBox ID="txtSearchSchoolCode" runat="server" meta:resourcekey="txtSearchSchoolCodeResource1"></asp:TextBox></td>
                        <td><asp:Label ID="lblSearchEnglishName" runat="server" meta:resourcekey="lblSearchEnglishNameResource1">English Name</asp:Label></td>
                        <td><asp:TextBox ID="txtSearchEnglishName" runat="server" meta:resourcekey="txtSearchEnglishNameResource1"></asp:TextBox></td>
                        <td><asp:Label ID="lblSearchJapaneseName" runat="server" meta:resourcekey="lblSearchJapaneseNameResource1">Japanese Name</asp:Label></td>
                        <td><asp:TextBox ID="txtSearchJapaneseName" runat="server" meta:resourcekey="txtSearchJapaneseNameResource1"></asp:TextBox></td>
                        <td><asp:Label ID="lblSearchCountry" runat="server" meta:resourcekey="lblSearchCountryResource1">Country</asp:Label></td>
                        <td><asp:DropDownList ID="ddlSearchCountry" runat="server" meta:resourcekey="ddlSearchCountryResource1"></asp:DropDownList></td>
                    </tr>
                     <tr>
                        <td><asp:Button ID="btnSearch" runat="server" Text="Search" 
                        OnClick="btnSearch_Click" meta:resourcekey="btnSearchResource1" /></td>

                     </tr>
                </table>
        
                <asp:GridView ID="grdResult" runat="server" 
                        GridLines="Horizontal" Width="80%" Height="300px"
                        EmptyDataText="No record to display." AutoGenerateColumns="False" AllowPaging="True" 
                        onpageindexchanging="grdResult_PageIndexChanging"
                        onrowdatabound="grdResult_RowDataBound" 
                        onselectedindexchanged="grdResult_SelectedIndexChanged" ShowFooter="True" 
                        BackColor="White" BorderColor="#336666" AllowCustomPaging="True"
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
                                    <asp:HiddenField ID="hdnSearchSchoolHeaderID" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"SchoolID").ToString() %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="SchoolCode" HeaderText="School Code" meta:resourcekey="BoundFieldResource1" >
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="Name1" HeaderText="English Name" meta:resourcekey="BoundFieldResource2" >
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="Name2" HeaderText="Japanese Name" meta:resourcekey="BoundFieldResource3" >
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="CountryName" HeaderText="Country Name" meta:resourcekey="BoundFieldResource4" >
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="CreateDate" HeaderText="Create Date" meta:resourcekey="BoundFieldResource5" >
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
                        <td><asp:Label ID="lblSchoolCode" runat="server" meta:resourcekey="lblSchoolCodeResource1">School Code</asp:Label></td>
                        <td><asp:TextBox ID="txtSchoolCode" runat="server" Width="402px" meta:resourcekey="txtSchoolCodeResource1"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvSchoolCode" runat="server" ErrorMessage="School Code is required" ControlToValidate="txtSchoolCode" ValidationGroup="v" ForeColor="Red" meta:resourcekey="rfvSchoolCodeResource1">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblEnglishName" runat="server" meta:resourcekey="lblEnglishNameResource1">English Name</asp:Label></td>
                        <td><asp:TextBox ID="txtEnglishName" runat="server" Width="402px" meta:resourcekey="txtEnglishNameResource1"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvEnglishName" runat="server" ErrorMessage="English Name is required" ControlToValidate="txtEnglishName" ValidationGroup="v" ForeColor="Red" meta:resourcekey="rfvEnglishNameResource1">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblJapaneseName" runat="server" meta:resourcekey="lblJapaneseNameResource1">Japanese Name</asp:Label></td>
                        <td><asp:TextBox ID="txtJapaneseName" runat="server" Width="402px" meta:resourcekey="txtJapaneseNameResource1"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblCountry" runat="server" meta:resourcekey="lblCountryResource1">Country</asp:Label></td>
                        <td><asp:DropDownList ID="ddlCountry" runat="server" meta:resourcekey="ddlCountryResource1" OnSelectedIndexChanged="ddlCountry_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                        <asp:CompareValidator ID="cvCountry" runat="server" ErrorMessage="Country is required." ControlToValidate="ddlCountry" ValueToCompare="0" Operator="NotEqual" ValidationGroup="v" ForeColor="Red" meta:resourcekey="cvCountryResource1">*</asp:CompareValidator></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblNativeLanguage" runat="server" meta:resourcekey="lblNativeLanguageResource1">Native Language</asp:Label></td>
                        <td><asp:DropDownList ID="ddlNativeLanguage" runat="server" Enabled="false"></asp:DropDownList>
                        <asp:CompareValidator ID="CompareValidator3" runat="server" ErrorMessage="Native Language is required." ControlToValidate="ddlNativeLanguage" ValueToCompare="0" Operator="NotEqual" ValidationGroup="v" ForeColor="Red" meta:resourcekey="cvNativeLanguageResource1">*</asp:CompareValidator></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblLearningLanguage" runat="server" meta:resourcekey="lblLearningLanguageResource1">Learning Language</asp:Label></td>
                        <td><asp:DropDownList ID="ddlLearningLanguage" runat="server"></asp:DropDownList>
                        <asp:CompareValidator ID="CompareValidator4" runat="server" ErrorMessage="Learning Language is required." ControlToValidate="ddlLearningLanguage" ValueToCompare="0" Operator="NotEqual" ValidationGroup="v" ForeColor="Red" meta:resourcekey="cvLearningLanguageResource1">*</asp:CompareValidator></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblSchoolType" runat="server" meta:resourcekey="lblSchoolTypeResource1">School Type</asp:Label></td>
                        <td><asp:DropDownList ID="ddlSchoolType" runat="server" meta:resourcekey="ddlSchoolTypeResource1"></asp:DropDownList>
                        <asp:CompareValidator ID="CompareValidator2" runat="server" ErrorMessage="School Type is required." ControlToValidate="ddlSchoolType" ValueToCompare="0" Operator="NotEqual" ValidationGroup="v" ForeColor="Red" meta:resourcekey="cvSchoolTypeResource1">*</asp:CompareValidator></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblLevel" runat="server" meta:resourcekey="lblLevelResource1">Level</asp:Label></td>
                        <td><asp:DropDownList ID="ddlLevel" runat="server" meta:resourcekey="ddlLevelResource1"></asp:DropDownList>
                        <asp:CompareValidator ID="cvLevel" runat="server" ErrorMessage="Level is required." ControlToValidate="ddlLevel" ValueToCompare="0" Operator="NotEqual" ValidationGroup="v" ForeColor="Red" meta:resourcekey="cvLevelResource1">*</asp:CompareValidator></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblStudentCnt" runat="server" meta:resourcekey="lblStudentCntResource1">Number of Student Registered:</asp:Label></td>
                        <td><asp:Label ID="lblStudentCount" runat="server" meta:resourcekey="lblStudentCountResource1"></asp:Label></td>
                    </tr> 
                    <tr style="display:none;">
                        <td><asp:Label ID="lblAddress" runat="server" meta:resourcekey="lblAddressResource1">Address</asp:Label></td>
                        <td><asp:TextBox ID="txtAddress" runat="server" Width="402px" meta:resourcekey="txtAddressResource1"></asp:TextBox></td>
                    </tr>
                    <tr style="display:none;">
                        <td><asp:Label ID="lblTelephone" runat="server" meta:resourcekey="lblTelephoneResource1">Telephone</asp:Label></td>
                        <td><asp:TextBox ID="txtTelephone" runat="server" Width="402px" meta:resourcekey="txtTelephoneResource1"></asp:TextBox></td>
                    </tr>
                    <tr style="display:none;">
                        <td><asp:Label ID="lblUrl" runat="server" meta:resourcekey="lblUrlResource1">Url</asp:Label></td>
                        <td><asp:TextBox ID="txtUrl" runat="server" Width="402px" meta:resourcekey="txtUrlResource1"></asp:TextBox></td>
                    </tr>
                    <tr style="display:none;">
                        <td><asp:Label ID="lblEmail" runat="server" meta:resourcekey="lblEmailResource1">Email</asp:Label></td>
                        <td><asp:TextBox ID="txtEmail" runat="server" Width="402px" meta:resourcekey="txtEmailResource1"></asp:TextBox></td>
                    </tr>
                    <tr style="display:none;">
                        <td><asp:Label ID="lblPreparedBy" runat="server" meta:resourcekey="lblPreparedByResource1">Person in Charge</asp:Label></td>
                        <td><asp:TextBox ID="txtPreparedBy" runat="server" Width="402px" meta:resourcekey="txtPreparedByResource1"></asp:TextBox></td>
                    </tr>
                     <tr style="display:none;">
                        <td><asp:Label ID="lblLicense" runat="server" meta:resourcekey="lblLicenseResource1">License</asp:Label></td>
                        <td><asp:TextBox ID="txtLicense" runat="server" Width="402px" ClientIDMode="Static" meta:resourcekey="txtLicenseResource1"></asp:TextBox></td>
                    </tr>
                     <tr>
                        <td><asp:Label ID="lblStartTime" runat="server" meta:resourcekey="lblStartTimeResource1">Start Time</asp:Label></td>
                        <td><asp:DropDownList ID="ddlStartTime" runat="server" ClientIDMode="Static" meta:resourcekey="ddlStartTimeResource1">
                            </asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblEndTime" runat="server" meta:resourcekey="lblEndTimeResource1">End Time</asp:Label></td>
                        <td><asp:DropDownList ID="ddlEndTime" runat="server" ClientIDMode="Static" meta:resourcekey="ddlEndTimeResource1">
                            </asp:DropDownList>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Start time cannot be greater than or equal to endtime." ControlToValidate="ddlEndTime" ControlToCompare="ddlStartTime" Type="Integer" Operator="GreaterThan" ValidationGroup="v" ForeColor="Red" meta:resourcekey="CompareValidator1Resource1">*</asp:CompareValidator></td>
                    </tr> 
                    <tr>
                        <td><asp:Label ID="lblTotalTime" runat="server" meta:resourcekey="lblTotalTimeResource1">Talk Time Allocation(Minutes)</asp:Label></td>
                        <td><asp:TextBox ID="txtTotalTime" runat="server" Width="100px" TextMode="Number" ClientIDMode="Static"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td><asp:CheckBox ID="chkAfterSchool" runat="server" Text="After School Access" meta:resourcekey="chkAfterSchoolResource1"></asp:CheckBox></td>
                        <td><asp:CheckBox ID="chkAllowSameCountry" runat="server" Text="Allow Same Country" meta:resourcekey="chkAllowSameCountryResource1"></asp:CheckBox></td>
                    </tr> 
                    <tr>
                        <td><asp:CheckBox ID="ckbMailCheck" runat="server" Text="Mail Check" meta:resourcekey="ckbMailCheckResource1"></asp:CheckBox></td>
                    </tr>
                    <tr>
                            <td><asp:CheckBox ID="ckbSchoolKey" runat="server" Text="School Access" meta:resourcekey="ckbSchoolKeyResource1"></asp:CheckBox></td>
                    </tr>
                    <tr>
                        <td><asp:CheckBox ID="chkAllowTalk" runat="server" Text="Allow Talk" meta:resourcekey="chkAllowTalkResource1"></asp:CheckBox></td>
                    </tr> 
                    <tr>
                        <td><asp:CheckBox ID="chkSendPasswordToTeacher" runat="server" ClientIDMode="Static" Text="Send Password To Teacher" meta:resourcekey="chkSendPasswordToTeacherResource1"></asp:CheckBox></td>
                        <td><asp:TextBox ID="txtTeachersEmail" runat="server" Width="402px" ClientIDMode="Static"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvEmail"  ClientIDMode="Static" runat="server" ErrorMessage="Email is required" ControlToValidate="txtTeachersEmail" ValidationGroup="v" ForeColor="Red" Display="Dynamic" Enabled="False" meta:resourcekey="rfvEmailResource1">*</asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="regexEmailValid" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="txtTeachersEmail" ValidationGroup="v" ForeColor="Red" Display="Dynamic" ErrorMessage="Invalid Email Format"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td><asp:CheckBox ID="chkEnableParentInfo" runat="server" Text="Enable Parents Info" meta:resourcekey="chkEnableParentInfoResource1"></asp:CheckBox></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblLinkKey" runat="server" meta:resourcekey="lblLinkKeyResource1">Zendesk Link</asp:Label></td>
                        <td><asp:TextBox ID="txtLinkKey" runat="server" Width="100px" TextMode="Number" ClientIDMode="Static"></asp:TextBox></td>
                    </tr>

                </table>
                <fieldset style="border-color:black;">
                    <legend><asp:Label ID="lblPaletteSettings" runat="server" meta:resourcekey="lblPaletteSettingsResource1">Palette Settings</asp:Label></legend>
                    <table>
                        <tr>
                            <td><asp:Label ID="lblDefaultLanguageOrder" runat="server" meta:resourcekey="lblDefaultLanguageOrderResource1">End Time</asp:Label></td>
                            <td><asp:DropDownList ID="ddlLanguage" runat="server" ClientIDMode="Static">
                            </asp:DropDownList>
                        </tr>
                        <tr>
                            <td><asp:CheckBox ID="ckbShowPhraseOrder" runat="server" Text="Show Phrase Order" meta:resourcekey="ckbShowPhraseOrderResource1"></asp:CheckBox></td>
                        </tr> 
                        <tr>
                            <td><asp:CheckBox ID="ckbShowNativeLanguage" runat="server" Text="Show Native Language" meta:resourcekey="ckbShowNativeLanguageResource1"></asp:CheckBox></td>
                        </tr>
                        <tr>
                            <td><asp:CheckBox ID="chkShowSubLanguage2" runat="server" Text="Show Kanji" meta:resourcekey="chkShowSubLanguage2Resource1"></asp:CheckBox></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td><asp:CheckBox ID="chkShowRomanji" runat="server" Text="Show Romanji" meta:resourcekey="chkShowRomanjiResource1"></asp:CheckBox></td>
                        </tr>
                        <tr>
                            <td><asp:CheckBox ID="chkSchoolPalette" runat="server" Text="School Palette" meta:resourcekey="chkSchoolPaletteResource1"></asp:CheckBox></td>
                        </tr>
                        <tr>
                            <td><asp:CheckBox ID="chkEnableFreeMessage" runat="server" Text="Enable Free Message" meta:resourcekey="chkEnableFreeMessageResource1"></asp:CheckBox></td>
                        </tr>
                        <tr>
                            <td><asp:CheckBox ID="chkSoundAndMail" runat="server" Text="Sound And Mail/Mail Only" meta:resourcekey="chkSoundAndMailResource1"></asp:CheckBox></td>
                        </tr>
                        <tr>
                            <td><asp:CheckBox ID="chkOrderByLearningLanguage" runat="server" Text="Order By Learning Language" meta:resourcekey="chkOrderByLearningLanguageResource1"></asp:CheckBox></td>
                        </tr>
                    </table>
                </fieldset>

                <asp:Label ID="lblMessage" runat="server" Visible="False" EnableViewState="False" Text="Action Error." meta:resourcekey="lblMessageResource1"></asp:Label><br />
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="v" BorderColor="Red" BorderStyle="Solid" BorderWidth="1px" HeaderText="Please check your inputs" ForeColor="Red" meta:resourcekey="ValidationSummary1Resource1"/>
                <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" ValidationGroup="v" OnClientClick="window.scrollTo = function(x,y) { return true; };" meta:resourcekey="btnSaveResource1"  />
                <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click" meta:resourcekey="btnClearResource1" />
                <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click" meta:resourcekey="btnDeleteResource1"
                     />
                </fieldset>
            </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnSave" />
        </Triggers>
        </asp:UpdatePanel>
</asp:Content>
