library("dplyr")

pokemon.names <- (data.frame(pokemonNames))
abilities <- read.csv(file="data/PokemonAbilities.csv", stringsAsFactors=FALSE)
abilities$X <- NULL
names(abilities) <- c("ID", "Pokemon.Name", "Passive.Abilities")
abilities <- arrange(abilities, ID)
only <- abilities[, c("Passive.Abilities")]