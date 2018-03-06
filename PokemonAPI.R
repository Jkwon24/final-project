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