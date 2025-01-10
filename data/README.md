# 📂 Data Directory

This folder contains all datasets used in the **VR-Fatigue** study, organized into raw and processed formats for clarity and reproducibility.

---

## 📁 Folder Structure

data/ 
├── raw/ # Original, unmodified data files 
│ └── RAW_DATA_2025-01-10_1230.csv 
├── processed/ # Cleaned and preprocessed datasets for analysis 
└── README.md # Data dictionary and file descriptions

 
---

## 📄 File Descriptions

### **`raw/803273EnrolledPartic-NASA_DATA_LABELS_2025-01-10_1230.csv`**  
- **Description:** Original dataset containing participant data collected across three intervention arms (VR-only, VR + Bike, Bike-only).  
- **Contents:**  
  - Participant IDs  
  - Group assignments  
  - NASA-TLX workload scores  
  - Borg RPE scores (pre- and post-session)  
  - Short Symptom Checklist (SSC) scores (pre- and post-session)  
  - Timepoints across 16 or 48 sessions depending on the group  
  - Demographic information (age, sex, education)  
- **Status:** *Raw data, unaltered*  

### **`processed/`**  
- **Description:** Contains cleaned and preprocessed datasets ready for analysis.  
- **Examples of processed files:**  
  - `cleaned_nasa_tlx.csv`: Cleaned NASA-TLX data for all arms.  
  - `rpe_vr_bike.csv`: RPE data for VR + Bike and Bike-only groups.  
  - `ssc_vr_groups.csv`: SSC data for VR-only and VR + Bike groups.

---

## 📖 Data Dictionary

| **Column Name**                                 | **Description**                                               | **Data Type**  | **Applies to Group**               |
|-------------------------------------------------|---------------------------------------------------------------|----------------|-----------------------------------|
| `Record ID`                                     | Unique identifier for each record                             | String         | All groups                        |
| `Participant ID`                                | Unique participant identifier                                 | String         | All groups                        |
| `Assigned Group`                                | Group assignment (VR-only, VR + Bike, Bike-only)              | String         | All groups                        |
| `Mental Demand Rating Score`                    | NASA-TLX Mental Demand score (0-100)                          | Float          | All groups                        |
| `Physical Rating Demand`                        | NASA-TLX Physical Demand score (0-100)                        | Float          | All groups                        |
| `Temporal Rating Demand`                        | NASA-TLX Temporal Demand score (0-100)                        | Float          | All groups                        |
| `Performance Rating`                            | NASA-TLX Performance score (0-100)                            | Float          | All groups                        |
| `Effort Rating`                                 | NASA-TLX Effort score (0-100)                                 | Float          | All groups                        |
| `Frustration Rating`                            | NASA-TLX Frustration score (0-100)                            | Float          | All groups                        |
| `Perceived Exertion (RPE) Score: *Before session` | Borg RPE score before session (6–20)                          | Float          | VR + Bike, Bike-only              |
| `Perceived Exertion (RPE) Score: *After session`  | Borg RPE score after session (6–20)                           | Float          | VR + Bike, Bike-only              |
| `Nausea`                                        | SSC Nausea rating (0–3)                                       | Integer        | VR-only, VR + Bike                |
| `Eye strain`                                     | SSC Eye Strain rating (0–3)                                   | Integer        | VR-only, VR + Bike                |
| `Dizziness with eyes closed`                     | SSC Dizziness rating (0–3)                                    | Integer        | VR-only, VR + Bike                |
| `Stomach Awareness`                              | SSC Stomach Awareness rating (0–3)                            | Integer        | VR-only, VR + Bike                |
| `Difficulty Focusing`                            | SSC Difficulty Focusing rating (0–3)                          | Integer        | VR-only, VR + Bike                |
| `General Discomfort`                             | SSC General Discomfort rating (0–3)                           | Integer        | VR-only, VR + Bike                |
| `Day X Date`                                     | Date when the session occurred                                 | Date (String)  | All groups                        |
| `Complete?`                                      | Indicates if the session was completed (`Complete`/`Incomplete`)| String         | All groups                        |

---

## 📌 Notes

- **Group-Specific Data Collection:**  
  - **NASA-TLX** was administered to *all three groups* at 16 timepoints.  
  - **Borg RPE** was only administered to the **VR + Bike** and **Bike-only** groups at 48 timepoints due to the physical exertion component.  
  - **SSC** was only administered to the **VR-only** and **VR + Bike** groups at 48 timepoints to assess simulator sickness, which was not relevant for the **Bike-only** group.  

- **Missing Data:**  
  Dropout rates and missing responses are documented and will be handled during data cleaning and analysis.

---

## 🔒 Data Usage Disclaimer

This dataset is part of the **VR-Fatigue** project and is intended for research purposes only. Please do not modify the files in the `raw/` folder. For reproducibility, all data cleaning and processing steps are documented in the provided Python scripts and notebooks.

---


