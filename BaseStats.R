library(dplyr)
library(httr)
library(jsonlite)
library(ggplot2)


stats <- read.csv("data/stats.csv")
pokemon_stats <- read.csv("data/pokemon_stats.csv")
colnames(stats)[1] <- "stat_id"
pokemon_stats <- left_join(pokemon_stats, stats, by = "stat_id")
pokemon_info <- read.csv("data/PokemonInfo.csv")
pokemon_info <- select(pokemon_info, ID, Name)
colnames(pokemon_info)[1] <- "pokemon_id"
pokemon_stats <- left_join(pokemon_stats, pokemon_info, by = "pokemon_id")
st <- select(pokemon_stats, pokemon_id, Name, stat_id, identifier, base_stat)
st <- st[c(1:906),]




hp <- filter(st, stat_id == 1) %>%
  arrange(desc(base_stat))
Rankings <- c(1:151)
colnames(hp)[5] <- "Base HP"
hp <- mutate(hp, Rankings)
(hpplot <- ggplot(hp, aes(Rankings, `Base HP`)) +
    geom_point(aes(colour = `Base HP`)))


attack <- filter(st, stat_id == 2) %>%
  arrange(desc(base_stat))
Rankings <- c(1:151)
colnames(attack)[5] <- "Base Attack"
attack <- mutate(attack, Rankings)
(attackplot <- ggplot(attack, aes(Rankings, `Base Attack`)) +
    geom_point(aes(colour = `Base Attack`)))


defense <- filter(st, stat_id == 3) %>%
  arrange(desc(base_stat))
Rankings <- c(1:151)
colnames(defense)[5] <- "Base Defense"
defense <- mutate(defense, Rankings)
(defenseplot <- ggplot(defense, aes(Rankings, `Base Defense`)) +
    geom_point(aes(colour = `Base Defense`)))


special.defense <- filter(st, stat_id == 5) %>%
  arrange(desc(base_stat))
Rankings <- c(1:151)
colnames(special.defense)[5] <- "Base Special Defense"
special.defense <- mutate(special.defense, Rankings)
(specialdefenseplot <- ggplot(special.defense, aes(Rankings, `Base Special Defense`)) +
    geom_point(aes(colour = `Base Special Defense`)))


special.attack <- filter(st, stat_id == 4) %>%
  arrange(desc(base_stat))
Rankings <- c(1:151)
colnames(special.attack)[5] <- "Base Special Attack"
special.attack <- mutate(special.attack, Rankings)
(specialattackplot <- ggplot(special.attack, aes(Rankings, `Base Special Attack`)) +
    geom_point(aes(colour = `Base Special Attack`)))


speed <- filter(st, stat_id == 6) %>%
  arrange(desc(base_stat))
Rankings <- c(1:151)
colnames(speed)[5] <- "Base Speed"
speed <- mutate(speed, Rankings)
(speedplot <- ggplot(speed, aes(Rankings, `Base Speed`)) +
    geom_point(aes(colour = `Base Speed`)))