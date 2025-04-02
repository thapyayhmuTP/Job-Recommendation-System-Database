CREATE DATABASE `Jobs` DEFAULT CHARACTER SET utf8mb4;
USE Jobs;

CREATE TABLE Companies (
    CompanyID INT AUTO_INCREMENT PRIMARY KEY,
    RegistrationNumber VARCHAR(50) NOT NULL UNIQUE,
    CompanyName VARCHAR(255) NOT NULL,
    NoOfEmployees INT,
    Location VARCHAR(255),
    HiringProcess VARCHAR(255),
    Email VARCHAR(255),
    URL VARCHAR(255)
);

CREATE TABLE Skills (
    SkillID INT PRIMARY KEY AUTO_INCREMENT,
    SkillName VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Recruiters (
    RecruiterID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    SocialLink VARCHAR(255)
);

CREATE TABLE JobCategories (
    JobCategoryID INT PRIMARY KEY AUTO_INCREMENT,
    CategoryName VARCHAR(100) NOT NULL UNIQUE
);

#A company can have multiple departments
CREATE TABLE Departments (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    CompanyID INT NOT NULL,
    DepartmentName VARCHAR(255) NOT NULL,
    FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Position VARCHAR(100),
    CompanyID INT,
    FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID)
);

CREATE TABLE Candidates (
    CandidateID VARCHAR(10) PRIMARY KEY,  #Alphanumeric PK
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    DateOfBirth DATE,
    Gender VARCHAR(10),
    Email VARCHAR(255) NOT NULL UNIQUE,
    Phone VARCHAR(20),
    ExperienceYears INT,
    EducationLevel ENUM('Associate','High School', 'Bachelor', 'Master', 'PhD'),
    CV TEXT,
    EligibleToWork ENUM('Yes','No') NOT NULL DEFAULT 'No',
    Ethnicity VARCHAR(100),
    Disability VARCHAR(100),
    EmployeeID INT DEFAULT NULL,  #Nullable to accommodate external candidates
    LinkedInLink VARCHAR(255),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE JobListings (
    JobID VARCHAR(10) PRIMARY KEY,   #Alphanumeric PK
    JobTitle VARCHAR(255) NOT NULL,
    Description TEXT,
    Status ENUM('Active', 'Closed') NOT NULL DEFAULT 'Active',
    JobType ENUM('Full-time', 'Part-time', 'Contract') NOT NULL,
    Location VARCHAR(255),
    JobCategoryID INT,
    DepartmentID INT,
    FOREIGN KEY (JobCategoryID) REFERENCES JobCategories(JobCategoryID),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Applications (
    ApplicationID VARCHAR(10) PRIMARY KEY,  #Alphanumeric PK
    CandidateID VARCHAR(10),               #Must match the type in Candidates
    JobID VARCHAR(10),                     #Must match the type in JobListings
    ApplicationDate DATE,
    Status ENUM('Pending', 'Interview Scheduled', 'Accepted', 'Rejected') 
        NOT NULL DEFAULT 'Pending',
    Deadline DATE,
    FOREIGN KEY (CandidateID) REFERENCES Candidates(CandidateID),
    FOREIGN KEY (JobID) REFERENCES JobListings(JobID)
);

CREATE TABLE Interviews (
    InterviewID INT PRIMARY KEY AUTO_INCREMENT,
    ApplicationID VARCHAR(10),  #Must match the type in Applications
    InterviewDate DATE,
    InterviewTime TIME,
    InterviewMode VARCHAR(50),
    InterviewScore DECIMAL(5,2),
    FOREIGN KEY (ApplicationID) REFERENCES Applications(ApplicationID)
);

CREATE TABLE CandidateSkills (
    CandidateID VARCHAR(10),
    SkillID INT,
    PRIMARY KEY (CandidateID, SkillID),
    FOREIGN KEY (CandidateID) REFERENCES Candidates(CandidateID),
    FOREIGN KEY (SkillID) REFERENCES Skills(SkillID)
);

CREATE TABLE JobSkills (
    JobID VARCHAR(10),
    SkillID INT,
    PRIMARY KEY (JobID, SkillID),
    FOREIGN KEY (JobID) REFERENCES JobListings(JobID),
    FOREIGN KEY (SkillID) REFERENCES Skills(SkillID)
);

#Each job can have multiple pay ranges depending on the experience level.
#For Simplicity, gonna use fixed-range here
CREATE TABLE Salaries (
    SalaryID INT AUTO_INCREMENT PRIMARY KEY,
    JobID VARCHAR(10) NOT NULL,  #Must match the type in JobListings
    ExperienceLevel ENUM('Junior', 'Mid', 'Senior') NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    PayType ENUM('Monthly', 'Biweekly', 'Yearly') NOT NULL,
    FOREIGN KEY (JobID) REFERENCES JobListings(JobID)
);

#Only candidates who applied can review
CREATE TABLE JobReviews (
  ReviewID INT AUTO_INCREMENT PRIMARY KEY,
  ApplicationID VARCHAR(10) NOT NULL,  #Must match the type in Applications
  SatisfactionLevel TINYINT CHECK (SatisfactionLevel BETWEEN 1 AND 5),
  Comments TEXT,
  FOREIGN KEY (ApplicationID) REFERENCES Applications(ApplicationID)
);

CREATE TABLE CompanyRecruiters (
    CompanyID INT,
    RecruiterID INT,
    PRIMARY KEY (CompanyID, RecruiterID),
    FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID),
    FOREIGN KEY (RecruiterID) REFERENCES Recruiters(RecruiterID)
);