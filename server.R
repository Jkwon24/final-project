# Final Project Server File
# Pokemon Database API and CSV data scraping and wranging

source("PokemonMap.R")
library("dplyr")
my.server <- function(input, output) {
  
  pokemonInfo <- read.csv("data/PokemonInfo.csv")
  moveInfo <- read.csv("data/PokemonMoves.csv")
  
  #--------------Pokemon Names Reactives--------------#
  
  # Pokemon Name reactive grabbed from user input
  pokemonName.reactive <- reactive({
    return(input$PokemonName)
  })
  
  # Output for pokemon Name
  output$pokemon <- renderText({
    return(pokemonName.reactive())
  })
  
  #--------------Move Name Search Section--------------#
  
   moveName.reactive <- reactive({
    return(input$MoveName)
  })
  
  # Output stream for user inputed move name
  output$moveName <- renderText({
    return(moveName.reactive())
  })
  
  # Creates reactive table that returns the pokemon's ID, Pokemon's Name, and Move Name (reactivly changes)
  output$moveTable <- renderTable({
    moveTable <- filter(moveInfo, moveInfo[, 4] == moveName.reactive())
    colnames(moveTable) <- c("Move ID", "Pokemon ID", "Pokemon Name", "Move Name")
    moveCount <- nrow(moveTable)
    return(moveTable[, 2:4])
  })
  
  # Calculates the total number of pokemon capable of learning this move in Gen 1
  moveCount.reactive <- reactive({
    moveTable <- filter(moveInfo, moveInfo[, 4] == moveName.reactive())
    colnames(moveTable) <- c("Move ID", "Pokemon ID", "Pokemon Name", "Move Name")
    moveCount <- nrow(moveTable)
    return(moveCount)
  })
  
  # Output stream for count calculated above 
  output$count <- renderText({
    return(moveCount.reactive())
  })
  
  #------------------------------------------------------#

  output$pokemon.map <- renderLeaflet({
    return(kanto.region)
  })
  
}  

