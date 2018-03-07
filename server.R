# Final Project Server File

source("PokemonMap.R")
library("dplyr")
my.server <- function(input, output) {
  
  pokemonInfo <- read.csv("data/PokemonInfo.csv")
  moveInfo <- read.csv("data/PokemonMoves.csv")
  
  
  
  #--------------Pokemon Names Reactives In Here--------------#
  pokemonName.reactive <- reactive({
    return(input$PokemonName)
  })
  
  # Reactive Pokemon Name for Text Input
  output$pokemon <- renderText({
    return(pokemonName.reactive())
  })
  
  #---------------Make a mini-table of data--------------#
  
  output$filteredTable <- renderTable({
    newTable <- filter(pokemonInfo, pokemonInfo[, 3] == pokemonName.reactive())
  })

  #--------------Move Name Search Section--------------#
 
   moveName.reactive <- reactive({
    return(input$MoveName)
  })
  
  # Reactive Pokemon Name for Text Input
  output$moveName <- renderText({
    return(moveName.reactive())
  })
  
  colnames(moveTable) <- c("A", "B", "C", "D")
  
  output$moveTable <- renderTable({
    #colnames(moveTable) <- c("A", "B", "C", "D")
    moveTable <- filter(moveInfo, moveInfo[, 4] == moveName.reactive())
    
    #moveCount <- nrow(moveTable)
    #moveTable <- filter(moveInfo, moveInfo[, 4] == moveName.reactive())
  })
  
  

  #------------------------------------------------------#

  output$pokemon.map <- renderLeaflet({
    return(kanto.region)
  })
  
}  

