library(readr)        # reading CSV files
library(here)         # constructing file paths
library(dplyr)        # data manipulation
library(tidyr)        # data tidying


# From 01_C_data_preparation.qmd
spp_native_distribution <- readr::read_csv(here::here("data", "raw", "spp_native_distribution.csv")) 

# From 01_C_data_preparation.qmd
spp_type_distribution <- readr::read_csv(here::here("data", "raw", "spp_type_distribution.csv")) 

spp_endemic_native <- 
  spp_native_distribution |> 
  group_by(species) |>
  add_count(name = "n.species") |> 
  filter(n.species == 1) |> 
  ungroup() |> 
  group_by(country_distribution) |> 
  add_count(name = "n.endemics.country")

a <- spp_endemic_native |> 
  right_join(spp_type_distribution) |> 
  filter(country_distribution == country_museum) |> 
  group_by(country_museum) |> 
  add_count(name = "n_types_native") |> 
  select(country_distribution, region_distribution, n.endemics.country, n_types_native) |> 
  distinct() |> 
  mutate(pop_type_end = n_types_native/n.endemics.country)


countries <- rnaturalearth::ne_countries(returnclass = "sf")

sf_countries <-
  sf::st_as_sf(countries) |>
  dplyr::filter(admin != "Antarctica") |>
  sf::st_transform(crs = "+proj=moll +x_0=0 +y_0=0 +lat_0=0 +lon_0=0") |> 
  dplyr::select(iso_a3_eh)

df_endemic_sf <-
  sf_countries |>
  dplyr::full_join(a, by = c(iso_a3_eh = "country_museum")) |> 
  sf::st_as_sf() |> 
  rmapshaper::ms_filter_islands(min_area = 12391399903)


palette_blue <- colorRampPalette(c("#d3d3d3", "#accaca", "#81c1c1", "#52b6b6"))

palette_pink <- colorRampPalette(c("#d3d3d3", "#c5acc2", "#bb84b1", "#ac5a9c"))
library(ggplot2)


end_rep <- ggplot() +
  geom_sf(data = df_endemic_beta_sf,
          aes(geometry = geometry,
              fill = pop_type_end),
          color = "white",
          size = 0.1, na.rm = T) +
  scale_fill_gradientn(
    colors = palette_pink(10),
    na.value = "#d3d3d3",
    limits = c(0,1)
  )+
  guides(fill = guide_colorbar(
    barheight = unit(0.1, units = "in"),
    barwidth =  unit(4, units = "in"),
    ticks.colour = "grey20",
    title.position="top", 
    title.hjust = 0.5
  )) +
  labs(
    fill = "Endemic Representation"
  )+
  theme_classic()+
  theme(
    legend.position = "bottom",
    legend.margin = margin(-10,0,0,0,"pt"),
    axis.text = element_blank(),  
    axis.ticks = element_blank(),
    axis.line = element_blank()
  ) 

country_type_richness <- spp_type_distribution |> 
  group_by(country_museum) |> 
  count(name = "type_richness")


b <- spp_endemic_native |> 
  right_join(spp_type_distribution) |> 
  filter(country_distribution != country_museum) |> 
  group_by(country_museum) |> 
  add_count(name = "foreign_native") |> 
  select(country_museum, region_museum, foreign_native) |> 
  distinct() |> 
  left_join(country_type_richness) |> 
  mutate(pop_type_for_end = foreign_native/type_richness)


df_for_endemic_sf <-
  sf_countries |>
  dplyr::full_join(b, by = c(iso_a3_eh = "country_museum")) |> 
  sf::st_as_sf() |> 
  rmapshaper::ms_filter_islands(min_area = 12391399903)


palette_blue <- colorRampPalette(c("#d3d3d3", "#accaca", "#81c1c1", "#52b6b6"))

palette_pink <- colorRampPalette(c("#d3d3d3", "#c5acc2", "#bb84b1", "#ac5a9c"))

foreign_end_rep <- ggplot() +
  geom_sf(data = df_endemic_beta_sf,
          aes(geometry = geometry,
              fill = pop_type_for_end),
          color = "white",
          size = 0.1, na.rm = T) +
  scale_fill_gradientn(
    colors = palette_blue(10),
    na.value = "#d3d3d3",
    limits = c(0,1)
  )+
  guides(fill = guide_colorbar(
    barheight = unit(0.1, units = "in"),
    barwidth =  unit(4, units = "in"),
    ticks.colour = "grey20",
    title.position="top", 
    title.hjust = 0.5
  )) +
  labs(
    fill = "Foreign Endemic Representation"
  )+
  theme_classic()+
  theme(
    legend.position = "bottom",
    legend.margin = margin(-10,0,0,0,"pt"),
    axis.text = element_blank(),  
    axis.ticks = element_blank(),
    axis.line = element_blank()
  ) 


c <- a |> 
  full_join(b) |> 
  dplyr::full_join(sf_countries, by = c("country_museum" = "iso_a3_eh")) |> 
  sf::st_as_sf() |> 
  rmapshaper::ms_filter_islands(min_area = 12391399903) |> 
  dplyr::mutate(
    pop_type_end = ifelse(is.na(pop_type_end), 
                       0, 
                       pop_type_end),
    pop_type_for_end = ifelse(is.na(pop_type_for_end), 
                         0, 
                         pop_type_for_end))

#plot
library(ggplot2)
library(patchwork)
library(cowplot)
#map
library(rnaturalearth)
library(rmapshaper)
library(sf)
library(biscale)

sf_bivar_types_endemic <-
  bi_class(c, 
           x = pop_type_for_end, 
           y = pop_type_end, 
           style = "equal",
           dim = 4)

bivar_map_types_endemic <- 
  ggplot() +
  geom_sf(data = sf_bivar_types_endemic, 
          aes(geometry = geometry,
              fill = bi_class), 
          color = "white",
          size = 0.1, 
          show.legend = FALSE) +
  bi_scale_fill(pal = "DkBlue2", 
                dim = 4) +
  theme_classic()+
  theme(
    legend.position = "bottom",
    legend.title = element_blank(),
    axis.text = element_blank(),  
    axis.ticks = element_blank(),
    axis.line = element_blank(),
    panel.background = element_rect(fill = NA),
    plot.background = element_rect(fill = NA)
  ) 

legend <-
  bi_legend(pal = "DkBlue2",
            dim = 4,
            xlab = "Foreign",
            ylab = "Endemic",
            size = )

bivar_map_type_final_endemic <- 
  ggdraw() +
  draw_plot(legend, 0.0, 0.15, 0.25, 0.25) +
  draw_plot(bivar_map_types_endemic, 0, 0, 1, 1)

