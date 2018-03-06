# Final Project Server File
library("dplyr")
library("png")
library("imager")


source("KantoRegion.R")
map.plots <- read.csv("data/pokemonMap.csv", stringsAsFactors = FALSE)
pokemonTypes <- read.csv("data/PokemonTypes.csv", stringsAsFactors = FALSE)
pokemonInfo <- read.csv("data/PokemonInfo.csv", stringsAsFactors = FALSE)
colnames(pokemonTypes) <- c("num", "ID", "name", "type")

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
  
  
  ##################################
  ##### Workspace for Karan ########
  ##################################
  
  typeDropdown <- reactive({
    return(input$typeDropdown)
  })
  
  output$tableMessage <- renderText({
    return(paste("This is the table showing all information on all 
                 pokemon of type", typeDropdown()))
  })
  
  output$tableOutput <- renderTable({
    joinTable <- left_join(pokemonTypes, pokemonInfo, by = "ID")
    joinTable[,3] <- toupper(joinTable[,3])
    colnames(joinTable)[3] <- "NAME"
    finalTable <- filter(joinTable, type == typeDropdown()) %>%
      select(ID, NAME, type, Weight, Height) %>%
      arrange(ID)
    colnames(finalTable) <- c("ID", "NAME", "TYPE", "WEIGHT", "HEIGHT")
    finalTable[,3] <- toupper(finalTable[,3])
    
    # links <- joinTable$Sprite
    # pics <- c()
    # for (i in links) {
    #   pics <- c(pics, load.image(i))
    # }
    # joinTable <- mutate(joinTable, pics)
    
    return(finalTable)
  })
  
  
  
  
  
  
  ##################################
  #### Workspace end for Karan #####
  ##################################
  
  output$pokemon.map <- renderPlot({
    kanto.region <- ggplot(map.plots, aes(x = x, y = y)) +
      geom_polygon(aes(fill = location_type, group = group))
  })
  }  

