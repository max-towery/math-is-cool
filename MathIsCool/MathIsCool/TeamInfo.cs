using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MathIsCool
{
    public class TeamInfo
    {
        public Guid coachGUID;
        public Guid teamID;
        public Guid compID;
        public Guid regID;

        public Guid stu1Id;
        public Guid stu2Id;
        public Guid stu3Id;
        public Guid stu4Id;

        public Guid schoolId;
        public string homeSchoolName;
        public string compName;

        public string coachName;
        public string teamName;
        public string stu1Name;
        public string stu2Name;
        public string stu3Name;
        public string stu4Name;
        public int stu1Grade;
        public int stu2Grade;
        public int stu3Grade;
        public int stu4Grade;

        public string status;
        public DateTime competitionDate;

        public bool isPaid;
        public string compLevel;

        // Add a students name to the first null student name
        public void AddName(string name, int grade, Guid id)
        {

            if (stu1Name == null)
            {
                stu1Name = name;
                stu1Grade = grade;
                stu1Id = id;
            }
            else if (stu2Name == null)
            {
                stu2Name = name;
                stu2Grade = grade;
                stu2Id = id;
            }
            else if (stu3Name == null)
            {
                stu3Name = name;
                stu3Grade = grade;
                stu3Id = id;
            }
            else if (stu4Name == null)
            {
                stu4Name = name;
                stu4Grade = grade;
                stu4Id = id;
            }
        }

        // Check if the name already got added (this method isn't being used anymore)
        public bool HasName(string name)
        {
            if (stu1Name == name || stu2Name == name || stu3Name == name || stu4Name == name)
                return true;
            else
                return false;
        }
    }
}