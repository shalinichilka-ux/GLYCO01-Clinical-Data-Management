# Pharmacovigilance | ICSR Case Processing & Safety Review

## Project overview
An independent **educational simulation** of individual case safety report (ICSR) intake, minimum-validity screening, seriousness triage, adverse event data review, follow-up query management, case narratives, and descriptive safety analysis.

**Data are 100% synthetic and fictional.** This project is not real case-processing employment experience, a regulatory submission, validated MedDRA coding, or evidence of clinical causality.

## Dataset at a glance
- **36** fictional spontaneous-report intake records.
- **32** potential ICSRs meeting the four minimum data elements; **4** incomplete reports requiring follow-up.
- **6** serious-flagged valid candidate cases requiring clinical review.
- **16** logged training queries (**14 open**, **2 illustrative closed**).
- Example suspect products: amoxicillin, ibuprofen, metformin, and cetirizine. Listed drugs do **not** imply proven causality.

## Simulated process
1. **Intake:** capture reporter wording, suspect product, reaction, patient and report details.
2. **Minimum ICSR validity:** check identifiable patient, identifiable reporter, suspect medicinal product, and suspected adverse reaction.
3. **Triage:** separately review **seriousness** (regulatory criteria) and **severity** (intensity).
4. **Completeness review:** identify missing event onset, outcome, indication, and other data gaps.
5. **Source queries:** document follow-up questions, priority, and open/closed status without inventing missing data.
6. **Narrative writing:** draft concise fictional case summaries and note limitations.
7. **SQL review:** use MySQL for case counts, validity, serious flags, and missing-data screening.

## Project files
| File | Description |
| --- | --- |
| `PV_Synthetic_ICSR_Cases.csv` | 36 synthetic case-intake rows and calculated flags |
| `PV_Query_Log.csv` | 16 fictional follow-up queries and status |
| `PV_Analysis.sql` | 8 MySQL screening and summary queries |
| `CASE_NARRATIVES.md` | Three illustrative ICSR narratives |

A separate Excel practice workbook was prepared for the learner but is not included in this folder. The personal study PDF is **intentionally not published**.

## How to reproduce
Import `PV_Synthetic_ICSR_Cases.csv` into MySQL as `pv_portfolio.pv_cases` and run `PV_Analysis.sql`. Or review the CSV case fields and case-specific queries in Excel.

## Safety and integrity limitations
- These are **case-record counts**, not incidence, prevalence, confirmed signals, or exposure-adjusted rates.
- Seriousness is not equivalent to severe intensity.
- Illustrative event labels are not verified standard terminology / licensed MedDRA coding.
- No regulatory deadlines or expedited reporting determinations are represented.
- No real patient identifiers or genuine reports are present.

**Portfolio skills:** PV case intake, ICSR minimum-elements screening, seriousness triage, data query management, case narratives, Excel/CSV, SQL, documentation.
