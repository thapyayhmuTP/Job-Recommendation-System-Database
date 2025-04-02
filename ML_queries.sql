Use Jobs;

#7.3.1 Predicting Salary Based on Candidate Profile
SELECT 
    c.CandidateID,
    c.ExperienceYears,
    c.EducationLevel,
    COUNT(cs.SkillID) AS SkillCount,
    AVG(s.Salary) AS AverageSalary
FROM Candidates c
JOIN 
    CandidateSkills cs ON c.CandidateID = cs.CandidateID
JOIN 
    Applications a ON c.CandidateID = a.CandidateID
JOIN 
    JobListings j ON a.JobID = j.JobID
JOIN 
    Salaries s ON j.JobID = s.JobID
GROUP BY c.CandidateID, c.ExperienceYears, c.EducationLevel
ORDER BY AverageSalary DESC,ExperienceYears DESC;

#7.3.2 Candidate Clustering Based on Skill Set
SELECT 
    cs.CandidateID,
    GROUP_CONCAT(s.SkillName ORDER BY s.SkillName SEPARATOR ', ') AS SkillCluster
FROM CandidateSkills cs
JOIN 
    Skills s ON cs.SkillID = s.SkillID
GROUP BY cs.CandidateID;
    
#7.3.3 Predicting Candidate Qualification Based on Skills
SELECT 
    a.ApplicationID,
    a.CandidateID,
    a.JobID,
    COUNT(DISTINCT js.SkillID) AS RequiredSkills,
    COUNT(DISTINCT cs.SkillID) AS MatchingSkills,
    CASE 
        WHEN COUNT(DISTINCT cs.SkillID) >= COUNT(DISTINCT js.SkillID) 
        THEN 1 ELSE 0 
    END AS IsQualified
FROM Applications a
JOIN 
    JobSkills js ON a.JobID = js.JobID
JOIN 
    CandidateSkills cs ON a.CandidateID = cs.CandidateID AND js.SkillID = cs.SkillID
GROUP BY a.ApplicationID, a.CandidateID, a.JobID;
    
#7.3.4 Time Series Dataset for Analyzing Application Trends
SELECT 
    DATE_FORMAT(ApplicationDate, '%Y-%m') AS Month,
    COUNT(*) AS TotalApplications
FROM Applications
GROUP BY Month
ORDER BY Month;