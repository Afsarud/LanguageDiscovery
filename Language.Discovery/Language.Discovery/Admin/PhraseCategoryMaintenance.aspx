<%@ Page Title="" Language="C#" MasterPageFile="~/Master/AdminMaster.Master" AutoEventWireup="true" CodeBehind="PhraseCategoryMaintenance.aspx.cs" Inherits="Language.Discovery.Admin.PhraseCategoryMaintenance" EnableEventValidation="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
    <style>
         #sortable { list-style-type:decimal-leading-zero; margin: 0; padding: 0;  }
        #sortable li { margin: 0 3px 3px 3px; padding: 0.4em; padding-left: 1.5em; font-size:small; height: 12px; }
         #sortable li span { position: absolute; margin-left: -1.3em; }
         .sortable-placeholder {display: none;}
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
    <table style="width:100%;">
        <tr>
            <td style="width:50%">
                <asp:UpdatePanel ID="upSearch" runat="server"  UpdateMode="Conditional">
                    <ContentTemplate>
                       <fieldset class="fieldset">
                            <asp:HiddenField ID="hdnPhraseCategoryHeaderID" runat="server" />
                            <legend>Search</legend>
                             <table>
                                <tr>
                                    <td><asp:Label ID="lblLanguage" runat="server">Language</asp:Label></td>
                                    <td><asp:DropDownList ID="ddlLanguage" runat="server"></asp:DropDownList></td>
                                    <td><asp:Label ID="lblSearchLevel" runat="server">Level</asp:Label></td>
                                    <td><asp:DropDownList ID="ddlSearchLevel" runat="server"></asp:DropDownList></td>
                                </tr>
                                 <tr>
                                    <td><asp:Label ID="lblSearchSchool" runat="server">School</asp:Label></td>
                                    <td><asp:DropDownList ID="ddlSearchSchool" runat="server"></asp:DropDownList></td>
                                    <td><asp:Label ID="lblCategory" runat="server">Category</asp:Label></td>
                                    <td><asp:TextBox ID="txtSearchCategory" runat="server"></asp:TextBox></td>
                                    <td><asp:Button ID="btnSearch" runat="server" Text="Search" 
                                    OnClick="btnSearch_Click" /></td>
                                 </tr>
                            </table>
        
                            <asp:GridView ID="grdResult" runat="server" PageSize="10" 
                                    GridLines="Horizontal" Width="80%" Height="300px"
                                    EmptyDataText="No record to display." AutoGenerateColumns="False" AllowPaging="True" 
                                    onpageindexchanging="grdResult_PageIndexChanging"
                                    onrowdatabound="grdResult_RowDataBound" 
                                    onselectedindexchanged="grdResult_SelectedIndexChanged" ShowFooter="True" 
                                    BackColor="White" BorderColor="#336666" 
                                    BorderWidth="3px">
                                    <PagerSettings Mode="NumericFirstLast" Position="Bottom" Visible="true" />
                                    <RowStyle BackColor="White" ForeColor="#333333"  Font-Size="Small"/>
                                    <FooterStyle BackColor="White" ForeColor="#333333"   Height="100%" />
                                    <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Right" />
                                    <SelectedRowStyle BackColor="#339966" Font-Bold="False" ForeColor="White" />
                                    <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                                    <Columns>
                                        <asp:TemplateField  ShowHeader="false" >
                                            <ItemTemplate>
                                                <asp:HiddenField ID="hdnSearchPhraseCategoryHeaderID" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"GroupID").ToString() %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="PhraseCategoryCode" HeaderText="Category" 
                                            HeaderStyle-HorizontalAlign="Left" >
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
                            <legend>Data Entry</legend>
                            <table>
                                <tr>
                                    <td><asp:Label ID="lblSchool" runat="server">School</asp:Label></td>
                                    <td><asp:DropDownList ID="ddlSchool" runat="server"></asp:DropDownList></td>
                                </tr>
                                <tr>
                                    <td><asp:Label ID="lblLevel" runat="server">Level</asp:Label></td>
                                    <td><asp:DropDownList ID="ddlLevel" runat="server"></asp:DropDownList></td>
                                </tr>
                                <tr>
                                    <td><asp:Label ID="lblEnglish" runat="server">English</asp:Label></td>
                                    <td><asp:TextBox ID="txtEnglish" runat="server" Width="402px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="English is required" ControlToValidate="txtEnglish" ValidationGroup="v">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td><asp:Label ID="lblHiragana" runat="server">Hiragana</asp:Label></td>
                                    <td><asp:TextBox ID="txtHiragana" runat="server" Width="402px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Hiragana is required" ControlToValidate="txtHiragana" ValidationGroup="v">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td><asp:Label ID="lblKanji" runat="server">Kanji</asp:Label></td>
                                    <td><asp:TextBox ID="txtKanji" runat="server" Width="402px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Kanji is required" ControlToValidate="txtKanji" ValidationGroup="v">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td><asp:Label ID="lblRomanji" runat="server">Romanji</asp:Label></td>
                                    <td><asp:TextBox ID="txtRomanji" runat="server" Width="402px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Romanji is required" ControlToValidate="txtRomanji" ValidationGroup="v">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                            </table>

                            <asp:Label ID="lblMessage" runat="server" Visible="false" EnableViewState="false" Text="Action Error."></asp:Label><br />

                            <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                            <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click" />
                            <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete?');" OnClick="btnDelete_Click"
                                 />
                            </fieldset>
                        </ContentTemplate>
                    </asp:UpdatePanel>

            </td>
            <td style="width:50%">
                <asp:UpdatePanel ID="upOrder" runat="server"  UpdateMode="Conditional">
                    <ContentTemplate>
                        <fieldset>
                            <legend>Sorter</legend>
                            <div style="overflow:scroll;height:700px;">
                                <asp:Repeater ID="rptCategory" runat="server">
                                    <HeaderTemplate>
                                        <ol id="sortable" style="margin-left:100px;width:300px;margin-top:50px;">
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <li class="ui-state-default" id='<%# Eval("GroupID") %>'>
                                            <asp:HiddenField ID="hdnPhraseCategoryHeaderID" runat="server" Value='<%# Eval("GroupID") %>' />
                                            <asp:Label ID="lblCategory" runat="server" Text='<%# Eval("PhraseCategoryCode") %>'></asp:Label>
                                        </li>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        </ol>
                                    </FooterTemplate>
                                </asp:Repeater>
                            </div>
                             <asp:Button ID="btnUpdateOrder" runat="server" Text="Save Order" OnClick="btnUpdateOrder_Click" OnClientClick="GetNewOrder();" />
                            </fieldset>
                </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
</asp:Content>
