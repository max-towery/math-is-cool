using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Data;
using MathIsCool.Models;

namespace MathIsCool.TeamRegistration
{
    public partial class TeamReg : System.Web.UI.Page
    {
        private MathIsCoolDataContext items = new MathIsCoolDataContext();
        List<TeamInfo> teams;
        private TeamInfo selectedTeam;

        protected void Page_Load(object sender, EventArgs e)
        {
            teams = Session["teams"] as List<TeamInfo>;
            selectedTeam = Session["selectedTeam"] as TeamInfo;

            if (IsPostBack == false)
            {
                LoadControls();
            }
        }

        private void LoadControls()
        {
            // get the list of teams and show it in a table
            teams = GetTeamsList();
            Session["teams"] = teams;

            GV_Teams.DataSource = GenerateTable(teams);
            GV_Teams.DataBind();
            GV_Teams.CssClass = "table table-bordered";

            UpdateDropdownBoxes();
        }

        private void UpdateDropdownBoxes()
        {
            // load the list of regions into DropDown_Region
            DropDown_Region.Items.Clear();
            foreach (region reg in items.regions)
            {
                DropDown_Region.Items.Add(reg.region_name);
            }
            DropDown_Region.DataBind();
        }

        private object GenerateTable(List<TeamInfo> teams)
        {
            DataTable table = new DataTable();
            table.Columns.Add("Team Name");
            table.Columns.Add("Coach");
            table.Columns.Add("School", typeof(string));
            table.Columns.Add("Competition Location", typeof(string));
            table.Columns.Add("Competition Grade", typeof(string));
            table.Columns.Add("Student 1");
            table.Columns.Add("Student 2");
            table.Columns.Add("Student 3");
            table.Columns.Add("Student 4");
            table.Columns.Add("Competition Status");
            table.Columns.Add("Competition Date");
            table.Columns.Add("Paid");

            foreach (TeamInfo team in teams)
            {
                table.Rows.Add(team.teamName, team.coachName, team.homeSchoolName, team.compName, team.compLevel, team.stu1Name, team.stu2Name, team.stu3Name, team.stu4Name, team.status, team.competitionDate, team.isPaid);
            }

            return table;
        }

        private List<TeamInfo> GetTeamsList()
        {
            List<TeamInfo> teams = new List<TeamInfo>();
            foreach (RegistrationView reg in items.RegistrationViews)
            {
                if (!listContainsTeamGuid(teams, (Guid)reg.team_id))
                {
                    TeamInfo team = new TeamInfo();
                    team.coachGUID = (Guid)reg.user_id;
                    team.teamID = (Guid)reg.team_id;
                    team.compID = (Guid)reg.comp_id;

                    team.stu1Id = (Guid)reg.student_id;

                    team.schoolId = reg.school_id;
                    school homeSchool = (from a in items.schools where a.school_id == team.schoolId select a).SingleOrDefault();
                    team.homeSchoolName = homeSchool.name;

                    user coach = (from a in items.users where a.user_id == team.coachGUID select a).SingleOrDefault();
                    team.coachName = coach.fname + " " + coach.lname;
                    team.teamName = reg.teamName;

                    team.compID = (Guid)reg.comp_id;
                    competition comp = (from a in items.competitions where a.comp_id == team.compID select a).SingleOrDefault();

                    if (comp != null)
                    {
                        team.compName = comp.name;
                        team.competitionDate = (DateTime)comp.date;
                    }

                    team.stu1Name = reg.fname;
                    team.status = reg.status;

                    int level = reg.comp_level;
                    comp_level comp_level_result = (from a in items.comp_levels where a.id == level select a).SingleOrDefault();
                    if (comp_level_result != null)
                        team.compLevel = comp_level_result.value;

                    //team.isPaid = (int)reg.is_paid;
                    teams.Add(team);
                }
                else
                {
                    // find the teaminfo record in our arraylist
                    TeamInfo teamInfo = new TeamInfo();
                    foreach (TeamInfo curTeam in teams)
                    {
                        if (curTeam.teamID == (Guid)reg.team_id)
                        {
                            teamInfo = curTeam;
                        }
                    }

                    // add name, grade level, etc
                    string name = reg.fname;
                    math_level level = (from a in items.math_levels where a.value == reg.value select a).SingleOrDefault();
                    int gradeKey = level.id;

                    Guid stuId = reg.student_id;
                    teamInfo.AddName(name, gradeKey, stuId);
                }
            }

            return teams;
        }

