# Filter-Data

Introduction:
This Perl script is a custom data filtering engine that allows users to extract highly specific rows from multiple CSV files. Based on multi-level filtering criteria.

Depending on your use case, you may need to filter your export data before sharing it with the client, and currently these exports can be made up of multiple files per hour. The script below can be used to combine all .csv files and filter based on any combination of levels/slicers, particularly helpful for when the files are too large to open in excel. 

What It Does:
- Merges multiple CSV files into one consolidated dataset (temp_file) for processing.
- Prompts the user to enter filter values across six dimensions:
    Column 1, Column 2, Column 3, Column 4, Column 5, Column 6.
- Any combination of these fields can be used.
- Scans and parses the merged dataset, comparing each row’s values against the user’s inputs.
- Matches rows based on defined combinations (from one to six field matches) and stores the results in new_file.csv.
- Outputs statistics on how many entries were scanned, how many matched, and confirms file creation.
- Cleans up temp files after processing.

Why It’s Impressive:
1: Handles dozens of filter combinations (from single-field to full six-field filtering logic).
2: Supports ad-hoc, user-defined filtering via a simple CLI.
3: Incorporates data validation, file handling, and cleanup in a seamless pipeline.
4: Useful for prepping adtech campaign data, analytics inputs, or ETL tasks.

Steps To Run The Script: 
1: Download all .csv files from your export in to a single folder
2: Download the script filter-data.pl and place in the folder containing your .csv files
3: Open up terminal, go to designated directory and type the following

chmod 755 filter-data.pl

This command is used to make the perl script executable. It is only needed on the initial download.
To process the script each time, run the the following command.

perl filter-data.pl

The script will process all .csv reports and return save the match entries within file 'new_file.csv'

Script Conditions:
- All reports are required to be format .csv
- The first line of the report will need to be it's title:
- The remaining fields can be of any type.
