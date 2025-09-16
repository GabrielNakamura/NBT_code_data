

<!-- Please do not edit .md document. Instead use .qmd -->

# General overview

This repository contains the data and code used in the analysis of the
manuscript entitled **“The hidden biodiversity knowledge split in
biological collections”**.

# Context

Ecological and evolutionary processes generate biodiversity, yet how
biodiversity data are organized and shared globally can shape our
understanding of these processes. We show that name-bearing type
specimens—the primary reference for species identity—of all freshwater
and brackish fish species are predominantly housed in Global North
museums, disconnected from their countries of origin. This geographical
divide creates a ‘knowledge split’ with consequences for biodiversity
science, particularly in the Global South, where researchers face
barriers in studying native species’ name bearers housed abroad.
Meanwhile, Global North collections remain flooded with non-native name
bearers. We relate this imbalance to historical and socioeconomic
factors, which ultimately restricts access to critical taxonomic
reference materials and hinders global species documentation. To address
this disparity, we call for international initiatives to promote fairer
access to biological knowledge, including specimen repatriation,
improved accessibility protocols for researchers in countries where
specimens originated, and inclusive research partnerships.

# Repository structure

## data

This folder stores raw and processed data used to perform all the
analysis presented in this study

### raw

- `flow_period_region_country.csv` a data frame in the long format
  containing the flowing of NBT per regions per per time (50-year time
  frame). Variables:

  - `period` numeric variable representing 50-year time intervals

  - `region_type` character representing the name of the World Bank
    region of the country where the NBT was sourced

  - `country_type` character. A three letter code (alpha-3 ISO3166)
    representing the country of the museum where the NBT was sourced

  - `region_museum` character. Name of the World Bank region of the
    country where the NBT is housed

  - `country_museum` character. A three letter code (alpha-3 ISO3166)
    representing the country of the museum where the NBT is housed

  - `n` numeric. The number of NBT flowing from one country to another

- `spp_native_distribution.csv` data frame in the long format containing
  the native composition at the country level. Variables:

  - `valid_name` character. The name of a species in the format
    genus_epithet according to the Catalog of Fishes

  - `country_distribution` character. Three letter code (alpha-3
    ISO3166) indicating the name of the country where a species is
    native to

  - `region_distribution` character. The name of the region acording
    with World Bank where a species is native to

- `spp_type_distribution.csv` data frame in the long format containing
  the composition of NBT by country. Variables:

  - `valid_name` character. The name of a species in the format
    genus_epithet according to the Catalog of Fishes

  - `country_distribution` character. Three letter code (alpha-3
    ISO3166) indicating the name of the country where a species is
    housed

  - `region_distribution` character. The name of the region acording
    with World Bank where a species is housed