        private bool listContainsTeamGuid(List<TeamInfo> teams, Guid team_id)
        {
            foreach (TeamInfo team in teams)
            {
                if (team.teamID == team_id)
                {
                    return true;
                }
            }
            return false;
        }

        protected void Btn_Register_Click(object sender, EventArgs e)
        {
            if (DropDown_HomeSchool.Items[0].Text == "No schools registered in this region")
                return;
            if (DropDownList_Competition.Items[0].Text == "No competitions registered in this region")
                return;

            TeamInfo team = selectedTeam;
            try
            {
                if (selectedTeam == null)
                {
                    team = new TeamInfo();
                    selectedTeam = team;
                    Session["selectedTeam"] = selectedTeam;

                    Guid userID = new Guid("886c4d47-440a-8d8e-dcf3-0624b8416e07");
                    team.coachGUID = userID;
                    team.teamID = Guid.NewGuid();
                    String regionString = DropDown_Region.Text;
                    region region = (from a in items.regions where a.region_name == regionString select a).SingleOrDefault();
                    team.regID = region.region_id;
                    team.stu1Id = Guid.NewGuid();
                    team.stu2Id = Guid.NewGuid();
                    team.stu3Id = Guid.NewGuid();
                    team.stu4Id = Guid.NewGuid();
                    team.homeSchoolName = DropDown_HomeSchool.Text;
                    school school = (from a in items.schools where a.name == team.homeSchoolName select a).SingleOrDefault();

                    if (school != null)
                        team.schoolId = school.school_id;
                    team.compName = DropDownList_Competition.Text;
                    user user = (from a in items.users where a.user_id == userID select a).SingleOrDefault();
                    team.coachName = user.fname + " " + user.lname;
                    team.teamName = Tb_TeamName.Text;

                    team.stu1Name = Tb_Stu1.Text;
                    team.stu2Name = Tb_Stu2.Text;
                    team.stu3Name = Tb_Stu3.Text;
                    team.stu4Name = Tb_Stu4.Text;
                    team.stu1Grade = DropDownList_GradeLevel1.SelectedIndex + 1;
                    team.stu2Grade = DropDownList_GradeLevel2.SelectedIndex + 1;
                    team.stu3Grade = DropDownList_GradeLevel3.SelectedIndex + 1;
                    team.stu4Grade = DropDownList_GradeLevel4.SelectedIndex + 1;

                    //comp_location comp_location = (from a in items.comp_locations where a.name == team.compName select a).SingleOrDefault();
                    competition competition = (from a in items.competitions where a.name == team.compName select a).SingleOrDefault();
                    team.compID = competition.comp_id;

                    team.isPaid = false;
                    comp_level comp_level = competition.comp_level;
                    team.compLevel = comp_level.value;
                    //Btn_Register.Text = team.compLevel;

                    // at this we should have a TeamInfo object that is has all field filled out - post it to the database
                    SubmitTeam(team);
                }
                else
                {
                    // we are trying to update a record
                    // walk through each relevant table and modify the necessary values
                    // --method incomplete--
                }
            }

            catch (Exception error)
            {
                String message = error.Message;
            }

            EmptyFields();
        }

