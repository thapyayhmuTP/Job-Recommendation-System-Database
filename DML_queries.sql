Use Jobs;

#5.1 Adding New Candidates to the Database
INSERT INTO Candidates(CandidateID, FirstName, LastName, DateOfBirth, Gender, Email, Phone, ExperienceYears, EducationLevel, CV, Ethnicity, Disability, EmployeeID, LinkedInLink, EligibleToWork) 
VALUES ('C1001', 'Alice', 'Johnson', '1998-07-15', 'Female', 'alice.johnson@gmail.com', '6471234567', 3, 'Master', 'https://cvstorage.com/alice_johnson.pdf', 'Caucasian', 'No', NULL, 'https://linkedin.com/in/alicejohnson', 'YES');

INSERT INTO Candidates (CandidateID, FirstName, LastName, DateOfBirth, Gender, Email, Phone, ExperienceYears, EducationLevel, CV, Ethnicity, Disability, EmployeeID, LinkedInLink, EligibleToWork) 
VALUES ('C1002', 'Michael', 'Carter', '1989-03-22', 'Male', 'michael.carter@gmail.com', '4169876543', 10, 'Bachelor', 'https://cvstorage.com/michael_carter.pdf', 'African American', 'No', NULL, 'https://linkedin.com/in/michaelcarter', 'YES');

INSERT INTO Candidates (CandidateID, FirstName, LastName, DateOfBirth, Gender, Email, Phone, ExperienceYears, EducationLevel, CV, Ethnicity, Disability, EmployeeID, LinkedInLink, EligibleToWork) 
VALUES ('C1003', 'Emma', 'Lee', '2002-11-05', 'Female', 'emma.lee@gmail.com', '9056543210', 0, 'Bachelor', 'https://cvstorage.com/emma_lee.pdf', 'Asian', 'No', NULL, 'https://linkedin.com/in/emmalee', 'YES');

INSERT INTO Candidates (CandidateID, FirstName, LastName, DateOfBirth, Gender, Email, Phone, ExperienceYears, EducationLevel, CV, Ethnicity, Disability, EmployeeID, LinkedInLink, EligibleToWork) 
VALUES ('C1004', 'Daniel', 'Martinez', '1994-06-18', 'Male', 'daniel.martinez@gmail.com', '6477891234', 6, 'Master', 'https://cvstorage.com/daniel_martinez.pdf', 'Hispanic', 'No', NULL, 'https://linkedin.com/in/danielmartinez', 'YES');

INSERT INTO Candidates (CandidateID, FirstName, LastName, DateOfBirth, Gender, Email, Phone, ExperienceYears, EducationLevel, CV, Ethnicity, Disability, EmployeeID, LinkedInLink, EligibleToWork) 
VALUES ('C1005', 'Sophia', 'White', '1996-02-10', 'Female', 'sophia.white@gmail.com', '6474567890', 5, 'Master', 'https://cvstorage.com/sophia_white.pdf', 'Caucasian', 'Yes', NULL, 'https://linkedin.com/in/sophiawhite', 'YES');

#5.2 Updating the Application Status
UPDATE Applications 
SET Status = 'Interview Scheduled' 
WHERE ApplicationID = 'B04DM';

UPDATE Applications 
SET Status = 'Accepted' 
WHERE ApplicationID = 'NXO1O';

UPDATE Applications 
SET Status = 'Rejected' 
WHERE ApplicationID = 'I6IZ9';

#5.3 Deleting Records with Foreign Key Handling
#Deleting Michel
ALTER TABLE Interviews 
ADD CONSTRAINT fk_application 
FOREIGN KEY (ApplicationID) REFERENCES Applications(ApplicationID) 
ON DELETE CASCADE;

ALTER TABLE JobReviews 
ADD CONSTRAINT fk_application_reviews 
FOREIGN KEY (ApplicationID) REFERENCES Applications(ApplicationID) 
ON DELETE CASCADE;

DELETE FROM Applications 
WHERE ApplicationID = 'Y7WZE';