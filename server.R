# Final Project Server File

source("data/PokemonMap.R")
map.plots <- read.csv("data/pokemonMap.csv", stringsAsFactors = FALSE)

my.server <- function(input, output) {
  
  #--------------Text Box Reactives In Here--------------#
  test.reactive <- reactive({
    return(input$PokemonName)
  })
  
  # Reactive Pokemon Name for Text Input
  output$pokemon <- renderText({
    return(test.reactive())
  })
  
  #------------------------------------------------------#
  
  
  
  
  #---------------Gen Reactives In Here------------------#
  # Reactive Generation Variable for Table 1
  generatoin.reactive <- reactive({
    return(input$Generation)
  })
  
  output$generation <- renderTable({
    # CALL 'GET' on a specific URL based on Reactive Gen data
  })
  
  
  #------------------------------------------------------#
  
 
  output$pokemon.map <- renderPlot({
    kanto.region <- ggplot(map.plots, aes(x = x, y = y)) +
      geom_polygon(aes(fill = location_type, group = group))
    return(kanto.region)
  })
}  
