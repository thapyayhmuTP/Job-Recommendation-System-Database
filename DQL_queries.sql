Use Jobs;

#6.1 The average time to get interview
SELECT 
    AVG(DATEDIFF(i.InterviewDate, a.ApplicationDate)) AS AvgTimeToInterview
FROM Applications a
JOIN Interviews i ON a.ApplicationID = i.ApplicationID;

#6.2 Companies Offering the Highest Average Salaries
WITH SalaryData AS (
    SELECT 
		c.CompanyID, 
        c.CompanyName, 
        AVG(s.Salary) AS AvgSalary
    FROM Salaries s
    JOIN 
		JobListings jl ON s.JobID = jl.JobID  
    JOIN 
		Departments d ON jl.DepartmentID = d.DepartmentID  
    JOIN 
		Companies c ON d.CompanyID = c.CompanyID 
    GROUP BY c.CompanyID, c.CompanyName
)
SELECT 
	CompanyID, 
    CompanyName, 
    AvgSalary, 
	RANK() OVER (ORDER BY AvgSalary DESC) AS `Rank`
FROM SalaryData
ORDER BY AvgSalary DESC;

#6.3 The impact of salary on the number of applications
SELECT 
    s.Salary,
    COALESCE(COUNT(a.ApplicationID), 0) AS NumberOfApplications
FROM Salaries s
JOIN JobListings jl ON s.JobID = jl.JobID
LEFT JOIN Applications a ON jl.JobID = a.JobID
GROUP BY s.Salary
ORDER BY s.Salary DESC;

#6.4 Interview Success Rate Based on Candidate Experience
SELECT c.ExperienceYears, 
       COUNT(i.InterviewID) AS TotalInterviews,
       SUM(CASE WHEN i.InterviewScore >= 70 THEN 1 ELSE 0 END) AS SuccessfulInterviews,
       ROUND(100.0 * SUM(CASE WHEN i.InterviewScore >= 70 THEN 1 ELSE 0 END) / NULLIF(COUNT(i.InterviewID), 0), 2) AS SuccessRate,
       NTILE(4) OVER (ORDER BY c.ExperienceYears DESC) AS ExperienceQuartile
FROM Candidates c
JOIN 
	Applications a ON c.CandidateID = a.CandidateID
JOIN 
	Interviews i ON a.ApplicationID = i.ApplicationID
GROUP BY c.ExperienceYears
ORDER BY c.ExperienceYears DESC;

#6.5 Companies with the highest number of job postings
SELECT 
    c.CompanyID,
    c.CompanyName,
    COUNT(j.JobID) AS JobPostings,
    RANK() OVER (ORDER BY COUNT(j.JobID) DESC) AS Rank_C
FROM Companies c
JOIN Departments d ON c.CompanyID = d.CompanyID
JOIN JobListings j ON d.DepartmentID = j.DepartmentID
GROUP BY c.CompanyID, c.CompanyName
ORDER BY JobPostings DESC;
