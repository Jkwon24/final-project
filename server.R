# Final Project Server File

map.plots <- read.csv("data/pokemonMap.csv", stringsAsFactors = FALSE)
find.location <- read.csv("data/pokemonLocations.csv", stringsAsFactors = FALSE)

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
      scale_fill_manual(values = c("red", "blue", "green", "#FFFF00", "#FFFF00")) +
      coord_quickmap()
    return(kanto.region)
  })
}  
