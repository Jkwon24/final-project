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
  
 HEAD
  ##################################
  #### Workspace end for Karan #####
  ##################################
  

  
  output$plotMessage <- renderText ({
    return(paste0("This plot shows the base ", gsub('plot', '', statsDropdown()), " for all Pokemon.
                  This plot is arranged by Ranking on the x-axis, with the highest ranking Pokemon
                  appearing first and the lowest ranking Pokemon appearing last. Hover over values
                  in the graph for more information."))
  })
  
  plotDealingWith <- reactive({
    x <- data.frame(stringsAsFactors = FALSE)
    if (statsDropdown() == "Attack") {
      x <- attack
    } else if (statsDropdown() == "Defense") {
      x <- defense
    } else if (statsDropdown() == "Special Defense") {
      x <- special.defense
    } else if (statsDropdown() == "Special Attack") {
      x <- special.attack
    } else if (statsDropdown() == "HP") {
      x <- hp
    } else if (statsDropdown() == "Speed") {
      x <- speed
    } else {
      x <- totalplot
    }
    return(x)
  })
  
  output$plotOutput <- renderPlot({
    x <- plotDealingWith()
    if (statsDropdown() == "Attack") {
      (statplot <- ggplot(x, aes(`Pokemon ID`, `Base Attack`)) +
          geom_point(aes(colour = `Base Attack`)))
    } else if (statsDropdown() == "Defense") {
      (statplot <- ggplot(x, aes(`Pokemon ID`, `Base Defense`)) +
          geom_point(aes(colour = `Base Defense`)))
    } else if (statsDropdown() == "Special Defense") {
      (statplot <- ggplot(x, aes(`Pokemon ID`, `Base Special Defense`)) +
          geom_point(aes(colour = `Base Special Defense`)))
    } else if (statsDropdown() == "Special Attack") {
      (statplot <- ggplot(x, aes(`Pokemon ID`, `Base Special Attack`)) +
          geom_point(aes(colour = `Base Special Attack`)))
    } else if (statsDropdown() == "HP") {
      (statplot <- ggplot(x, aes(`Pokemon ID`, `Base HP`)) +
          geom_point(aes(colour = `Base HP`)))
    } else if (statsDropdown() == "Speed") {
      (statplot <- ggplot(x, aes(`Pokemon ID`, `Base Speed`)) +
          geom_point(aes(colour = `Base Speed`)))
    } else {
      (statplot <- ggplot(x, aes(`Pokemon ID`, `Average`)) +
         geom_point(aes(colour = `Average`)))
    }
    return(statplot)
  })
  
  output$hover_info <- renderPrint({
    if(!is.null(input$plot_hover)){
      hover=input$plot_hover
      if (hover$x <= 0 | hover$x >= 152) {
        return("No data here.")
      }
      pokemon.id.plot <- floor(hover$x)
      data.frame.stat <- plotDealingWith()
      pokemon.name <- filter(data.frame.stat, `Pokemon ID` == pokemon.id.plot)
      names.columns <- colnames(pokemon.name)
      colnames(pokemon.name)[5] <- "stat"
      if (abs(hover$y - pokemon.name$stat) < 6 ) {
        return(paste(pokemon.name$Name[[1]], names.columns[5], ":", pokemon.name$stat[[1]]))
      } else {
        return("No data here.")
      }
    }
    
    

  })
  ##################################
  ####### Josh's Work Space ########
  ##################################
  

    ## reactives list ##
  # returns the number of pokemone with the selected ability
  totalAbilities <- reactive ({
    return(length(which(abilities == input$only)))
    
  })
  
  # allows the list of abilities to be reactive
  only <- reactive({
    return(input$only)
  })
  
  
  # allows the list of pokemonNames to be reactive
  pokemonNames <- reactive ({
    return(input$pokemonNames)
  })

    ## render list ##
  # outputs the number of abilities based on the input
  output$countAbilities <- renderText ({
    return(paste("The number of pokemon that can have this ability is", totalAbilities(), "/ 151", "which is approximately", round(totalAbilities()/151 * 100),"%."))
  })

  # outputs the name of the pokemon based on the input
  output$pokemonMessage <- renderText({
    return(paste("The following passive abilities can be found on", pokemonNames()))
  })
  
  # outputs the name of the ability the user selects.
  output$abilitiesMessage <- renderText({
    return(paste("The following pokemon can potentially have", only()))
  })
  
  # outputs the abilities table based off of the input pokemon name
  output$abilities <- renderTable({
    filtered.abilities <- subset(abilities, abilities$Pokemon.Name == input$pokemonNames)
  })
  
  # outputs the abilities table based off of the input ability name. 
  output$pokemon.names <- renderTable({
    second.filtered <- subset(abilities, abilities$Passive.Abilities == input$only)
  })
  
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
  
  output$pokemon.map.one.shade <- renderPlot({
    kanto.region <- ggplot() +
      geom_polygon(data = map.plots, aes(x = x, y = y, group = group, fill = location_type)) +
      geom_polygon(data = plot.list.of.location(), aes(x = x, y = y, group = group, fill = location_name)) + 
      scale_fill_manual(values = c("#e6194b", "#0082c8", "#3cb44b", "#FFFF00", "#FFFF00", "#FFFF00", "#FFFF00"
                                   , "#FFFF00", "#FFFF00", "#FFFF00", "#FFFF00", "#FFFF00", "#FFFF00", "#FFFF00"
                                   , "#FFFF00", "#FFFF00", "#FFFF00", "#FFFF00", "#FFFF00", "#FFFF00", "#FFFF00"
                                   , "#FFFF00", "#FFFF00", "#FFFF00")) +
      coord_quickmap() +
      theme(axis.title.x = element_blank(),
            axis.title.y = element_blank(),
            axis.ticks.x = element_blank(),
            axis.ticks.y = element_blank(),
            axis.text.x = element_blank(),
            axis.text.y = element_blank()) +
      labs(title = paste("Areas to Encounter", input$pokemon)) +
      theme(plot.title = element_text(size = 22)) +
      guides(fill=guide_legend(title="Location Name"))
    return(kanto.region)
  })
  
  output$pokemon.map <- renderPlot({
    kanto.region <- ggplot() +
      geom_polygon(data = map.plots, aes(x = x, y = y, group = group, fill = location_type)) +
      geom_polygon(data = plot.list.of.location(), aes(x = x, y = y, group = group, fill = location_name)) + 
      scale_fill_manual(values = c("#e6194b", "#0082c8", "#3cb44b", "#FFFF00", "#FF00FF", "#C0C0C0", "#f58231", "#00FF00"
                                   , "#911eb4", "#87CEFA", "#46f0f0", "#000000", "#808080", "#6A5ACD", "#d2f53c", "#fabebe"
                                   , "#008080", "#e6beff", "#aa6e28", "#fffac8", "#800000", "#aaffc3", "#808000", "#ffd8b1")) +
      coord_quickmap() +
      theme(axis.title.x = element_blank(),
            axis.title.y = element_blank(),
            axis.ticks.x = element_blank(),
            axis.ticks.y = element_blank(),
            axis.text.x = element_blank(),
            axis.text.y = element_blank()) +
      labs(title = paste0("Specific Locations to Encounter ", input$pokemon)) +
      theme(plot.title = element_text(size = 22)) +
      guides(fill=guide_legend(title="Location Name"))
    return(kanto.region) 
  })
}  

