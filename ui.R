# Final Project UI Code


library("shinythemes")
library("ggplot2")
library("leaflet")
library("png")
library("imager")

pokemonInfo <- read.csv("data/PokemonInfo.csv")

my.ui <- fluidPage(theme = shinytheme("darkly"),
                   
  tags$head(
    tags$style(HTML(".leaflet-container { background: #ffffff; }"))
  ),
  titlePanel("Pokemon Data"),
  
  tabsetPanel(
    # TABLE TABS 
    tabPanel("Table 1 [Conner]",
             sidebarLayout(
               # Sidebar Widgets
               sidebarPanel(
                 
                 h2("Pokemon Search!"),
                 textInput("PokemonName", "Please Enter a Pokemon Name"),
                 
                 h2("Move Search"),
                 textInput("MoveName", "Please Enter a Move Name"),
                 
                 h2("Filter by Pokemon Type"),
                 selectInput("typeName", "Type of Pokemon", 
                             c("fire", "water", "poision", "grass", "flying", 
                               "bug", "normal", "electric", "ground", "fairy",
                               "grass", "fighting", "psychic", "rock", "Steel",
                               "ice", "dragon")
                 )
                 
                 
               ),
               
               
               #-------------------- ^ Sidebar Panel Rendering Goes Above  ^ ---------------------#
               #--------------------                                         ---------------------#
               #-------------------- V Main Panel Rendering Goe Below Here V ---------------------#
               
               
               mainPanel(
                 h2("Pokemon Database Information Panel"),
                 
                 # Lets me show them what they are typing in inside my panel + makes reactive
                 h3("Showing information on:"),
                 chosenPokemon <- textOutput("pokemon"),
                 #print(pokemon.NameReactive)
                 tableOutput("filteredTable"),
                 tableOutput("moveTable"),
                 
                 htmlOutput("pokemonImage")
                 
                 
                 
               ) 
             )
    ),
    
    
    
    
    tabPanel("Table 2 [Josh]"
             
    ),
    
    ##################################
    ##### Workspace for Karan ########
    ##################################
    
    tabPanel("Pokemon Search",
      h1("Pokemon Search!"),
      
      sidebarLayout(
        sidebarPanel(
          selectInput("typeDropdown", "Choose a type:",
                      c('Flying' = "flying",   
                        'Dragon' = "dragon",
                        'Normal' = "normal",
                        'Water' = "water",
                        'Rock' = "rock",
                        'Fire' = "fire",
                        'Electric' = "electric",
                        'Psychic' = "psychic",
                        'Ice' = "ice",
                        'Fairy' = "fairy",
                        'Ground' = "ground",
                        'Poison' = "poison",
                        'Fighting' = "fighting",
                        'Grass' = "grass",
                        'Ghost' = "ghost",
                        'Steel' = "steel",
                        'Bug' = "bug")
          )
        ),
        
        mainPanel(
          textOutput("tableMessage"),
          tableOutput("tableOutput")
        )
      )
    ),
    
    ##################################
    #### Workspace end for Karan #####
    ##################################
    
    
    tabPanel("Kanto Map",
             leafletOutput("pokemon.map")
    )
  )
)        

shinyUI(my.ui)
