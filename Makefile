#Report-associated rules (run within docker container)

report.html: Report.Rmd code/03_render_report.R output/Serotype_breakdown.png output/map.png 
	Rscript code/03_render_report.R
	
output/Serotype_breakdown.png: code/01_make_table.R data/mex_admbnda_adm1_govmex_20210618.shp data/Simulated_Dengue_Data.shp
	Rscript code/01_make_table.R
	
output/map.png: code/02_make_map.R data/Simulated_Dengue_Data.shp
	Rscript code/02_make_map.R
	
.PHONY: clean
clean:
	rm -f output/* && rm -f report.html && rm -f report/*
	
.PHONY: install
install:
	Rscript -e "renv::restore(prompt = FALSE)"
	
#Docker-associated rules (run on local machine)

PROJECTFILES = Report.Rmd code/01_make_table.R code/02_make_map.R code/03_render_report.R data/* Makefile
RENVFILES = renv.lock renv/activate.R renv/settings.json

#Rule to build image
data_550_f: Dockerfile $(PROJECTFILES) $(RENVFILES)
	docker build -t data_550_f . 
	touch $@ 

#Rule to build report automatically in container on Windows

windows/report/report.html: 
	docker run -v "/$$(pwd)/report":"/home/rstudio/project/report" adeverakonda/data550:step2
	
#Rule to build report automatically in container on Mac
mac/report/report.html:
	docker run -v "$$(pwd)/report":"/home/rstudio/project/report" adeverakonda/data550:step2

