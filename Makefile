report.html: report.Rmd code/03_render_report.R output/Serotype_breakdown.png output/map.png 
	Rscript code/03_render_report.R
	
output/Serotype_breakdown.png: code/01_make_table.R data/mex_admbnda_adm1_govmex_20210618.shp data/Simulated_Dengue_Data.shp
	Rscript code/01_make_table.R
	
output/map.png: code/02_make_map.R data/Simulated_Dengue_Data.shp
	Rscript code/02_make_map.R
	
.PHONY: clean
clean:
	rm -f output/* && rm -f report.html