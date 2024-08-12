
<!-- Please do not edit .md document. Instead use .qmd -->

# General overview

This repository contains the data and code used in the analysis of the
manuscript entitled **“The macroecology of knowledge: Spatio-temporal
patterns of name-bearing types in biodiversity science”**.

In this study we characterized different aspects of spatial and temporal
patterns of fish Name Bearing Types (NBT) among countries and world
regions. The characteristics comprises the number of total NBT, the NBT
flowing among different world regions, the characteristics of regions
and countries regarding the source of NBT in their biological
collection, the level of underepresentation of native species and the
level of overepresentation of non-native species for each country.

We discuss how the fundamental knowledge in fish species is distributed
and its implications for science development and knowledge sharing.

# Repository structure

## data

This folder stores raw and processed data used to perform all the
analysis presented in this study

### raw

- `flow_period_region_country.csv` a data frame in the long format
  containing the flowing of NBT per regions per per time (50-year time
  frame)

- `spp_native_distribution.csv` data frame in the long format containing
  the native composition at the country level

- `spp_type_distribution.csv` data frame in the long format containing
  the composition of NBT by country

- `bio-dem_data.csv` data frame with data downloaded from
  [Bio-Dem](https://bio-dem.surge.sh/#awards) containing information on
  biological and social information at the country level

- `museum_data.csv` data frame with museums’ acronyms and the world
  region of each

### processed

- `flow_region.csv` a data frame containing flowing of NBT among world
  regions and the total number of NBT derived from the source region

- `flow_period_region.csv` a data frame with the number of NBT between
  the world regions per 50-year time frame and the total number of NBT
  in each time frame for each world region

- `flow_period_region_prop.csv` a data frame with the number of NBT, the
  Domestic Contribution and Domestic Retention between the world regions
  in a 50-year time frame

- `flow_region_prop.csv` data with the total number of species flowing
  between world regions, Domestic Contribution and Domestic Retention

- `flow_country.csv` data frame with flowing information of NBT among
  countries

- `df_country_native.csv` data frame with the number of native species
  at the country level

- `df_country_type.csv` data frame with the number of NBT at the country
  level

- `df_all_beta.csv` data frame with values of native and NBT turnover at
  the country level

## R

The letters `D`, `A` and `V` represents scripts for, respectively, data
processing (D), data analysis (A) and results visualization (V). The
script sequence to reproduce the workflow is indicated by the numbers at
the beginning of the name of the script file

- `01_D_data_preparation.qmd` initial data preparation

- `02_A_beta-countries.qmd` analysis of beta diversity metrics. This
  script is used to calculate `turnover NBT` and `native NBT`

- `03_D_data_preparation_models.qmd` script used to build data frames
  that will be used in statistical models ([04_A_model_NBTs.qmd]())

- `04_A_model_NBTs.qmd` statistical models for the total number of NBT,
  native and NBT turnover, Domestic Contribution and Domestic Retention

- `05_V_chord_diagram_Fig1.qmd` code used to produce circular flow
  diagram. This is the Figure 1 of the study

- `06_V_world_map_Fig1.qmd` code used to produce the world map in the
  Figure 1 of the main text

- `07_V_scatterplot_Fig2.qmd` code used to reproduce the Figure 2 of the
  main text

- `08_V_beta_Fig3.qmd` code used to build Figure 3 of the main text

- `09_V_model_Fig4.qmd` code used to build the Figure 4 of the main
  text. This is the representation of the results of the models present
  in the script [04_A_model_NBTs.qmd]()

- `0010_Supplementary_analysis.qmd` code to produce all the tables and
  figures presented in the Supplementary material of this study

## output

### Figures

In this folder you will find all figures used in the main text and
supplementary material of this study

`Fig1_flow_circle_plot.png` Figure with circular plots showing the flux
of NBT among regions of the world in a 50-year time window

`Fig2_DC_DR.png` Scaterplot with World regions characterized by their
Domestic Contribution and Domestic Retention values in a 50-year time
frame

`Fig3_turnover_metrics.png` Cartogram with 3 maps showing the level of
native turnover, NBT turnover and the combination of both metrics in a
combined map

`Fig4_models.png` Figure showing the predictions of the number of NBT,
DC, DR, native turnover and NBT turnover for different predictors. This
is derived from the statistical models

#### Supp-material

This folder contains the figures in the Supplementary material

- `FigS1_native_richness.png` World map with countries coloured
  according to the number of native species richness according to the
  Catalog of Fishes

- `FigS2_scatterplot.png` All-time Domestic contribution (DC) and
  Domestic retention (DR) for world regions

# Authors

Gabriel Nakamura, Lívia Estéfane F. Frateles, Bruno Henrique Mioto
Stabile, Matheus Lima Araujo, Emanuel Neuhaus, Manoela Maria Ferreira
Marinho, Aline Richter, Liuyong Ding, Tiago Magalhães da Silva Freitas,
Bruno Eleres Soares, Weferson Júnio da Graça, José Alexandre Felizola
Diniz-Filho

# Contact

[Gabriel Nakamura](https://github.com/GabrielNakamura) and [Bruno
Mioto](https://github.com/brunomioto)

If you have any suggestion or commentary, please open an issue

# Session info

    R version 4.3.1 (2023-06-16)
    Platform: x86_64-apple-darwin20 (64-bit)
    Running under: macOS Big Sur 11.7.10

    Matrix products: default
    BLAS:   /Library/Frameworks/R.framework/Versions/4.3-x86_64/Resources/lib/libRblas.0.dylib 
    LAPACK: /Library/Frameworks/R.framework/Versions/4.3-x86_64/Resources/lib/libRlapack.dylib;  LAPACK version 3.11.0

    locale:
    [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8

    time zone: America/Sao_Paulo
    tzcode source: internal

    attached base packages:
    [1] stats     graphics  grDevices utils     datasets  methods   base     

    loaded via a namespace (and not attached):
     [1] compiler_4.3.1    fastmap_1.1.1     cli_3.6.1         tools_4.3.1      
     [5] htmltools_0.5.7   rstudioapi_0.15.0 yaml_2.3.7        rmarkdown_2.25   
     [9] knitr_1.45        jsonlite_1.8.7    xfun_0.41         digest_0.6.33    
    [13] rlang_1.1.2       evaluate_0.23    
