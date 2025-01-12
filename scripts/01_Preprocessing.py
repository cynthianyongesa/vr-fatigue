# Import essential libraries
import pandas as pd
import os

# Set the base directory path
base_dir = "ENTER/FILE/PATH"
file_path = os.path.join(base_dir, "RAW_DATA.xls")

# Load the Excel file with multiple sheets
excel_data = pd.ExcelFile(file_path)

# Load each sheet into a separate DataFrame
raw_df = pd.read_excel(file_path, sheet_name='Raw Data')
nasa_df = pd.read_excel(file_path, sheet_name='NASA')
ssc_df = pd.read_excel(file_path, sheet_name='SSC')
rpe_df = pd.read_excel(file_path, sheet_name='RPE')

# Define a function to clean the data
def clean_dataframe(df):
    df = df.copy()  # Avoid SettingWithCopyWarning
    df.sort_values(by=['assess_track_record_id', 'redcap_event_name'], inplace=True)
    df['ref_assigned_group'] = df.groupby('assess_track_record_id')['ref_assigned_group'].ffill()
    group_mapping = {1.0: 'VR + Bike', 2.0: 'VR Only', 3.0: 'Bike Only'}
    df['assigned_group'] = df['ref_assigned_group'].map(group_mapping)
    df = df[~df['redcap_event_name'].str.startswith('randomization')]
    df.loc[:, 'week'] = df['redcap_event_name'].str.extract(r'week_(\d+)').astype(float)
    df = df.dropna(subset=['week'])
    df.sort_values(by=['assigned_group', 'assess_track_record_id', 'week'], inplace=True)
    return df

# Clean SSC and RPE datasets
nasa_df = clean_dataframe(nasa_df)
ssc_df = clean_dataframe(ssc_df)
rpe_df = clean_dataframe(rpe_df)

# Export the cleaned DataFrames to separate Excel files
nasa_df.to_excel(os.path.join(base_dir, "CLEANED_NASA_DATA.xlsx"), index=False)
ssc_df.to_excel(os.path.join(base_dir, "CLEANED_SSC_DATA.xlsx"), index=False)
rpe_df.to_excel(os.path.join(base_dir, "CLEANED_RPE_DATA.xlsx"), index=False)

print("DataFrames have been cleaned and exported successfully.")
