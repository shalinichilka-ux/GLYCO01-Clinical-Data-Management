-- GLYCO-01 | All 10 analyses used in MySQL Workbench
-- Source: synthetic study. Table: cdm_project.clinical_visits_600
-- Execute one SELECT at a time or run all to see separate result sets.

-- Analysis 1: Treatment-group allocation
-- Question: How many unique subjects belong to each treatment group?
SELECT Treatment_Group,
       COUNT(DISTINCT Subject_ID) AS Total_Subjects
FROM cdm_project.clinical_visits_600
GROUP BY Treatment_Group;

-- Analysis 2: Visit-wise record counts
-- Question: Are Baseline, Week 4, Week 8 and Week 12 represented?
SELECT Visit,
       COUNT(*) AS Total_Records
FROM cdm_project.clinical_visits_600
GROUP BY Visit;

-- Analysis 3: HbA1c change at Week 12
-- Question: What is the descriptive Week 12 HbA1c change in each treatment arm?
SELECT
    Treatment_Group,
    ROUND(AVG(HbA1c_Baseline), 2) AS Avg_Baseline,
    ROUND(AVG(HbA1c_Current), 2) AS Avg_Week12,
    ROUND(AVG(HbA1c_Current - HbA1c_Baseline), 2) AS Avg_Change
FROM cdm_project.clinical_visits_600
WHERE Visit = 'Week 12'
  AND HbA1c_Current BETWEEN 4 AND 15
GROUP BY Treatment_Group;

-- Analysis 4: Adverse-event visit records by arm
-- Question: How many visit records mention an adverse event in each treatment arm?
SELECT
    Treatment_Group,
    COUNT(*) AS Total_Records,
    SUM(CASE
        WHEN Adverse_Event <> 'None'
             AND Adverse_Event IS NOT NULL
             AND Adverse_Event <> ''
        THEN 1 ELSE 0
    END) AS AE_Records
FROM cdm_project.clinical_visits_600
GROUP BY Treatment_Group;

-- Analysis 5: Serious adverse-event flags
-- Question: How many rows have Serious_AE set to Yes for each arm?
SELECT
    Treatment_Group,
    COUNT(*) AS Total_Records,
    SUM(CASE
        WHEN Serious_AE = 'Yes'
        THEN 1
        ELSE 0
    END) AS Serious_AE_Records
FROM cdm_project.clinical_visits_600
GROUP BY Treatment_Group;

-- Analysis 6: Types and frequency of adverse events
-- Question: Which adverse-event terms occur most frequently?
SELECT
    Adverse_Event,
    COUNT(*) AS AE_Frequency
FROM cdm_project.clinical_visits_600
WHERE Adverse_Event <> 'None'
  AND Adverse_Event IS NOT NULL
  AND TRIM(Adverse_Event) <> ''
GROUP BY Adverse_Event
ORDER BY AE_Frequency DESC;

-- Analysis 7: Missing clinical values
-- Question: How many visit dates and current HbA1c results are missing?
SELECT
    COUNT(*) AS Total_Records,

    SUM(CASE
        WHEN Visit_Date IS NULL
          OR TRIM(CAST(Visit_Date AS CHAR)) = ''
        THEN 1 ELSE 0
    END) AS Missing_Visit_Dates,

    SUM(CASE
        WHEN HbA1c_Current IS NULL
        THEN 1 ELSE 0
    END) AS Missing_HbA1c
FROM cdm_project.clinical_visits_600;

-- Analysis 8: Site-wise visit and subject counts
-- Question: How are visit records and unique subjects distributed by Site_ID and city?
SELECT
    Site_ID,
    Site_City,
    COUNT(*) AS Total_Records,
    COUNT(DISTINCT Subject_ID) AS Total_Subjects
FROM cdm_project.clinical_visits_600
GROUP BY Site_ID, Site_City
ORDER BY Site_ID;

-- Analysis 9: Data-entry status / pending review
-- Question: How many rows are marked Complete or Pending Review?
SELECT
    Data_Entry_Status,
    COUNT(*) AS Total_Records
FROM cdm_project.clinical_visits_600
GROUP BY Data_Entry_Status
ORDER BY Total_Records DESC;

-- Analysis 10: Protocol-deviation status review
-- Question: Which protocol-deviation field values occur, and are any nonstandard?
SELECT
    Protocol_Deviation,
    COUNT(*) AS Total_Records
FROM cdm_project.clinical_visits_600
GROUP BY Protocol_Deviation
ORDER BY Total_Records DESC;
