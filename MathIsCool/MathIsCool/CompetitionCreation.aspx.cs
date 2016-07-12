using MathIsCool.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MathIsCool
{
    public partial class CompetitionCreation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


        }
        protected void btn_CrtComp_Click(object sender, EventArgs e)
        {
            MathIsCoolDataContext items = new MathIsCoolDataContext();

            competition Comp = new competition();
            
            string N = Note.InnerText;
            string SCH = Sched.InnerText;

            var RegionGU = Region.Value;           
            var LevelGU = Level.Value;
            var LocateGU = Location.Value;
            var TeamPerSchoolCount = TeamCount.Value;
            var Schedule = SCH;

            int LG = 0;
            int TC = 0;
            if (Int32.TryParse(LevelGU, out LG))
                Comp.level_id = LG;
            else
                Console.WriteLine("String could not be parsed.");

            if (Int32.TryParse(TeamPerSchoolCount, out TC))
                Comp.team_limit = TC;
            else
                Console.WriteLine("String could not be parsed.");

            Comp.comp_id = new Guid();
            Comp.region_id = new Guid(RegionGU);
            Comp.comp_loc_id = new Guid(LocateGU);
            Comp.note = N;
            Comp.status_id = 1;
            Comp.name = CompName.InnerText;
            Comp.schedule = Schedule;

            /*
            Comp.date = value.date;
            */

            // items.competitions.InsertOnSubmit(Comp);
            //  items.SubmitChanges();
        }

    }

}