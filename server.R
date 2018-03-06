# Final Project Server File

source("PokemonMap.R")
library("dplyr")
my.server <- function(input, output) {
  
  pokemonInfo <- read.csv("data/PokemonInfo.csv")
  moveInfo <- read.csv("data/PokemonAbilities.csv")
  
  
  
  #--------------Pokemon Names Reactives In Here--------------#
  pokemonName.reactive <- reactive({
    return(input$PokemonName)
  })
  
  # Reactive Pokemon Name for Text Input
  output$pokemon <- renderText({
    return(pokemonName.reactive())
  })
  #---------------Make a mini-table of data--------------#
  #table1 <- filter(pokemonInfo, "Name" == pokemonName.reactive)
  
  output$filteredTable <- renderTable({
    #test.table <- pokemonInfo
    newTable <- filter(pokemonInfo, pokemonInfo[, 3] == pokemonName.reactive())
  })
  #------------------------------------------------------#

  output$pokemonImage <- renderText({
    target <- pokemonInfo[1 == pokemonName.reactive(), 4]
    
    
  })
  
 
  
  #--------------Move Name Reactives In Here--------------#
  moveName.reactive <- reactive({
    return(input$MoveName)
  })
  
  # Reactive Pokemon Name for Text Input
  output$move <- renderText({
    return(moveName.reactive)
  })
  #---------------Make a mini-table of data--------------#
  output$moveTable <- renderTable({
    moveTable <- filter(moveInfo, moveInfo[, 4] == moveName.reactive())
  })
  #------------------------------------------------------#
  
  
  typeName.reactive <-reactive({
    return
    
  })
  
  
  
  
  
  
  output$pokemon.map <- renderLeaflet({
    return(kanto.region)
  })
  
}  

