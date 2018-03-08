library(shiny)
server <- shinyServer(function(input,output){
  output$abilities <- renderTable({
    filtered.abilities <- subset(abilities, abilities$Pokemon.Name == input$pokemonNames)
  })
  output$pokemon.names <- renderTable({
    second.filtered <- subset(abilities, abilities$Passive.Abilities == input$only)
  })
  
})



shinyApp(ui=ui, server=server)
