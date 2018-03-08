library(shiny)
library(dplyr)

ui <- fluidPage(
  titlePanel("Pokemon Passive Abilities"),
  sidebarLayout(
    sidebarPanel(
      selectInput("pokemonNames", "Enter a Pokemon Name", choices = abilities$Pokemon.Name),
      selectInput("only", "Enter a Passive Ability", choices = abilities$Passive.Abilities)
    ),
    mainPanel(
      tableOutput("abilities"),
      tableOutput("pokemon.names")  
    )
  )  
)
shinyApp(ui=ui, server=server)




