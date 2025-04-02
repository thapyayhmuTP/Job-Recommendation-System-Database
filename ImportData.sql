USE Jobs;

SHOW GLOBAL VARIABLES LIKE 'local_infile';

SHOW VARIABLES LIKE 'secure_file_priv';

#Have to change the file path of .csv based on own computer

LOAD DATA INFILE '/Users/tph/Desktop/SQL/Final Project/CSV Data/Companies.csv'
INTO TABLE Companies
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
  CompanyID,
  RegistrationNumber,
  CompanyName,
  NoOfEmployees,
  Location,
  HiringProcess,
  Email,
  URL
);

LOAD DATA INFILE '/Users/tph/Desktop/SQL/Final Project/CSV Data/Skills.csv'
INTO TABLE Skills
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
  SkillID,
  SkillName
);

LOAD DATA INFILE '/Users/tph/Desktop/SQL/Final Project/CSV Data/Recruiters.csv'
INTO TABLE Recruiters
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
  RecruiterID,
  FirstName,
  LastName,
  SocialLink
);

LOAD DATA INFILE '/Users/tph/Desktop/SQL/Final Project/CSV Data/JobCategories.csv'
INTO TABLE JobCategories
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
  JobCategoryID,
  CategoryName
);

LOAD DATA INFILE '/Users/tph/Desktop/SQL/Final Project/CSV Data/Departments.csv'
INTO TABLE Departments
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
  DepartmentID, 
  CompanyID,
  DepartmentName
);

LOAD DATA INFILE '/Users/tph/Desktop/SQL/Final Project/CSV Data/Employees.csv'
INTO TABLE Employees
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
  EmployeeID,
  FirstName,
  LastName,
  Position,
  CompanyID
);

#The columns: ENUM, DATE, and INT, an empty or invalid string caused errors
#(e.g., “Incorrect integer value,” “Data truncated,” etc.).

#Therefore, reading CSV fields into user variables (e.g., @DOB, @EdLevelVal) first
#Then, clean or transform them in the SET clause before actually inserting into the table.

LOAD DATA INFILE '/Users/tph/Desktop/SQL/Final Project/CSV Data/Candidates.csv'
INTO TABLE Candidates
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
  @CandidateID,
  @FirstName,
  @LastName,
  @DOB,
  @Gender,
  @Email,
  @Phone,
  @ExpYears,
  @EdLevelVal,
  @CV,
  @EligibleVal,
  @Ethnicity,
  @Disability,
  @EmpID,
  @LinkedInLink
)
SET
  CandidateID=@CandidateID,
  FirstName=@FirstName,
  LastName=@LastName,
  DateOfBirth=NULLIF(@DOB, ''),
  Gender=@Gender,
  Email=@Email,
  Phone=@Phone,
  ExperienceYears=NULLIF(@ExpYears, ''),
  EducationLevel=CASE 
    WHEN TRIM(@EdLevelVal) IN ('Associate','High School','Bachelor','Master','PhD')
      THEN TRIM(@EdLevelVal)
    ELSE 'Bachelor'  -- fallback default
  END,
  CV= @CV,
  EligibleToWork=CASE
    WHEN TRIM(@EligibleVal) = 'Yes' THEN 'Yes'
    WHEN TRIM(@EligibleVal) = 'No'  THEN 'No'
    ELSE 'No'  #Default to 'No' for any invalid/missing values
  END,
  Ethnicity=@Ethnicity,
  Disability=@Disability,
  EmployeeID=NULLIF(@EmpID, ''),
  LinkedInLink=@LinkedInLink
;

