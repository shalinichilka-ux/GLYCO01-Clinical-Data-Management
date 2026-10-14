-- SYNTHETIC Pharmacovigilance ICSR Case Processing Simulation
-- CSV must first be imported to MySQL table pv_portfolio.pv_cases.
-- These are descriptive exercises, not clinical causality or signal analysis.
CREATE DATABASE IF NOT EXISTS pv_portfolio;
USE pv_portfolio;

-- 1. Minimum ICSR elements
SELECT COUNT(*) AS intake_records,
       SUM(CASE WHEN Valid_ICSR='Yes' THEN 1 ELSE 0 END) AS candidate_valid_icsrs,
       SUM(CASE WHEN Valid_ICSR='No' THEN 1 ELSE 0 END) AS incomplete_reports
FROM pv_cases;

-- 2. Case-record counts by suspected product
SELECT Suspect_Drug, COUNT(*) AS case_records
FROM pv_cases
GROUP BY Suspect_Drug ORDER BY case_records DESC;

-- 3. Serious-flagged candidate cases
SELECT Suspect_Drug, Seriousness_Criterion, COUNT(*) AS case_records
FROM pv_cases
WHERE Valid_ICSR='Yes' AND Serious_Flag='Yes'
GROUP BY Suspect_Drug, Seriousness_Criterion
ORDER BY case_records DESC;

-- 4. Severe symptoms with no documented serious criteria
SELECT Case_ID, Suspect_Drug, AE_Term_Illustrative, Severity, Serious_Flag
FROM pv_cases
WHERE Severity='Severe' AND Serious_Flag='No';

-- 5. Reaction categories (not incidence or event episodes)
SELECT AE_Term_Illustrative, COUNT(*) AS case_records
FROM pv_cases
WHERE Valid_ICSR='Yes' AND AE_Term_Illustrative <> ''
GROUP BY AE_Term_Illustrative ORDER BY case_records DESC;

-- 6. Missing any of the four minimum elements
SELECT Case_ID, Reporter_Identifiable, Patient_Identifiable,
       Drug_Identified, AE_Identified, Triage_Priority
FROM pv_cases WHERE Valid_ICSR='No';

-- 7. Additional data gaps
SELECT SUM(CASE WHEN Event_Onset_Date IS NULL OR Event_Onset_Date='' THEN 1 ELSE 0 END) AS missing_onset,
       SUM(CASE WHEN Outcome IS NULL OR Outcome='' THEN 1 ELSE 0 END) AS missing_outcome,
       SUM(CASE WHEN Indication IS NULL OR Indication='' THEN 1 ELSE 0 END) AS missing_indication
FROM pv_cases;

-- 8. Outcome distribution
SELECT Outcome, COUNT(*) AS case_records
FROM pv_cases
GROUP BY Outcome ORDER BY case_records DESC;