- `bio-dem_data.csv` data frame with data downloaded from
  [Bio-Dem](https://bio-dem.surge.sh/#awards) containing information on
  biological and social information at the country level. Variables:

  - `country` character. A three letter code (alpha-3 ISO3166)
    representing a country

  - `records` numeric. Total number of species occurrence records from
    Global Biodiverity Facility (GBIF)

  - `records_per_area` numeric. Records per area from gbif

  - `yearsSinceIndependence` numeric. Years since independence for each
    country

  - `e_migdppc` numeric. GDP per capta

- `museum_data.csv` data frame with museums’ acronyms and the world
  region of each. Variables:

  - `code_museum` character. The acronym (three letter code) of the
    museum

  - `country_museum` character. A three letter code (alpha-3 ISO3166)
    representing a country

  - `region_museum` character. The name of the region acording with
    World Bank

### processed

- `flow_region.csv` a data frame containing flowing of name bearers
  among world regions and the total number of name bearers derived from
  the source region

- `flow_period_region.csv` a data frame with the number of name bearers
  between the world regions per 50-year time frame and the total number
  of name bearers in each time frame for each world region

- `flow_period_region_prop.csv` a data frame with the number of name
  bearers, the Domestic Contribution and Domestic Retention between the
  world regions in a 50-year time frame - this is not used anymore in
  downstream analyses

- `flow_region_prop.csv` data with the total number of species flowing
  between world regions, Domestic Contribution and Domestic Retention -
  this is no longer used in downstream analyses

- `flow_country.csv` data frame with flowing information of name bearers
  among countries

- `df_country_native.csv` data frame with the number of native species
  at the country level

- `df_country_type.csv` data frame with the number of name bearers at
  the country level

- `df_all_beta.csv` data frame with values of endemic deficit and
  non-endemic representation at the country level

## R

The letters `D`, `A` and `V` represents scripts for, respectively, data
processing (D), data analysis (A) and results visualization (V). The
script sequence to reproduce the workflow is indicated by the numbers at
the beginning of the name of the script file.

![](scripts_diagram.png)

- [`01_D_data_preparation.qmd`](R/01_D_data_preparation.qmd) initial
  data preparation

- [`02_A_beta-endemics-countries.qmd`](R/02_A_beta-endemics-countries.qmd)
  analysis of beta diversity metrics. This script is used to calculate
  `turnover NBT` and `native NBT`

- [`03_D_data_preparation_models.qmd`](R/03_D_data_preparation_models.qmd)
  script used to build data frames that will be used in statistical
  models ([`04_A_model_NBTs.qmd`](R/04_A_model_NBTs.qmd))

- [`04_A_model_NBTs.qmd`](R/04_A_model_NBTs.qmd) statistical models for
  the total number of NBT, native and NBT turnover, Domestic
  Contribution and Domestic Retention

- [`05_V_chord_diagram_Fig1.qmd`](R/05_V_chord_diagram_Fig1.qmd) code
  used to produce circular flow diagram. This is the Figure 1 of the
  study

- [`06_V_world_map_Fig1.qmd`](R/06_V_world_map_Fig1.qmd) code used to
  produce the world map in the Figure 1 of the main text

<!-- -   [`07_V_scatterplot_Fig2.qmd`](R/07_V_scatterplot_Fig2.qmd) code used to reproduce the Figure 2 of the main text -->

- [07_V_beta_endemics_Fig2.qmd](R/07_V_beta_endemics_Fig2.qmd) code used
  to build Figure 3 of the main text

- [`08_V_model_Fig3.qmd`](R/08_V_model_Fig3.qmd) code used to build the
  Figure 4 of the main text. This is the representation of the results
  of the models present in the script
  [04_A_model_NBTs.qmd](R/04_A_model_NBTs.qmd)

- [`09_Supplementary_analysis.qmd`](R/09_Supplementary_analysis.qmd)
  code to produce all the tables and figures presented in the
  Supplementary material of this study

### functions

- [`function_beta_types_success_fail.R`](R/010_Functions.qmd) function
  used to calculate turnover metrics.

- [`function_scale_back.R`](R/010_Functions.qmd) function used to
  transform back normalized variables

### Summary stats

- [`011_Summary_stats.qmd`](R/011_Summary_stats.qmd)

## output

### Figures

In this folder you will find all figures used in the main text and
supplementary material of this study

`Fig1_flow_circle_plot.png` Figure with circular plots showing the flux
of NBT among regions of the world in a 50-year time window

<!-- `Fig2_DC_DR.png` Scaterplot with World regions characterized by their Domestic Contribution and Domestic Retention values in a 50-year time frame -->

`Fig2_turnover_metrics_endemics.png` Cartogram with 3 maps showing the
level of native endemic turnover, NBT turnover and the combination of
both metrics in a combined map

`Fig3_models.png` Figure showing the predictions of the number of NBT,
DC, DR, native turnover and NBT turnover for different predictors. This
is derived from the statistical models

#### Supp-material

This folder contains the figures in the Supplementary material

- `FigS1_native_richness.png` World map with countries coloured
  according to the number of native species richness according to the
  Catalog of Fishes

- `FigS2_scatterplot.png` All-time Domestic contribution (DC) and
  Domestic retention (DR) for world regions

- `FigS3_turnover_metrics.png` Cartogram with 3 maps showing the level
  of native turnover, NBT turnover and the combination of both metrics
  in a combined map

# Authors

Gabriel Nakamura, Lívia Estéfane F. Frateles, Bruno Henrique Mioto
Stabile, Mario R. Moura, Matheus Lima Araujo, Emanuel Neuhaus, Manoela
Maria Ferreira Marinho, Aline Richter, Liuyong Ding, Tiago Magalhães da
Silva Freitas, Bruno Eleres Soares, Weferson Júnio da Graça, José
Alexandre Felizola Diniz-Filho

# Contact

[Gabriel Nakamura](https://github.com/GabrielNakamura) and [Bruno
Mioto](https://github.com/brunomioto)

If you have any suggestion or commentary, please open an issue

# Session info

    R version 4.3.1 (2023-06-16 ucrt)
    Platform: x86_64-w64-mingw32/x64 (64-bit)
    Running under: Windows 11 x64 (build 26100)

    Matrix products: default


    locale:
    [1] LC_COLLATE=Portuguese_Brazil.utf8  LC_CTYPE=Portuguese_Brazil.utf8   
    [3] LC_MONETARY=Portuguese_Brazil.utf8 LC_NUMERIC=C                      
    [5] LC_TIME=Portuguese_Brazil.utf8    

    time zone: America/Sao_Paulo
    tzcode source: internal

    attached base packages:
    [1] stats     graphics  grDevices utils     datasets  methods   base     

    loaded via a namespace (and not attached):
     [1] compiler_4.3.1    fastmap_1.1.1     cli_3.6.1         tools_4.3.1      
     [5] htmltools_0.5.7   rstudioapi_0.15.0 yaml_2.3.7        rmarkdown_2.25   
     [9] knitr_1.45        jsonlite_1.9.0    xfun_0.41         digest_0.6.33    
    [13] rlang_1.1.2       evaluate_0.23    