        protected void SubmitTeam(TeamInfo team)
        {
            // create invoice
            invoice invoice = new invoice();
            invoice.invoice_id = Guid.NewGuid();
            invoice.user_id = team.coachGUID;
            invoice.description = "Registered a new team on " + DateTime.Now;
            invoice.payment = 0;
            invoice.payment_date = DateTime.Now;
            invoice.value = 13;
            items.invoices.InsertOnSubmit(invoice);
            items.SubmitChanges();

            // create line item
            line_item line_item = new line_item();
            line_item.line_item_id = Guid.NewGuid();
            line_item.invoice_id = invoice.invoice_id;
            line_item.sku_id = new Guid("46522301-2cf2-47df-90e1-539089574ab1");
            items.line_items.InsertOnSubmit(line_item);
            items.SubmitChanges();

            // create registration
            registration registration = new registration();
            registration.reg_id = Guid.NewGuid();
            registration.comp_id = team.compID;
            registration.user_id = team.coachGUID;
            registration.school_id = team.schoolId;
            registration.line_item_id = line_item.line_item_id;

            // get the key of the comp level based on team.compLevel
            comp_level comp_level = (from a in items.comp_levels where a.value == team.compLevel select a).SingleOrDefault();
            registration.comp_level = comp_level.id;
            registration.registration_type = 4;
            registration.num_teams = 1;
            registration.coach_name = team.coachName;
            registration.is_paid = 0;
            // TODO: get comp level, registration type, numteams (add them to teamInfo and pull them from the database when creating teaminfo)
            //registration.comp_level = team.compLevel;

            items.registrations.InsertOnSubmit(registration);
            items.SubmitChanges();

            // create team
            team newTeam = new team();
            newTeam.name = team.teamName;
            newTeam.team_id = Guid.NewGuid();
            newTeam.reg_id = registration.reg_id;
            items.teams.InsertOnSubmit(newTeam);
            items.SubmitChanges();

            // create students
            if (team.stu1Name != "null")
            {
                student student = new student();
                student.student_id = Guid.NewGuid();
                student.fname = team.stu1Name;
                student.team_id = newTeam.team_id;
                student.student_level = team.stu1Grade;
                student.lname = "lname field ignored";

                items.students.InsertOnSubmit(student);
                items.SubmitChanges();
            }
            if (team.stu2Name != "null")
            {
                student student = new student();
                student.student_id = Guid.NewGuid();
                student.fname = team.stu2Name;
                student.team_id = newTeam.team_id;
                student.student_level = team.stu2Grade;
                student.lname = "lname field ignored";

                items.students.InsertOnSubmit(student);
                items.SubmitChanges();
            }
            if (team.stu3Name != "null")
            {
                student student = new student();
                student.student_id = Guid.NewGuid();
                student.fname = team.stu3Name;
                student.team_id = newTeam.team_id;
                student.student_level = team.stu3Grade;
                student.lname = "lname field ignored";

                items.students.InsertOnSubmit(student);
                items.SubmitChanges();
            }
            if (team.stu4Name != "null")
            {
                student student = new student();
                student.student_id = Guid.NewGuid();
                student.fname = team.stu4Name;
                student.team_id = newTeam.team_id;
                student.student_level = team.stu4Grade;
                student.lname = "lname field ignored";

                items.students.InsertOnSubmit(student);
                items.SubmitChanges();
            }

            LoadControls();
        }


        protected void EmptyFields()
        {
            Btn_Delete.Visible = false;
            selectedTeam = null;
            Session["selectedTeam"] = selectedTeam;

            ClearInputs(Form.Controls);
        }

        private void ClearInputs(ControlCollection ctrls)
        {
            foreach (Control ctrl in ctrls)
            {
                if (ctrl is TextBox)
                    ((TextBox)ctrl).Text = string.Empty;
                else if (ctrl is DropDownList)
                    ((DropDownList)ctrl).ClearSelection();

                ClearInputs(ctrl.Controls);
            }
        }

