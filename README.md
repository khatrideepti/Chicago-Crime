# Chicago-Crime
Analysis of Chicago Crime in R and Tableau 
PROBLEM
There has an abundance of crimes committed on a daily basis in Chicago, one of the most populated states in the United States. In this project, we use Chicago Crime dataset which reflects reported incidents of crime that occurred in the City of Chicago from 2012 to 2016. Our goal is to help the Chicago police department and local public by identifying the most occurring crimes, observe the trend over the years, and find the highly prone crime areas.
METHODS USED
The methods used focus on cleaning the data followed by preliminary analysis, comprising temporal and spatial analysis. Also, the data contains mostly categorical variables, so multi class classification techniques are used for predictive modelling which predicts the crime type.
RESULTS OBTAINED
Our analysis mainly focuses on temporal and spatial visualization along with finding a suitable model to predict the primary crime type.
MATERIALS AND METHODS
DATASET DESCRIPTION
Our dataset is taken from Kaggle website() spanning five years of data. It contains around a million records and 23 columns.
1. unique_id: - Unique identifier for the record.
2. date: - Date when the incident occurred. this is sometimes a best estimate.
3. primary_type: - The primary description of the IUCR code.
4. description: - The secondary description of the IUCR code, a subcategory of the primary description.
5. loc_desc: - Description of the location where the incident occurred.
6. arrest: - Indicates whether an arrest was made.
7. beat: - Indicates the beat where the incident occurred. A beat is the smallest police geographic area – each beat has a dedicated police beat car. Three to five beats make up a police sector, and three sectors make up a police district. The Chicago Police Department has 22 police districts.
8. district: - Indicates the police district where the incident occurred.
9. ward: - The ward (City Council district) where the incident occurred.
10. community_area: - Indicates the community area where the incident occurred. Chicago has 77 community areas.
11. year: - Year the incident occurred.
12. latitude: - The latitude of the location where the incident occurred.
13. longitude: - The longitude of the location where the incident occurred.
14. location: - The location where the incident occurred in a format that allows for creation of maps and other geographic operations on this data portal.
TOOLS AND TECHNIQUES
The methods used to build the model are based on predictive modelling and exploratory analysis.
DATA PRE-PROCESSING
The Steps used for data pre-processing are as follows: -
• Removed 2017 data since it was incomplete.
• Feature Extraction: Date column categorised into morning, afternoon, evening and night.
• Feature Grouping: Crimes types into crime categories.
• Removed missing values from latitude and longitude columns.
• Dropped unused levels from Primary Type
• Categorized crimes into Violence and Non - Violence and location description by using “%n%” method.
• Using POSIX function to transform the datetime into standard format
EXPLORATORY ANALYSIS
• Performed Spatial analysis using Leaflet to visualize crime hotspots and its data on interactive maps.
• Temporal analysis was performed to see the crime patterns through the day using plots and graphs.
PREDICITVE MODELLING
Based on the preliminary findings, the problem reduced to a classification problem to predict the primary crime type. The various methods we used for predictive modelling are Multinomial Logistic Regression, Random Forest and Support Vector Machines.
TOOLS USED
R and Tableau.
