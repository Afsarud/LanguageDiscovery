<%@ Page Title="" Language="C#" MasterPageFile="~/Master/AdminMaster.Master" AutoEventWireup="true" CodeBehind="User.aspx.cs" Inherits="Language.Discovery.Admin.User" EnableEventValidation="false" maintainScrollPositionOnPostback="true" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div style="width:100%;border:1px solid black;text-align:center;">
        <asp:Label ID="lblTitle" runat="server" Text="User Settings" meta:resourcekey="lblTitleResource1"></asp:Label>
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">

    <script type="text/javascript">
        $(document).ready(function () {
            HideOtherInfo();
        });

        function HideOtherInfo() {
            $('#tblData tr').each(function () {
                $(this).find('td').each(function () {
                    if ($(this).children().length == 0)
                        $(this).parent().hide();
                });
            });

        }
        function InitializeDate() {

            $("#txtDateOfBirth").datepicker({
                dateFormat: 'dd/mm/yy',
                defaultDate: "+1w",
                changeMonth: true,
                numberOfMonths: 1
              
            });
//            $("#txtDateOfBirth").datepicker();

            ////$('#ddlUserType').change(function () {
            ////    //var usertype = $(this).val();
            ////    //InitializeValidator(usertype);
            ////});

        }
        function InitializeValidator(usertype) {

            //if (usertype == "1") //Admin
            //{
            //    ValidatorEnable(document.getElementById('rfvFirstName'), true);
            //    ValidatorEnable(document.getElementById('rfvLastName'), true);
            //    ValidatorEnable(document.getElementById('rfvTelephone'), true);
            //    ValidatorEnable(document.getElementById('rfvEmail'), true);

            //    ValidatorEnable(document.getElementById('rfvAddress'), false);
            //    ValidatorEnable(document.getElementById('rfvDateOfBirth'), false);
            //    ValidatorEnable(document.getElementById('cvClass'), false);
            //    ValidatorEnable(document.getElementById('cvCountry'), false);
            //    ValidatorEnable(document.getElementById('cvCity'), false);
            //    ValidatorEnable(document.getElementById('cvSchool'), false);
            //    ValidatorEnable(document.getElementById('cvLevel'), false);
            //    ValidatorEnable(document.getElementById('rfvTeacher'), false);
            //    ValidatorEnable(document.getElementById('rfvParentsName'), false);


            //}
            //else if (usertype == "2") //Teacher
            //{
            //    ValidatorEnable(document.getElementById('rfvFirstName'), true);
            //    ValidatorEnable(document.getElementById('rfvLastName'), true);
            //    ValidatorEnable(document.getElementById('rfvAddress'), true);
            //    ValidatorEnable(document.getElementById('rfvDateOfBirth'), true);
            //    ValidatorEnable(document.getElementById('rfvTelephone'), true);
            //    ValidatorEnable(document.getElementById('rfvEmail'), true);
            //    ValidatorEnable(document.getElementById('cvCountry'), true);
            //    ValidatorEnable(document.getElementById('cvCity'), true);
            //    ValidatorEnable(document.getElementById('cvSchool'), true);
            //    ValidatorEnable(document.getElementById('cvLevel'), true);

            //    ValidatorEnable(document.getElementById('cvClass'), false);
            //    ValidatorEnable(document.getElementById('rfvTeacher'), false);
            //    ValidatorEnable(document.getElementById('rfvParentsName'), false);
            //}
            //else if (usertype == "3") //Student
            //{
            //    ValidatorEnable(document.getElementById('rfvFirstName'), true);
            //    ValidatorEnable(document.getElementById('rfvLastName'), true);
            //    ValidatorEnable(document.getElementById('rfvAddress'), true);
            //    ValidatorEnable(document.getElementById('rfvDateOfBirth'), true);
            //    ValidatorEnable(document.getElementById('rfvTelephone'), true);
            //    ValidatorEnable(document.getElementById('rfvEmail'), true);
            //    ValidatorEnable(document.getElementById('cvCountry'), true);
            //    ValidatorEnable(document.getElementById('cvCity'), true);
            //    ValidatorEnable(document.getElementById('cvSchool'), true);
            //    ValidatorEnable(document.getElementById('cvLevel'), true);

            //    ValidatorEnable(document.getElementById('cvClass'), true);
            //    ValidatorEnable(document.getElementById('rfvTeacher'), true);
            //    ValidatorEnable(document.getElementById('rfvParentsName'), true);
            //}


        }

        

        $(function () {
        });
        //cvUserType,rfvUserName,rfvFirstName, rfvLastName, rfvAddress, rfvDateOfBirth, rfvTelephone, rfvEmail, cvClass
        //cvCountry, cvCity, cvSchool, cvLevel, rfvTeacher, rfvParentsName

        //Required for Administrator - First & Last Names, Telephone, Email, Password, Confirm Password and User Type.
 
        //Required for Teacher - First & Last Names, Address, Date of Birth, Registration Date (with date picker), 
        //Telephone, Email, Password, Confirm Password, User Type, Country, City/State, School and Level.
        //Required for Student - First & Last Names, Address, Date of Birth, Registration Date (with date picker), 
        //Telephone, Email, Password, Confirm Password, Class, User Type, Country, City/State, School, Level, Teacher and parent Names.
    </script>
    

        <asp:UpdatePanel ID="upSearch" runat="server"  UpdateMode="Conditional">
        <ContentTemplate>
           <fieldset class="fieldset">
               <asp:HiddenField ID="hdnSelectSchool" runat="server" meta:resourcekey="hdnSelectSchoolResource1" />
               <asp:HiddenField ID="hdnAll" runat="server" meta:resourcekey="hdnAllResource1" />
               <asp:HiddenField ID="hdnSelectCountry" runat="server" meta:resourcekey="hdnSelectCountryResource1" />
               <asp:HiddenField ID="hdnSelectCity" runat="server" meta:resourcekey="hdnSelectCityResource1" />
               <asp:HiddenField ID="hdnSelectClass" runat="server" meta:resourcekey="hdnSelectClassResource1" />
               <asp:HiddenField ID="hdnSelectLevel" runat="server" meta:resourcekey="hdnSelectLevelResource1" />
               <asp:HiddenField ID="hdnSelectGrade" runat="server" meta:resourcekey="hdnSelectGradeResource1" />
               <asp:HiddenField ID="hdnSelectUserType" runat="server" meta:resourcekey="hdnSelectUserTypeResource1" />
                <asp:HiddenField ID="hdnUserHeaderID" runat="server" />
                <legend><asp:Label ID="lblSearchLegend" runat="server" Text="Search" meta:resourcekey="lblSearchLegendResource1"></asp:Label></legend>
                 <table>
                    <tr>
                        <td><asp:Label ID="lblSearchSchoolLabel" runat="server" meta:resourcekey="lblSearchSchoolLabelResource1">School</asp:Label></td>
                        <td><asp:DropDownList ID="ddlSearchSchool" runat="server" meta:resourcekey="ddlSearchSchoolResource1"></asp:DropDownList></td>
                        <td><asp:Label ID="lblSearchUserNameLabel" runat="server" meta:resourcekey="lblSearchUserNameLabelResource1">User Name</asp:Label></td>
                        <td><asp:TextBox ID="txtSearchUserName" runat="server" meta:resourcekey="txtSearchUserNameResource1"></asp:TextBox></td>
                        <td><asp:Label ID="lblSearcFirstName" runat="server" meta:resourcekey="lblSearcFirstNameResource1">First Name</asp:Label></td>
                        <td><asp:TextBox ID="txtSearchFirstName" runat="server" meta:resourcekey="txtSearchFirstNameResource1"></asp:TextBox></td>
                        <td><asp:Label ID="lblSearchLastName" runat="server" meta:resourcekey="lblSearchLastNameResource1">Last Name</asp:Label></td>
                        <td><asp:TextBox ID="txtSearchLastName" runat="server" meta:resourcekey="txtSearchLastNameResource1"></asp:TextBox></td>
                    </tr>
                     <tr>
                        <td><asp:Label ID="lblSearchClass" runat="server" meta:resourcekey="lblSearchClassResource1">Class</asp:Label></td>
                        <td><asp:DropDownList ID="ddlSearchClass" runat="server" meta:resourcekey="ddlSearchClassResource1"></asp:DropDownList></td>
                        <td><asp:Label ID="lblSearchCountry" runat="server" meta:resourcekey="lblSearchCountryResource1">Country</asp:Label></td>
                        <td><asp:DropDownList ID="ddlSearchCountry" runat="server" meta:resourcekey="ddlSearchCountryResource1"></asp:DropDownList></td>
                        <td><asp:Label ID="lblSearchCity" runat="server" meta:resourcekey="lblSearchCityResource1">City</asp:Label></td>
                        <td><asp:DropDownList ID="ddlSearchCity" runat="server" meta:resourcekey="ddlSearchCityResource1"></asp:DropDownList></td>
                        <td><asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" meta:resourcekey="btnSearchResource1" /></td>
                         <td><asp:Button ID="btnGoToReport" runat="server" Text="Search" OnClick="btnGoToReport_Click"  meta:resourcekey="btnGoToReportResource1" /></td>

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
                                    <asp:HiddenField ID="hdnSearchUserHeaderID" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"UserID").ToString() %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="FirstName" HeaderText="First Name" meta:resourcekey="BoundFieldResource1" >
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="LastName" HeaderText="Last Name" meta:resourcekey="BoundFieldResource2" >
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="ClassName" HeaderText="Class Name" meta:resourcekey="BoundFieldResource3" >
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="GradeID" HeaderText="GradeID" meta:resourcekey="BoundFieldResource8" >
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="CountryName" HeaderText="Country Name" meta:resourcekey="BoundFieldResource4" >
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="CityName" HeaderText="City Name" meta:resourcekey="BoundFieldResource5" >
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="Name1" HeaderText="School Name" meta:resourcekey="BoundFieldResource6" >
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="CreateDate" HeaderText="Create Date" meta:resourcekey="BoundFieldResource7" >
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:BoundField>
                        </Columns>
                    </asp:GridView>
            </fieldset>
        </ContentTemplate>  
    </asp:UpdatePanel>
 <br />
    <asp:UpdatePanel ID="upDetail" runat="server"  UpdateMode="Conditional" >
        <ContentTemplate>
            <asp:HiddenField ID="hdnUserSchoolId" runat="server" ClientIDMode="Static" />
            <fieldset>
                <legend><asp:Label ID="lblDataEntryLegend" runat="server" Text="Data Entry" meta:resourcekey="lblDataEntryLegendResource1"></asp:Label></legend>
                <table id="tblData">
                    <tr>
                        <td><asp:Label ID="lblUserType" runat="server" meta:resourcekey="lblUserTypeResource1">User Type</asp:Label></td>
                        <td><asp:DropDownList ID="ddlUserType" runat="server" ClientIDMode="Static" AutoPostBack="True" OnSelectedIndexChanged="ddlUserType_SelectedIndexChanged" meta:resourcekey="ddlUserTypeResource1"></asp:DropDownList>
                        <asp:CompareValidator ID="cvUserType" ClientIDMode="Static" runat="server" ErrorMessage="User Type is required." ControlToValidate="ddlUserType" ValueToCompare="0" Operator="NotEqual" ValidationGroup="v" ForeColor="Red" meta:resourcekey="cvUserTypeResource1" >*</asp:CompareValidator>
                    </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblSchool" runat="server" meta:resourcekey="lblSchoolResource1">School</asp:Label></td>
                        <td><asp:DropDownList ID="ddlSchool" runat="server" OnSelectedIndexChanged="ddlSchool_SelectedIndexChanged" AutoPostBack="True" meta:resourcekey="ddlSchoolResource1"></asp:DropDownList>
                        <asp:CompareValidator ID="cvSchool"  ClientIDMode="Static" runat="server" ErrorMessage="School is required." ControlToValidate="ddlSchool" ValueToCompare="0" Operator="NotEqual" ValidationGroup="v" ForeColor="Red" Enabled="False" meta:resourcekey="cvSchoolResource1">*</asp:CompareValidator>
                            </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblLevel" runat="server" meta:resourcekey="lblLevelResource1">Level</asp:Label></td>
                        <td><asp:DropDownList ID="ddlLevel" runat="server" meta:resourcekey="ddlLevelResource1"></asp:DropDownList>
                        <asp:CompareValidator ID="cvLevel" ClientIDMode="Static"  runat="server" ErrorMessage="Level is required." ControlToValidate="ddlLevel" ValueToCompare="0" Operator="NotEqual" ValidationGroup="v" ForeColor="Red" Enabled="False" meta:resourcekey="cvLevelResource1">*</asp:CompareValidator>
                            </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblGrade" runat="server" meta:resourcekey="lblGradeResource1">Grade</asp:Label></td>
                        <td><asp:DropDownList ID="ddlGrade" runat="server" meta:resourcekey="ddlGradeResource1"></asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblGender" runat="server" meta:resourcekey="lblGenderResource1">Gender</asp:Label></td>
                        <td><asp:DropDownList ID="ddlGender" runat="server" meta:resourcekey="ddlGenderResource1">
                                <asp:ListItem Text="[Select Gender]" Value="0" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                <asp:ListItem Text="Male" Value="Male" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                <asp:ListItem Text="Female" Value="Female" meta:resourcekey="ListItemResource3"></asp:ListItem>
                            </asp:DropDownList>
                        <asp:CompareValidator ID="CompareValidator1" ClientIDMode="Static"  runat="server" ErrorMessage="Gender is required." ControlToValidate="ddlGender" ValueToCompare="0" Operator="NotEqual" ValidationGroup="v" ForeColor="Red" Enabled="False" meta:resourcekey="CompareValidator1Resource1">*</asp:CompareValidator>
                            </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblSeparator" runat="server" meta:resourcekey="lblSeparatorResource1">Separator</asp:Label></td>
                        <td><asp:DropDownList ID="ddlSeparator" runat="server">
                                <asp:ListItem Text="At sign(@)" Value="@" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="Dot(.)" Value="."></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                   <tr>
                        <td><asp:Label ID="lblUserName" runat="server" meta:resourcekey="lblUserNameResource1">User Name</asp:Label></td>
                        <td><asp:TextBox ID="txtUserName" runat="server" Width="402px" meta:resourcekey="txtUserNameResource1"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvUserName"  ClientIDMode="Static" runat="server" ErrorMessage="User Name is required" ControlToValidate="txtUserName" ValidationGroup="v" ForeColor="Red" Display="Dynamic" meta:resourcekey="rfvUserNameResource1">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblFirstName" runat="server" meta:resourcekey="lblFirstNameResource1">First Name</asp:Label></td>
                        <td><asp:TextBox ID="txtFirstName" runat="server" Width="402px" meta:resourcekey="txtFirstNameResource1"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvFirstName"  ClientIDMode="Static" runat="server" ErrorMessage="First Name is required" ControlToValidate="txtFirstName" ValidationGroup="v" ForeColor="Red" Enabled="False" meta:resourcekey="rfvFirstNameResource1">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr style="display:none;">
                        <td><asp:Label ID="lblMiddleName" runat="server" meta:resourcekey="lblMiddleNameResource1">Middle Name</asp:Label></td>
                        <td><asp:TextBox ID="txtMiddleName" runat="server" Width="402px" meta:resourcekey="txtMiddleNameResource1"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblLastName" runat="server" meta:resourcekey="lblLastNameResource1">Last Name</asp:Label></td>
                        <td><asp:TextBox ID="txtLastName" runat="server" Width="402px" meta:resourcekey="txtLastNameResource1"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvLastName"  ClientIDMode="Static" runat="server" ErrorMessage="Last Name is required" ControlToValidate="txtLastName" ValidationGroup="v" ForeColor="Red" Enabled="False" meta:resourcekey="rfvLastNameResource1">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr style="display:none;">
                        <td><asp:Label ID="lblAddress" runat="server" meta:resourcekey="lblAddressResource1">Address</asp:Label></td>
                        <td><asp:TextBox ID="txtAddress" runat="server" Width="402px" meta:resourcekey="txtAddressResource1"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvAddress" ClientIDMode="Static"  runat="server" ErrorMessage="Address is required" ControlToValidate="txtAddress" ValidationGroup="v" ForeColor="Red" Display="Dynamic" Enabled="False" meta:resourcekey="rfvAddressResource1">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr style="display:none;">
                        <td><asp:Label ID="lblDateOfBirth" runat="server" meta:resourcekey="lblDateOfBirthResource1">Date Of Birth</asp:Label></td>
                        <td><asp:TextBox ID="txtDateOfBirth" runat="server" Width="100px" ClientIDMode="Static" meta:resourcekey="txtDateOfBirthResource1"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvDateOfBirth" ClientIDMode="Static"  runat="server" ErrorMessage="Date of Birth is required" ControlToValidate="txtDateOfBirth" ValidationGroup="v" ForeColor="Red" Display="Dynamic" Enabled="False" meta:resourcekey="rfvDateOfBirthResource1">*</asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" ControlToValidate = "txtDateOfBirth" ValidationGroup="s" ForeColor="Red"
                                ValidationExpression = "^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$"
                                runat="server" ErrorMessage="Invalid Start Date format. Valid Date Format dd/MM/yyyy" meta:resourcekey="RegularExpressionValidator3Resource1">*
                                </asp:RegularExpressionValidator>

                        </td>
                    </tr>
                   <tr style="display:none;">
                        <td><asp:Label ID="lblTelephone" runat="server" meta:resourcekey="lblTelephoneResource1">Telephone</asp:Label></td>
                        <td><asp:TextBox ID="txtTelephone" runat="server" Width="402px" meta:resourcekey="txtTelephoneResource1"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvTelephone" ClientIDMode="Static"  runat="server" ErrorMessage="Telephone is required" ControlToValidate="txtTelephone" ValidationGroup="v" ForeColor="Red" Display="Dynamic" Enabled="False" meta:resourcekey="rfvTelephoneResource1">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr style="display:none;">
                        <td><asp:Label ID="lblFax" runat="server" meta:resourcekey="lblFaxResource1">Fax</asp:Label></td>
                        <td><asp:TextBox ID="txtFax" runat="server" Width="402px" meta:resourcekey="txtFaxResource1"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblPassword" runat="server" meta:resourcekey="lblPasswordResource1">Password</asp:Label></td>
                        <td><asp:TextBox ID="txtPassword" runat="server" Width="402px" meta:resourcekey="txtPasswordResource1"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ErrorMessage="Password is required" ControlToValidate="txtPassword" ValidationGroup="v" ForeColor="Red" meta:resourcekey="rfvPasswordResource1">*</asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="rfvPasswordValidator" ControlToValidate = "txtPassword" ValidationGroup="v" ForeColor="Red"
                                ValidationExpression = "^(?=.*[A-Z])^(?=.*[a-z])(?=.*\d)[A-Za-z\d]{8,}$"
                                runat="server" ErrorMessage="Password must be at least 8 characters, mix of letters(at least 1 upper case and lower case letters) and numbers." meta:resourcekey="rfvPasswordValidatorResource1">*
                                </asp:RegularExpressionValidator>
                            <asp:Button ID="btnShowPassword" runat="server" Text="Decrypt Password" Visible="true" data-text="" OnClick="btnShowPassword_Click" meta:resourcekey="btnShowPasswordResource1" />
                            <asp:Button ID="btnChangePassword" runat="server" Text="Change Password" Visible="False" OnClick="btnChangePassword_Click" meta:resourcekey="btnChangePasswordResource1" />
                            <asp:Button ID="btnCancelChangePassword" runat="server" Text="Cancel" Visible="False" OnClick="btnCancelChangePassword_Click" meta:resourcekey="btnCancelChangePasswordResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblConfirmPassword" runat="server" meta:resourcekey="lblConfirmPasswordResource1">Confirm Password</asp:Label></td>
                        <td><asp:TextBox ID="txtConfirmPassword" runat="server" Width="402px" meta:resourcekey="txtConfirmPasswordResource1"></asp:TextBox>
                            <asp:HiddenField ID="hdnPassword" runat="server" />
                            <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ErrorMessage="Confirm Password is required" ControlToValidate="txtConfirmPassword" ValidationGroup="v" ForeColor="Red" meta:resourcekey="rfvConfirmPasswordResource1" >*</asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="cvConfirmPassword" runat="server" ErrorMessage="Password not matched" ControlToValidate="txtConfirmPassword" ControlToCompare="txtPassword" ValidationGroup="v" ForeColor="Red" meta:resourcekey="cvConfirmPasswordResource1">*</asp:CompareValidator>
                        </td>
                    </tr>
                    <tr style="display:none;">
                        <td><asp:Label ID="lblPassword2" runat="server" meta:resourcekey="lblPassword2Resource1">Password2</asp:Label></td>
                        <td><asp:TextBox ID="txtPassword2" runat="server" Width="402px" meta:resourcekey="txtPassword2Resource1" ></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblClass" runat="server" meta:resourcekey="lblClassResource1">Class</asp:Label></td>
                        <td><asp:DropDownList ID="ddlClass" runat="server" meta:resourcekey="ddlClassResource1"></asp:DropDownList>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblCountry" runat="server" meta:resourcekey="lblCountryResource1">Country</asp:Label></td>
                        <td><asp:DropDownList ID="ddlCountry" runat="server" meta:resourcekey="ddlCountryResource1" Enabled="false"></asp:DropDownList>
                        <asp:CompareValidator ID="cvCountry" ClientIDMode="Static"  runat="server" ErrorMessage="Country is required." ControlToValidate="ddlCountry" ValueToCompare="0" Operator="NotEqual" ValidationGroup="v" ForeColor="Red" Enabled="False" meta:resourcekey="cvCountryResource1">*</asp:CompareValidator>
                            </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblNativeLanguage" runat="server" meta:resourcekey="lblNativeLanguageResource1">Native Language</asp:Label></td>
                        <td><asp:DropDownList ID="ddlNativeLanguage" runat="server" Enabled="false"></asp:DropDownList>
                        <asp:CompareValidator ID="CompareValidator3" runat="server" ErrorMessage="Native Language is required." ControlToValidate="ddlNativeLanguage" ValueToCompare="0" Operator="NotEqual" ValidationGroup="v" ForeColor="Red" meta:resourcekey="cvNativeLanguageResource1">*</asp:CompareValidator></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblLearningLanguage" runat="server" meta:resourcekey="lblLearningLanguageResource1">Learning Language</asp:Label></td>
                        <td><asp:DropDownList ID="ddlLearningLanguage" runat="server" Enabled="false"></asp:DropDownList>
                        <asp:CompareValidator ID="CompareValidator4" runat="server" ErrorMessage="Learning Language is required." ControlToValidate="ddlLearningLanguage" ValueToCompare="0" Operator="NotEqual" ValidationGroup="v" ForeColor="Red" meta:resourcekey="cvLearningLanguageResource1">*</asp:CompareValidator></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblCity" runat="server" meta:resourcekey="lblCityResource1">City</asp:Label></td>
                        <td><asp:DropDownList ID="ddlCity" runat="server" meta:resourcekey="ddlCityResource1"></asp:DropDownList>
                            </td>
                    </tr>
                    <tr>
                        <td><asp:CheckBox ID="ckbIsPalleteVisible" runat="server" Text="IsPalleteVisible" meta:resourcekey="ckbIsPalleteVisibleResource1"></asp:CheckBox></td
                    </tr>
                    <tr style="display:none;">
                        <td><asp:Label ID="lblTeachersName" runat="server" meta:resourcekey="lblTeachersNameResource1">Teachers Name</asp:Label></td>
                        <td><asp:TextBox ID="txtTeachersName" runat="server" Width="402px" meta:resourcekey="txtTeachersNameResource1"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvTeacher"  ClientIDMode="Static" runat="server" ErrorMessage="Teacher Name is required" ControlToValidate="txtTeachersName" ValidationGroup="v" ForeColor="Red" Enabled="False" meta:resourcekey="rfvTeacherResource1">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblEmail" runat="server" meta:resourcekey="lblEmailResource1">Email</asp:Label></td>
                        <td><asp:TextBox ID="txtEmail" runat="server" Width="402px" meta:resourcekey="txtEmailResource1"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvEmail"  ClientIDMode="Static" runat="server" ErrorMessage="Email is required" ControlToValidate="txtEmail" ValidationGroup="v" ForeColor="Red" Display="Dynamic" Enabled="False" meta:resourcekey="rfvEmailResource1">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblParentsName" runat="server" meta:resourcekey="lblParentsNameResource1">Parents Name</asp:Label></td>
                        <td><asp:TextBox ID="txtParentsName" runat="server" Width="402px" meta:resourcekey="txtParentsNameResource1"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvParentsName" ClientIDMode="Static"  runat="server" ErrorMessage="Parent's Name is required" ControlToValidate="txtParentsName" ValidationGroup="v" ForeColor="Red" Enabled="False" meta:resourcekey="rfvParentsNameResource1">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblSchoolEntry" runat="server" meta:resourcekey="lblSchoolEntryResource1">School Entry(Registration)</asp:Label></td>
                        <td><asp:TextBox ID="txtSchoolEntry" runat="server" Width="402px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblMatchingFrequency" runat="server" meta:resourcekey="lblMatchingFrequencyResource1">Matching Frequency/Month</asp:Label></td>
                        <td><asp:TextBox ID="txtMatchingFrequency" TextMode="Number" runat="server" Width="50px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblLinkKey" runat="server" meta:resourcekey="lblLinkKeyResource1">Zendesk Link</asp:Label></td>
                        <td><asp:TextBox ID="txtLinkKey" runat="server" Width="100px"></asp:TextBox></td>
                    </tr>
                    <tr><td><br /></td></tr>
                    <tr>
                        <td colspan="8">
                            <fieldset class="fieldset">
                                <legend><asp:Label ID="lblRemarksLegend" runat="server" Text="Remarks" meta:resourcekey="lblRemarksLegendResource1"></asp:Label></legend>
                                <table>
                                    <tr>
                                        <td><asp:Label ID="lblClass2" runat="server" meta:resourcekey="lblClass2Resource1">Class(2017)</asp:Label></td>
                                        <td><asp:TextBox ID="txtClass2" runat="server" MaxLength="8" Width="80px" meta:resourcekey="txtClass2Resource1"></asp:TextBox></td>
                                        <td><asp:Label ID="lblClass3" runat="server" meta:resourcekey="lblClass3Resource1">Class(2018)</asp:Label></td>
                                        <td><asp:TextBox ID="txtClass3" runat="server" MaxLength="8" Width="80px" meta:resourcekey="txtClass3Resource1"></asp:TextBox></td>
                                        
                                    </tr>
                                    <tr>
                                        <td><asp:Label ID="lblNote1" runat="server" meta:resourcekey="lblNote1Resource1">Note 1</asp:Label></td>
                                        <td><asp:TextBox ID="txtNote1" runat="server" Width="200px" MaxLength="50" TextMode="MultiLine" meta:resourcekey="txtNote1Resource1"></asp:TextBox></td>
                                        <td><asp:Label ID="lblNote2" runat="server" meta:resourcekey="lblNote2Resource1">Note 2</asp:Label></td>
                                        <td><asp:TextBox ID="txtNote2" runat="server" Width="200px" MaxLength="50" TextMode="MultiLine" meta:resourcekey="txtNote2Resource1"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td><asp:Label ID="lblNote3" runat="server" meta:resourcekey="lblNote3Resource1">Note 3</asp:Label></td>
                                        <td><asp:TextBox ID="txtNote3" runat="server" Width="200px" MaxLength="50" TextMode="MultiLine" meta:resourcekey="txtNote3Resource1"></asp:TextBox></td>
                                        <td><asp:Label ID="lblNote4" runat="server" meta:resourcekey="lblNote4Resource1">Note 3</asp:Label></td>
                                        <td><asp:TextBox ID="txtNote4" runat="server" Width="200px" MaxLength="50" TextMode="MultiLine"  meta:resourcekey="txtNote4Resource1"></asp:TextBox></td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="8">
                            <fieldset>
                                <legend><asp:Label ID="Label1" runat="server" meta:resourcekey="lblPaletteSettingsResource1">Talk Time Settings</asp:Label></legend>
                                <table>
                                     <tr>
                                        <td><asp:Label ID="lblTalkSessionTime" runat="server" meta:resourcekey="lblTalkSessionTimeResource1">Talk Session(Minutes)</asp:Label></td>
                                        <td><asp:TextBox ID="txtTalkSessionTime" runat="server" Width="100px" TextMode="Number" ClientIDMode="Static"></asp:TextBox></td>
                                    </tr>
                                     <tr>
                                        <td><asp:Label ID="lblBalanceTime" runat="server" meta:resourcekey="lblBalanceTimeResource1">Balance(Minutes)</asp:Label></td>
                                        <td><asp:TextBox ID="txtBalanceTime" runat="server" Width="100px" TextMode="Number" ClientIDMode="Static" disabled></asp:TextBox></td>
                                    </tr>
                                     <tr>
                                        <td><asp:Label ID="lblTotalTime" runat="server" meta:resourcekey="lblTotalTimeResource1">Total Time(Minutes)</asp:Label></td>
                                        <td><asp:TextBox ID="txtTotalTime" runat="server" Width="100px" TextMode="Number" ClientIDMode="Static"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:CheckBox ID="chkUpdateTalkTime" runat="server" meta:resourcekey="chkUpdateTalkTimeResource1"/>
                                            <asp:Label ID="lblUpdateTalkTime" runat="server" meta:resourcekey="lblUpdateTalkTimeResource1">Check this if you want to update the Talk time, doing so will reset the Balance equal to Total Time alloted.</asp:Label>
                                        </td>
                                        
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr><td><br /></td></tr>
                    <tr>
                        <td><asp:Label ID="lblAfterSchool" runat="server" meta:resourcekey="lblAfterSchoolResource1">After School Access</asp:Label></td>
                        <td>
                            <asp:CheckBox ID="chkAfterSchool" runat="server" meta:resourcekey="chkAfterSchoolResource1"/>
                        </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblTCRead" runat="server" meta:resourcekey="lblTCReadResource1">Activate</asp:Label></td>
                        <td>
                            <asp:CheckBox ID="chkTCRead" runat="server" meta:resourcekey="chkTCReadResource1"/>
                        </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblActivate" runat="server" meta:resourcekey="lblActivateResource1">Activate</asp:Label></td>
                        <td>
                            <asp:CheckBox ID="chkActivate" runat="server" meta:resourcekey="chkActivateResource1"/>
                        </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblAllowTalk" runat="server" meta:resourcekey="lblAllowTalkResource1">Allow Talk</asp:Label></td>
                        <td>
                            <asp:CheckBox ID="chkAllowTalk" runat="server" meta:resourcekey="chkAllowTalkResource1"/>
                        </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblRobot" runat="server" meta:resourcekey="lblRobotResource1">Robot</asp:Label></td>
                        <td>
                            <asp:CheckBox ID="chkRobot" runat="server" meta:resourcekey="chkRobotResource1"/>
                        </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblEnabledFreeMessage" runat="server" meta:resourcekey="lblEnabledFreeMessageResource1">Enabled Free Message</asp:Label></td>
                        <td>
                            <asp:CheckBox ID="chkEnabledFreeMessage" runat="server" meta:resourcekey="chkEnabledFreeMessageResource1"/>
                        </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblSoundAndMail" runat="server" meta:resourcekey="lblSoundAndMailResource1">Sound And Mail/Mail Only</asp:Label></td>
                        <td>
                            <asp:CheckBox ID="chkSoundAndMail" runat="server" meta:resourcekey="chkSoundAndMailResource1"/>
                        </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblOrderByLearningLanguage" runat="server" meta:resourcekey="lblOrderByLearningLanguageResource1">Order By Learning Language</asp:Label></td>
                        <td>
                            <asp:CheckBox ID="chkOrderByLearningLanguage" runat="server" meta:resourcekey="chkOrderByLearningLanguageResource1"/>
                        </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblShowRomanji" runat="server" meta:resourcekey="lblShowRomanjiResource1">Show Romanji</asp:Label></td>
                        <td><asp:CheckBox ID="chkShowRomanji" runat="server" meta:resourcekey="chkShowRomanjiResource1"></asp:CheckBox></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblParentsInfoStored" runat="server" meta:resourcekey="lblParentsInfoStoredResource1">Parent's Info Stored</asp:Label></td>
                        <td>
                            <asp:CheckBox ID="chkParentsInfoStored" runat="server" meta:resourcekey="chkParentsInfoStoredResource1"/>
                        </td>
                    </tr>
                </table>

                <asp:Label ID="lblMessage" runat="server" Visible="False" EnableViewState="False" Text="Action Error." meta:resourcekey="lblMessageResource1"></asp:Label><br />
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="v" BorderColor="Red" BorderStyle="Solid" BorderWidth="1px" HeaderText="Please check your inputs" ForeColor="Red" meta:resourcekey="ValidationSummary1Resource1" />
                <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" ValidationGroup="v" OnClientClick="window.scrollTo = function(x,y) { return true; };" meta:resourcekey="btnSaveResource1" />
                <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click" meta:resourcekey="btnClearResource1" />
                <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click" meta:resourcekey="btnDeleteResource1"
                     />
                </fieldset>
            </ContentTemplate>
        </asp:UpdatePanel>
</asp:Content>
