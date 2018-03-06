library("ggplot2")

map.plots <- read.csv("data/pokemonMap.csv", stringsAsFactors = FALSE)
map.plots
kanto.region <- ggplot(map.plots, aes(x = x, y = y)) +
  geom_polygon(aes(fill = location_type, group = group))
kanto.region
