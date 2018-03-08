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
  arrange(pokemon_id)
colnames(hp)[5] <- "Base HP"
colnames(hp)[1] <- "Pokemon ID"
(hpplot <- ggplot(hp, aes(`Pokemon ID`, `Base HP`)) +
    geom_point(aes(colour = `Base HP`)))


attack <- filter(st, stat_id == 2) %>%
  arrange(pokemon_id)
colnames(attack)[5] <- "Base Attack"
colnames(attack)[1] <- "Pokemon ID"
(attackplot <- ggplot(attack, aes(`Pokemon ID`, `Base Attack`)) +
    geom_point(aes(colour = `Base Attack`)))


defense <- filter(st, stat_id == 3) %>%
  arrange(pokemon_id)
colnames(defense)[5] <- "Base Defense"
colnames(defense)[1] <- "Pokemon ID"
(defenseplot <- ggplot(defense, aes(`Pokemon ID`, `Base Defense`)) +
    geom_point(aes(colour = `Base Defense`)))


special.defense <- filter(st, stat_id == 5) %>%
  arrange(pokemon_id)
colnames(special.defense)[5] <- "Base Special Defense"
colnames(special.defense)[1] <- "Pokemon ID"
(specialdefenseplot <- ggplot(special.defense, aes(`Pokemon ID`, `Base Special Defense`)) +
    geom_point(aes(colour = `Base Special Defense`)))


special.attack <- filter(st, stat_id == 4) %>%
  arrange(pokemon_id)
colnames(special.attack)[5] <- "Base Special Attack"
colnames(special.attack)[1] <- "Pokemon ID"
(specialattackplot <- ggplot(special.attack, aes(`Pokemon ID`, `Base Special Attack`)) +
    geom_point(aes(colour = `Base Special Attack`)))


speed <- filter(st, stat_id == 6) %>%
  arrange(pokemon_id)
colnames(speed)[5] <- "Base Speed"
colnames(speed)[1] <- "Pokemon ID"
(speedplot <- ggplot(speed, aes(`Pokemon ID`, `Base Speed`)) +
    geom_point(aes(colour = `Base Speed`)))


totalValues <- attack$`Base Attack` + defense$`Base Defense` + 
               special.attack$`Base Special Attack` + 
               special.defense$`Base Special Defense` +
               hp$`Base HP` + speed$`Base Speed`
Average <- totalValues / 6

totalplot <- select(hp, `Pokemon ID`, Name, stat_id, identifier) %>%
              mutate(Average)


pokemon.names <- read.csv(file="data/PokemonNames.csv", stringsAsFactors = FALSE)
pokemon.names$X <- NULL
names(pokemon.names) <- c("pokemonNames")
abilities <- read.csv(file="data/PokemonAbilities.csv", stringsAsFactors=FALSE)
abilities$X <- NULL
names(abilities) <- c("ID", "Pokemon.Name", "Passive.Abilities")
abilities <- arrange(abilities, ID)
only <- abilities[, c("Passive.Abilities")]


