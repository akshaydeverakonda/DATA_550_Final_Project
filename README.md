#Dengue report 

This project will generate an html report summarizing dengue cases in Mexico that occurred in 2023.

##Code description

`code/01_make_table.R`
-This code uses, from the "data" folder, shapefiles of Mexico state boundary data and of 2023 dengue case data (including geographic coordinates and the serotype of each case).
-The code constructs a table showing how many cases of each serotype were recorded in each state. 
-The code then saves this table as "Serotype_breakdown.png" in the "output" folder.

`code/02_make_map.R`
-This code takes the shapefiles of Mexico state boundary data and of 2023 dengue case data, both from the "data" folder, and plots a map of Mexico showing cases within each state
-The code then saves this map as "map.png" figure in the "output" folder.
-The cases are color coded differently according to serotype.

`code/03_render_report.R`
-This code takes the outputted table and map from the other two sections of code and creates a report with them.
-The final report is saved as "report.html" in the project directory

'Makefile'
-The makefile contains the rules for creating the table, map, and final report
-If the user runs the "make report.html" rule, that will create the report.html output in the project directory.
-Additional rules for creating the table and map of dengue case data are listed; thee outputs are the prerequisites for making the report.
-There is a rule "clean" for clearing the output folder and deleting the report from the project directory. 







