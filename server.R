# Final Project Server File

<<<<<<< HEAD
source("data/PokemonMap.R")
map.plots <- read.csv("data/pokemonMap.csv", stringsAsFactors = FALSE)

=======
source("PokemonMap.R")
library("dplyr")
>>>>>>> 6e7c3b6bef30c3f8d487cbc6f4e67a3609756cb7
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
  
  
<<<<<<< HEAD
 
  output$pokemon.map <- renderPlot({
    kanto.region <- ggplot(map.plots, aes(x = x, y = y)) +
      geom_polygon(aes(fill = location_type, group = group))
=======
  
  
  
  
  output$pokemon.map <- renderLeaflet({
>>>>>>> 6e7c3b6bef30c3f8d487cbc6f4e67a3609756cb7
    return(kanto.region)
  })
}  

