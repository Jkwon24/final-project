# Final Project Server File
library("dplyr")
library("png")
#library("imager")

source("BaseStats.R")
map.plots <- read.csv("data/pokemonMap.csv", stringsAsFactors = FALSE)
pokemonTypes <- read.csv("data/PokemonTypes.csv", stringsAsFactors = FALSE)
pokemonInfo <- read.csv("data/PokemonInfo.csv", stringsAsFactors = FALSE)
colnames(pokemonTypes) <- c("num", "ID", "name", "type")
find.location <- read.csv("data/pokemonLocations.csv", stringsAsFactors = FALSE)

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
      select(ID, NAME, type, Weight, Height, Sprite) %>%
      arrange(ID)
    colnames(finalTable) <- c("ID", "NAME", "TYPE", "WEIGHT", "HEIGHT", "SPRITE")
    finalTable[,3] <- toupper(finalTable[,3])
    
    # links <- joinTable$Sprite
    # pics <- c()
    # for (i in links) {
    #   pics <- c(pics, load.image(i))
    # }
    # joinTable <- mutate(joinTable, pics)
    
    return(finalTable)
  })
  
  statsDropdown <- reactive({
    return(input$statsDropdown)
  })
  
  output$plotMessage <- renderText ({
    return(paste0("This plot shows the base ", gsub('plot', '', statsDropdown()), " for all Pokemon.
                  This plot is arranged by Ranking on the x-axis, with the highest ranking Pokemon
                  appearing first and the lowest ranking Pokemon appearing last. Hover over values
                  in the graph for more information."))
  })
  
  output$plotOutput <- renderPlot({
    if (statsDropdown() == "Attack") {
      return(attackplot)
    } else if (statsDropdown() == "Defense") {
      return(defenseplot)
    } else if (statsDropdown() == "Special Defense") {
      return(specialdefenseplot)
    } else if (statsDropdown() == "Special Attack") {
      return(specialattackplot)
    } else if (statsDropdown() == "HP") {
      return(hpplot)
    } else {
      return(speedplot)
    }
  })
  
  
  
  
  ##################################
  #### Workspace end for Karan #####
  ##################################
  
  list.of.location <- reactive({
    get.list <- find.location %>% 
      filter(pokemon_name == input$pokemon) %>% 
      select(location_name)
    return(get.list)
  })
  
  plot.list.of.location <- reactive({
    get.joined.list <- left_join(list.of.location(), map.plots)
    return(get.joined.list)
  })
  
  output$pokemon.map <- renderPlot({
    kanto.region <- ggplot() +
      geom_polygon(data = map.plots, aes(x = x, y = y, group = group, fill = location_type)) +
      geom_polygon(data = plot.list.of.location(), aes(x = x, y = y, group = group, fill = location_name)) + 
      scale_fill_manual(values = c("red", "blue", "green", "#FFFF00", "#FFFF00", "#FFFF00", "#FFFF00"
                                   , "#FFFF00", "#FFFF00", "#FFFF00", "#FFFF00", "#FFFF00", "#FFFF00"
                                   , "#FFFF00", "#FFFF00", "#FFFF00", "#FFFF00", "#FFFF00", "#FFFF00")) +
      coord_quickmap()
    return(kanto.region)
  })
}  