        protected void DropDown_Region_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Populate schools dropdown list
            DropDown_HomeSchool.Items.Clear();
            String region_name = DropDown_Region.SelectedValue;
            region region = (from a in items.regions where a.region_name == region_name select a).SingleOrDefault();
            foreach (school school in items.schools)
            {
                if (school.region_id == region.region_id)
                    DropDown_HomeSchool.Items.Add(school.name);
            }
            DropDown_HomeSchool.DataBind();

            // Populate competitions dropdown list
            DropDownList_Competition.Items.Clear();
            foreach (competition comp in items.competitions)
            {
                if (comp.region_id == region.region_id)
                    DropDownList_Competition.Items.Add(comp.name);
            }

            if (DropDown_HomeSchool.Items.Count == 0)
                DropDown_HomeSchool.Items.Add("No schools registered in this region");
            if (DropDownList_Competition.Items.Count == 0)
                DropDownList_Competition.Items.Add("No competitions registered in this region");
        }

        protected void GV_Teams_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                int selectedIndex = GV_Teams.SelectedIndex;
                selectedTeam = teams[selectedIndex];
                Session["selectedTeam"] = selectedTeam;

                //Btn_Register.Text = selectedTeam.coachGUID.ToString();
                Btn_Delete.Visible = true;

                Tb_Stu1.Text = selectedTeam.stu1Name;
                Tb_Stu2.Text = selectedTeam.stu2Name;
                Tb_Stu3.Text = selectedTeam.stu3Name;
                Tb_Stu4.Text = selectedTeam.stu4Name;

                DropDownList_GradeLevel1.SelectedIndex = selectedTeam.stu1Grade - 1;
                DropDownList_GradeLevel2.SelectedIndex = selectedTeam.stu2Grade - 1;
                DropDownList_GradeLevel3.SelectedIndex = selectedTeam.stu3Grade - 1;
                DropDownList_GradeLevel4.SelectedIndex = selectedTeam.stu4Grade - 1;

                Tb_TeamName.Text = selectedTeam.teamName;
            }
            catch (Exception exc)
            {

            }
        }

        protected void Btn_Cancel_Click(object sender, EventArgs e)
        {
            EmptyFields();
        }

        protected void Btn_Delete_Click(object sender, EventArgs e)
        {
            try
            {

                int selectedIndex = GV_Teams.SelectedIndex;
                selectedTeam = teams[selectedIndex];
                Session["selectedTeam"] = selectedTeam;

                //Btn_Register.Text = selectedTeam.coachGUID.ToString();
                Btn_Delete.Visible = false;

                RemoveItem(selectedTeam);

                EmptyFields();
                LoadControls();
            }
            catch (Exception excep)
            {
                string exception = excep.ToString();
            }
        }

        protected void RemoveItem(TeamInfo team)
        {
            try
            {
                // delete students
                //(from a in items.regions where a.region_name == region_name select a).SingleOrDefault();
                student student = (from a in items.students where a.student_id == team.stu1Id select a).SingleOrDefault();

                if (student != null)
                {
                    items.students.DeleteOnSubmit(student);
                    items.SubmitChanges();
                }

                student = (from a in items.students where a.student_id == team.stu2Id select a).SingleOrDefault();
                if (student != null)
                {
                    items.students.DeleteOnSubmit(student);
                    items.SubmitChanges();
                }

                student = (from a in items.students where a.student_id == team.stu3Id select a).SingleOrDefault();
                if (student != null)
                {
                    items.students.DeleteOnSubmit(student);
                    items.SubmitChanges();
                }

                student = (from a in items.students where a.student_id == team.stu4Id select a).SingleOrDefault();
                if (student != null)
                {
                    items.students.DeleteOnSubmit(student);
                    items.SubmitChanges();
                }

                // delete team

                // delete registration

                // delete line item

                // delete invoice
            }
            catch (Exception excep)
            {

            }

        }
    }
}