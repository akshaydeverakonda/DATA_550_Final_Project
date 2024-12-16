FROM rocker/rstudio AS base

RUN apt-get update && apt-get install -y pandoc

RUN apt-get update && apt-get install -y libcurl4-openssl-dev
RUN apt-get update && apt-get install -y curl
RUN apt-get update && apt-get install -y libxml2-dev
RUN apt-get update && apt-get install -y libudunits2-dev
RUN apt-get update && apt-get install -y libgdal-dev

RUN mkdir /home/rstudio/project

WORKDIR /home/rstudio/project

RUN mkdir -p renv
COPY renv.lock renv.lock
COPY .Rprofile .Rprofile
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/settings.json

RUN mkdir renv/.cache
ENV RENV_PATHS_CACHE = renv/.cache

RUN R -e "renv::restore()"
#Step 1

FROM adeverakonda/data_550:step1 AS final_step

RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt-get install -y ./google-chrome-stable_current_amd64.deb && \
    rm google-chrome-stable_current_amd64.deb
    
ENV CHROMOTE_CHROME=/usr/bin/google-chrome

WORKDIR /home/rstudio/project


COPY Makefile /home/rstudio/project/Makefile 
COPY Report.Rmd /home/rstudio/project/Report.Rmd

RUN mkdir /home/rstudio/project/code
RUN mkdir /home/rstudio/project/output
RUN mkdir /home/rstudio/project/data
RUN mkdir /home/rstudio/project/report

COPY code/01_make_table.R code/01_make_table.R
COPY code/02_make_map.R code/02_make_map.R
COPY code/03_render_report.R code/03_render_report.R

COPY data/mex_admbnda_adm1_govmex_20210618.CPG data/mex_admbnda_adm1_govmex_20210618.CPG
COPY data/mex_admbnda_adm1_govmex_20210618.dbf data/mex_admbnda_adm1_govmex_20210618.dbf
COPY data/mex_admbnda_adm1_govmex_20210618.prj data/mex_admbnda_adm1_govmex_20210618.prj
COPY data/mex_admbnda_adm1_govmex_20210618.sbn data/mex_admbnda_adm1_govmex_20210618.sbn
COPY data/mex_admbnda_adm1_govmex_20210618.sbx data/mex_admbnda_adm1_govmex_20210618.sbx
COPY data/mex_admbnda_adm1_govmex_20210618.shp data/mex_admbnda_adm1_govmex_20210618.shp
COPY data/mex_admbnda_adm1_govmex_20210618.shp.xml data/mex_admbnda_adm1_govmex_20210618.shp.xml
COPY data/mex_admbnda_adm1_govmex_20210618.shx data/mex_admbnda_adm1_govmex_20210618.shx

COPY data/Simulated_Dengue_Data.shx data/Simulated_Dengue_Data.shx
COPY data/Simulated_Dengue_Data.cpg data/Simulated_Dengue_Data.cpg
COPY data/Simulated_Dengue_Data.csv data/Simulated_Dengue_Data.csv
COPY data/Simulated_Dengue_Data.dbf data/Simulated_Dengue_Data.dbf
COPY data/Simulated_Dengue_Data.prj data/Simulated_Dengue_Data.prj
COPY data/Simulated_Dengue_Data.qmd data/Simulated_Dengue_Data.qmd
COPY data/Simulated_Dengue_Data.shp data/Simulated_Dengue_Data.shp

CMD make 


