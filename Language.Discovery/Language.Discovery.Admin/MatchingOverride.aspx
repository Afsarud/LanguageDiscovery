<%@ Page Title="" Language="C#" MasterPageFile="~/Master/AdminMaster.Master" AutoEventWireup="true" CodeBehind="MatchingOverride.aspx.cs" Inherits="Language.Discovery.Admin.MatchingOverride" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
     <div style="width:100%;border:1px solid black;text-align:center;">
        <asp:Label ID="lblTitle" runat="server" Text="Matching Override" meta:resourcekey="lblTitleResource1"></asp:Label>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <script src="scripts/select2.min.js"></script>
    <link href="css/select2.min.css" rel="stylesheet" />
    <script>
        var date = moment();
        var dateToday = new Date(date);
        //getSchedules(date.month() + 1 + "-" + date.date() + "-" + date.year());
        $("#monthView").datepicker({
            minDate: dateToday,
            onSelect: function (dateText, inst) {
                $('#hdnDate').val(dateText);
                $('#btnUpdate').click();
                //getSchedules(dateText.replace(/\//g, "-"));
                
            }
        });
    </script>
     <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:HiddenField ID="hdnDate" runat="server" ClientIDMode="Static"/>
            <asp:Button ID="btnUpdate" runat="server" Text="update" style="display:none;" OnClick="btnUpdate_Click"  />
              <fieldset class="fieldset">
                  <legend><asp:Label ID="lblSearchLegend" runat="server" Text="Select Date" meta:resourcekey="lblSearchLegendResource1"></asp:Label></legend>
                   <div id="monthView"></div>

               </fieldset>

            <br />
             <div id="divMessage" style="border:1px solid black;overflow:auto; height:450px; width:100%;">
                <asp:Repeater ID="rptMessage" runat="server" ClientIDMode="Static" OnItemCommand="rptMessage_ItemCommand">
                    <HeaderTemplate>
                        <table id="tblMessage" border="1" style="padding:0;border-collapse:collapse;width:100%;">
                            <thead>
                                <tr>
                                    <th></th>
                                    <th></th>
                                    <th><asp:Label ID="lblDateTime" runat="server" Text="Schedule" meta:resourcekey="lblDateTimeResource1"></asp:Label></th>
                                    <th><asp:Label ID="lblPartners" runat="server" Text="Partners" meta:resourcekey="lblPartnersResource1"></asp:Label></th>
                                    <th><asp:Label ID="lblUpdate" runat="server" Text="Update" meta:resourcekey="lblUpdateResource1"></asp:Label></th>
                                </tr>
                            </thead>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <asp:Label ID="lblScheduleId" runat="server" Text='<%# Eval("ScheduleId") %>' style="display:none;"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblDateTime" runat="server" Text='<%# Eval("Schedule") %>' meta:resourcekey="lblDateTimeResource2"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlUser" runat="server"></asp:DropDownList>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlPartner" runat="server"></asp:DropDownList>
                            </td>
                            <td>
                                <asp:Button ID="btnUpdate" runat="server" Text="Update" CommandName="udpate" CommandArgument='<%# Eval("ScheduleId") %>' meta:resourcekey="btnUpdateResource1"/>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
