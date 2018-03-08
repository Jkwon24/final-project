# Final Project UI Code


library("shinythemes")
library("ggplot2")
library("png")
#library("imager")

pokemonInfo <- read.csv("data/PokemonInfo.csv")

my.ui <- fluidPage(theme = shinytheme("sandstone"),
                   

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
                             c("fire", "water", "poison", "grass", "flying", 
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
      h2("Pokemon Search!"),
      
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
    
    tabPanel("Base Stats",
             sidebarLayout(
               sidebarPanel(
                 selectInput("statsDropdown", "Choose a stat to view:",
                             c('HP' = "HP",
                               'Attack' = "Attack",
                               'Defense' = "Defense",
                               'Special Attack' = "Special Attack",
                               'Special Defense' = "Special Defense",
                               'Speed' = "Speed",
                               'Average of all Base Stats' = "Average Value")
                 )
               ),

               mainPanel(
                 textOutput("plotMessage"),
                 plotOutput("plotOutput", hover = hoverOpts(id = "plot_hover")),
                 verbatimTextOutput("hover_info")
               )
             )
    ),
    
    ##################################
    #### Workspace end for Karan #####
    ##################################
    
    
    tabPanel("Pokemon Locator",
             sidebarLayout(
               sidebarPanel(
                 textInput("pokemon", "Pokemon Name:")
               ),
               
               mainPanel(
                 h1("Kanto Region"),
                 p("This map allows us to analyze the encounter locations of different species of pokemon. We can use
                   this information to help us find where certain pokemon live, so that we may know where to catch them. 
                   Or, this map is useful for researching what kinds of pokemon are commonly found in specific locations
                   and what trends we might see across certain subgroups of pokemon."),
                 p("The top map highlights all areas in the Kanto Region where you can encouter a certain pokemon. The bottom map
                   allows you to look up the name of the locations visualized from the top map."),
                 p("Enter the name of the pokemon in the search box in all lower case letters. Note that you can
                   search for nidoran-f and nidoran-m separately as they are treated distinctly."),
                 plotOutput("pokemon.map.one.shade"),
                 plotOutput("pokemon.map")
               ) 
             )
    )
  )
)        

shinyUI(my.ui)
