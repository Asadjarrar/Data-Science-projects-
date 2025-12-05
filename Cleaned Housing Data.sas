PROC IMPORT OUT=data
    DATAFILE="/home/u64322725/sasuser.v94/global_housing_market_extended.csv"
    DBMS=CSV
    REPLACE;
    GETNAMES=YES; 
RUN;

*Check for missing values;

PROC MEANS data=data nmiss;
run;
PROC FREQ DATA=data;
    TABLE Country / MISSING;
RUN;
*no missing values found;

*mean mode average outliers;
proc univariate data=data;
run;



proc sgplot data=data;
    hbox 'GDP Growth (%)'n;
run;
proc sgplot data=data;
    hbox 'Mortgage Rate (%)'n;
run;
proc sgplot data=data;
    hbox 'Inflation Rate (%)'n;
run;
proc sgplot data=data;
    hbox 'Construction Index'n;
run;
proc sgplot data=data;
    hbox 'Population Growth (%)'n;
run;
proc sgplot data=data;
    hbox 'Urbanization Rate (%)'n;
run;
proc sgplot data=data;
    hbox 'Affordability Ratio'n;
run;
proc sgplot data=data;
    hbox 'Rent Index'n;
run;
proc sgplot data=data;
    hbox 'House Price Index'n;
run;

* no outliers were found;


* add new variable;

DATA enhanced_data;
    SET data;
    'Real Growth Rate'n = 'GDP Growth (%)'n - 'Inflation Rate (%)'n;  /* higher is better */
    'Housing Deman/Build Ratio'n = 'House Price Index'n / 'Construction Index'n; /* lower is better */
RUN;


proc print data=enhanced_data;
run;

/* export csv */
PROC EXPORT DATA=enhanced_data
    OUTFILE="/home/u64322727/sasuser.v94/cleaned_housing_data.csv"
    DBMS=CSV
    REPLACE;
RUN;
