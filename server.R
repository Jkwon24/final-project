# Final Project Server File

source("PokemonMap.R")

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
  
  
  
  
  # Reactive input for slider, adds "yr" to begining to help filter with DPLYR
  slider.reactive <- reactive({
    filter.value <- input$SliderYear
    filter.value.string <- paste0("YR", filter.value)
    return(filter.value.string)
  })
  
 
  output$pokemon.map <- renderLeaflet({
    return(kanto.region)
  })
  
}  
