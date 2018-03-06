## This file is used to make the CSV files that are stored in data.
## This file is not sourced anywhere and should not be run

library(dplyr)
library(httr)
library(jsonlite)
library(ggplot2)

base.uri <- "http://pokeapi.co/api/v2/"

getParsedData <- function(query) {
  response <- GET(paste0(base.uri, query))
  body <- content(response, "text")
  parsed.data <- fromJSON(body)
  return(parsed.data)
}


## Creating CSV files for Pokemon infomration
gen.1.data <- getParsedData("generation/1")
pokemonNames <- gen.1.data$pokemon_species$name

pokemonInfo <- data.frame(stringsAsFactors = FALSE)
pokemonAbilities <- data.frame(stringsAsFactors = FALSE)
pokemonMoves <- data.frame(stringsAsFactors = FALSE)
pokemonTypes <- data.frame(stringsAsFactors = FALSE)

for (i in pokemonNames) {
  specificPokemon <- getParsedData(paste0("pokemon/", i))
  specificInfo <- data.frame(specificPokemon$id,
                             specificPokemon$name, 
                             specificPokemon$weight,
                             specificPokemon$height,
                             specificPokemon$sprites$front_default,
                             stringsAsFactors = FALSE)
  names(specificInfo) <- c("ID", "Name", "Weight", "Height", "Sprite")
  pokemonInfo <- rbind(pokemonInfo, specificInfo)
  
  specificAbilities <- data.frame(specificPokemon$id,
                                  specificPokemon$name,
                                  specificPokemon$abilities$ability$name,
                                  stringsAsFactors = FALSE)
  names(specificAbilities) <- data.frame("ID", "Name", "Abilities")
  pokemonAbilities <- rbind(pokemonAbilities, specificAbilities)
  
  specificMoves <- data.frame(specificPokemon$id,
                                  specificPokemon$name,
                                  specificPokemon$moves$move$name,
                              stringsAsFactors = FALSE)
  names(specificMoves) <- data.frame("ID", "Name", "Moves")
  pokemonMoves <- rbind(pokemonMoves, specificMoves)
  
  specificTypes <- data.frame(specificPokemon$id,
                                  specificPokemon$name,
                                  specificPokemon$types$type$name,
                              stringsAsFactors = FALSE)
  names(specificTypes) <- data.frame("ID", "Name", "Types")
  pokemonTypes <- rbind(pokemonTypes, specificTypes)
}


write.csv(pokemonInfo, file = "data/PokemonInfo.csv")
write.csv(pokemonAbilities, file = "data/PokemonAbilities.csv")
write.csv(pokemonMoves, file = "data/PokemonMoves.csv")
write.csv(pokemonTypes, file = "data/PokemonTypes.csv")


moves <- read.csv("data/moves.csv")
moves <- filter(moves, generation_id == 1)
write.csv(moves, file = "moves.csv")


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
(d <- ggplot(hp, aes(Rankings, `Base HP`)) +
    geom_point(aes(colour = `Base HP`)))


attack <- filter(st, stat_id == 2) %>%
  arrange(desc(base_stat))
Rankings <- c(1:151)
colnames(attack)[5] <- "Base Attack"
attack <- mutate(attack, Rankings)
(d <- ggplot(attack, aes(Rankings, `Base Attack`)) +
    geom_point(aes(colour = `Base Attack`)))


defense <- filter(st, stat_id == 3) %>%
  arrange(desc(base_stat))
Rankings <- c(1:151)
colnames(defense)[5] <- "Base Defense"
defense <- mutate(defense, Rankings)
(d <- ggplot(defense, aes(Rankings, `Base Defense`)) +
    geom_point(aes(colour = `Base Defense`)))


special.defense <- filter(st, stat_id == 5) %>%
  arrange(desc(base_stat))
Rankings <- c(1:151)
colnames(special.defense)[5] <- "Base Special Defense"
special.defense <- mutate(special.defense, Rankings)
(d <- ggplot(special.defense, aes(Rankings, `Base Special Defense`)) +
    geom_point(aes(colour = `Base Special Defense`)))


special.attack <- filter(st, stat_id == 4) %>%
  arrange(desc(base_stat))
Rankings <- c(1:151)
colnames(special.attack)[5] <- "Base Special Attack"
special.attack <- mutate(special.attack, Rankings)
(d <- ggplot(special.attack, aes(Rankings, `Base Special Attack`)) +
    geom_point(aes(colour = `Base Special Attack`)))


speed <- filter(st, stat_id == 6) %>%
  arrange(desc(base_stat))
Rankings <- c(1:151)
colnames(speed)[5] <- "Base Speed"
speed <- mutate(speed, Rankings)
(d <- ggplot(speed, aes(Rankings, `Base Speed`)) +
    geom_point(aes(colour = `Base Speed`)))