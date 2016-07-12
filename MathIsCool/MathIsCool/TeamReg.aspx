<%@ Page Title="" Language="C#" MasterPageFile="Site.Master" AutoEventWireup="true" CodeBehind="TeamReg.aspx.cs" Inherits="MathIsCool.TeamRegistration.TeamReg" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
    <asp:GridView ID="GV_Teams" runat="server" AutoGenerateSelectButton="True" OnSelectedIndexChanged="GV_Teams_SelectedIndexChanged"></asp:GridView>
    <br />

    <label for="DropDown_Region">Region</label>&nbsp;&nbsp;&nbsp;
    <asp:DropDownList ID="DropDown_Region"  AutoPostBack="True" runat="server" Width="200px" class="btn btn-primary dropdown-toggle" OnSelectedIndexChanged="DropDown_Region_SelectedIndexChanged">
        <asp:ListItem>Central Valley</asp:ListItem>
        <asp:ListItem>North Central</asp:ListItem>
        <asp:ListItem>Shadle</asp:ListItem>
        </asp:DropDownList>
    <br />

    <label for="DropDown_HomeSchool">Current School</label>&nbsp;&nbsp;&nbsp;
    <asp:DropDownList ID="DropDown_HomeSchool"  runat="server" Width="200px" class="btn btn-primary dropdown-toggle">
        <asp:ListItem>Choose Region</asp:ListItem>
        </asp:DropDownList>
    <br />

    <label for="DropDownList_Competition">Competition</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:DropDownList ID="DropDownList_Competition"  runat="server" DataTextField="Please select a competition" Width="200px" class="btn btn-primary dropdown-toggle">
        <asp:ListItem>Choose Region</asp:ListItem>
        </asp:DropDownList>
    <br />

    <label for="DropDownList_Competition">Status</label>
    <asp:DropDownList ID="DropDown_Status" class="btn btn-primary dropdown-toggle" runat="server">
        <asp:ListItem Value="Regular"></asp:ListItem>
        <asp:ListItem>Masters</asp:ListItem>
    </asp:DropDownList>


    <div class="row">
        <div class="col-xs-3">
        <label for="Tb_TeamName">Team Name</label>
        <asp:TextBox ID="Tb_TeamName" runat="server" class="form-control"></asp:TextBox>
        </div>
    </div>

    <div class="row">
        <div class="col-xs-3">
        <label for="Tb_Stu1">Student 1</label>
        <asp:TextBox ID="Tb_Stu1" runat="server" class="form-control"></asp:TextBox>
        </div>

        <div class="col-xs-2">
        <label for="DropDownList_GradeLevel1" >Grade Level</label>
        <asp:DropDownList ID="DropDownList_GradeLevel1" runat="server" class="btn btn-primary dropdown-toggle">
        <asp:ListItem>4th</asp:ListItem>
        <asp:ListItem>5th</asp:ListItem>
        <asp:ListItem>6th</asp:ListItem>
        <asp:ListItem Value="PA">Pre-algebra</asp:ListItem>
        <asp:ListItem Value="A1">Algebra 1</asp:ListItem>
        <asp:ListItem Value="A2">Algebra 2</asp:ListItem>
        <asp:ListItem Value="GE">Geometry</asp:ListItem>
        <asp:ListItem Value="PC">Precalculus</asp:ListItem>
        <asp:ListItem Value="CA">Calculus</asp:ListItem>
        </asp:DropDownList>
        </div>
    </div>

    <div class="row">
        <div class="col-xs-3">
        <label for="Tb_Stu2">Student 2</label>
        <asp:TextBox ID="Tb_Stu2" runat="server" class="form-control"></asp:TextBox>
        </div>

        <div class="col-xs-2">
        <label for="DropDownList_GradeLevel2" >Grade Level</label>
        <asp:DropDownList ID="DropDownList_GradeLevel2" runat="server" class="btn btn-primary dropdown-toggle">
        <asp:ListItem>4th</asp:ListItem>
        <asp:ListItem>5th</asp:ListItem>
        <asp:ListItem>6th</asp:ListItem>
        <asp:ListItem Value="PA">Pre-algebra</asp:ListItem>
        <asp:ListItem Value="A1">Algebra 1</asp:ListItem>
        <asp:ListItem Value="A2">Algebra 2</asp:ListItem>
        <asp:ListItem Value="GE">Geometry</asp:ListItem>
        <asp:ListItem Value="PC">Precalculus</asp:ListItem>
        <asp:ListItem Value="CA">Calculus</asp:ListItem>
        </asp:DropDownList>
            </div>
    </div>

    <div class="row">
        <div class="col-xs-3">
        <label for="Tb_Stu3">Student 3</label>
        <asp:TextBox ID="Tb_Stu3" runat="server" class="form-control"></asp:TextBox>
        </div>

        <div class="col-xs-2">
        <label for="DropDownList_GradeLevel3" >Grade Level</label>
        <asp:DropDownList ID="DropDownList_GradeLevel3" runat="server" class="btn btn-primary dropdown-toggle">
        <asp:ListItem>4th</asp:ListItem>
        <asp:ListItem>5th</asp:ListItem>
        <asp:ListItem>6th</asp:ListItem>
        <asp:ListItem Value="PA">Pre-algebra</asp:ListItem>
        <asp:ListItem Value="A1">Algebra 1</asp:ListItem>
        <asp:ListItem Value="A2">Algebra 2</asp:ListItem>
        <asp:ListItem Value="GE">Geometry</asp:ListItem>
        <asp:ListItem Value="PC">Precalculus</asp:ListItem>
        <asp:ListItem Value="CA">Calculus</asp:ListItem>
        </asp:DropDownList>
        </div>
    </div>

    <div class="row">
        <div class="col-xs-3">
        <label for="Tb_Stu4">Student 4</label>
        <asp:TextBox ID="Tb_Stu4" runat="server" class="form-control"></asp:TextBox>
        </div>

        <div class="col-xs-2">
        <label for="DropDownList_GradeLevel4" >Grade Level</label>
        <asp:DropDownList ID="DropDownList_GradeLevel4" runat="server" class="btn btn-primary dropdown-toggle">
        <asp:ListItem>4th</asp:ListItem>
        <asp:ListItem>5th</asp:ListItem>
        <asp:ListItem>6th</asp:ListItem>
        <asp:ListItem Value="PA">Pre-algebra</asp:ListItem>
        <asp:ListItem Value="A1">Algebra 1</asp:ListItem>
        <asp:ListItem Value="A2">Algebra 2</asp:ListItem>
        <asp:ListItem Value="GE">Geometry</asp:ListItem>
        <asp:ListItem Value="PC">Precalculus</asp:ListItem>
        <asp:ListItem Value="CA">Calculus</asp:ListItem>
        </asp:DropDownList>
        </div>
    </div>

    <br />

    <asp:Button ID="Btn_Delete" runat="server" CssClass="btn" Text="Delete" OnClick="Btn_Delete_Click" Visible="False" ForeColor="#CC3300" />
    <asp:Button ID="Btn_Cancel" runat="server" CssClass="btn"  Text="Cancel" OnClick="Btn_Cancel_Click" />
    <asp:Button ID="Btn_Register" runat="server" CssClass="btn" Text="Register" OnClick="Btn_Register_Click" />

    <br />
  </div>
</asp:Content>
