# Filter-Data
This Perl script is a custom data filtering engine that allows users to extract highly specific rows from multiple CSV files based on multi-level filtering criteria.

What It Does:
Merges multiple CSV files into one consolidated dataset (temp_file) for processing.

Prompts the user to enter filter values across six dimensions: Level1, Level2, Level3, Level4, Slicer1, and Slicer2. Any combination of these fields can be used.

Scans and parses the merged dataset, comparing each row’s values against the user’s inputs.

Matches rows based on defined combinations (from one to six field matches) and stores the results in new_file.csv.

Outputs statistics on how many entries were scanned, how many matched, and confirms file creation.

Cleans up temp files after processing.

Why It’s Impressive:
Handles dozens of filter combinations (from single-field to full six-field filtering logic).

Supports ad-hoc, user-defined filtering via a simple CLI.

Incorporates data validation, file handling, and cleanup in a seamless pipeline.

Useful for prepping adtech campaign data, analytics inputs, or ETL tasks.