LOAD DATA INFILE '/Users/tph/Desktop/SQL/Final Project/CSV Data/JobListings.csv'
INTO TABLE JobListings
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
  @JobID,
  @JobTitle,
  @Description,
  @StatusVal,
  @JobTypeVal,
  @Location,
  @JobCategoryID,
  @DepartmentID
)
SET
  JobID=@JobID,
  JobTitle=@JobTitle,
  Description=@Description,
  Status=CASE
    WHEN TRIM(@StatusVal) = 'Active' THEN 'Active'
    WHEN TRIM(@StatusVal) = 'Closed' THEN 'Closed'
    ELSE 'Active'
  END,
  JobType=CASE
    WHEN TRIM(@JobTypeVal) IN ('Full-time','Part-time','Contract') 
      THEN TRIM(@JobTypeVal)
    ELSE 'Full-time'
  END,
  #Convert empty strings to NULL for numeric columns
  JobCategoryID = NULLIF(@JobCategoryID, ''),
  DepartmentID  = NULLIF(@DepartmentID, '');
  
LOAD DATA INFILE '/Users/tph/Desktop/SQL/Final Project/CSV Data/CandidateSkills.csv'
INTO TABLE CandidateSkills
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
  CandidateID,
  SkillID
);

LOAD DATA INFILE '/Users/tph/Desktop/SQL/Final Project/CSV Data/JobSkills.csv'
INTO TABLE JobSkills
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
  JobID,
  SkillID
);

LOAD DATA INFILE '/Users/tph/Desktop/SQL/Final Project/CSV Data/CompanyRecruiters.csv'
INTO TABLE CompanyRecruiters
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
  CompanyID,
  RecruiterID
);

LOAD DATA INFILE '/Users/tph/Desktop/SQL/Final Project/CSV Data/Applications.csv'
INTO TABLE Applications
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
  @ApplicationID,
  @CandidateID,
  @JobID,
  @ApplicationDate,
  @StatusVal,
  @Deadline
)
SET
  ApplicationID=@ApplicationID,
  CandidateID=@CandidateID,
  JobID=@JobID,
  ApplicationDate=NULLIF(@ApplicationDate, ''), 
  Status=CASE
    WHEN TRIM(@StatusVal) IN ('Pending','Interview Scheduled','Accepted','Rejected')
      THEN TRIM(@StatusVal)
    ELSE 'Pending'   #fallback
  END,
  Deadline= NULLIF(@Deadline, '')
;


LOAD DATA INFILE '/Users/tph/Desktop/SQL/Final Project/CSV Data/Interviews.csv'
INTO TABLE Interviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
  @InterviewID,
  @ApplicationID,
  @InterviewDate,
  @InterviewTimeVal,
  @InterviewMode,
  @InterviewScore
)
SET
  InterviewID=@InterviewID,
  ApplicationID=@ApplicationID,
  InterviewDate=NULLIF(@InterviewDate, ''),    
  InterviewTime=STR_TO_DATE(@InterviewTimeVal, '%h:%i %p'), 
    #e.g. "10:00 AM" -> 10:00:00
  InterviewMode  = @InterviewMode,
  InterviewScore = NULLIF(@InterviewScore, '');


LOAD DATA INFILE '/Users/tph/Desktop/SQL/Final Project/CSV Data/Salaries.csv'
INTO TABLE Salaries
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
  @SalaryID,
  @JobID,
  @ExpLevelVal,   #read ExperienceLevel into a variable
  @SalaryVal,
  @PayTypeVal
)
SET
  SalaryID=@SalaryID,
  JobID=@JobID,
  ExperienceLevel=CASE
    WHEN TRIM(@ExpLevelVal) IN ('Junior','Mid','Senior')
      THEN TRIM(@ExpLevelVal)
    ELSE 'Junior'  #fallback
  END,
  Salary= NULLIF(@SalaryVal, ''),
  PayType=CASE
    WHEN TRIM(@PayTypeVal) IN ('Monthly','Biweekly','Yearly')
      THEN TRIM(@PayTypeVal)
    ELSE 'Monthly'
  END;

LOAD DATA INFILE '/Users/tph/Desktop/SQL/Final Project/CSV Data/JobReviews.csv'
INTO TABLE JobReviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
  ReviewID,
  ApplicationID,
  SatisfactionLevel,
  Comments
);




