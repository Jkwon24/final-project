# Final Project UI Code
# Pokemon Database API and CSV data scraping and wranging

library("shinythemes")
library("ggplot2")
library("png")
library("leaflet")
library("shiny")

pokemonInfo <- read.csv("data/PokemonInfo.csv")
moveInfo <- read.csv("data/PokemonMoves.csv")


my.ui <- fluidPage(theme = shinytheme("sandstone"),
                   

  titlePanel("Pokemon Data"),
  
  tabsetPanel(
    # TABLE TABS 
    tabPanel("Table 1",
             sidebarLayout(
               # Sidebar Widgets
               sidebarPanel(
                 h1("Move Search"),
                 textInput("MoveName", "Please Enter a Move Name")
                 
                 
                 
               ),
               
               
               #-------------------- ^ Sidebar Panel Rendering Goes Above  ^ ---------------------#
               #--------------------                                         ---------------------#
               #-------------------- V Main Panel Rendering Goe Below Here V ---------------------#
               
               
               mainPanel(
                 h2("Pokemon Database Information Panel"),
                 
                 h3("Showing move information for:"),
                 textOutput("moveName"),
                 tableOutput("moveTable"),
                 
                 h3("Total Number of Pokemon in Gen 1 this move can be taught to:"),
                 textOutput("count"),
                 h2("Why does this Data Matter?"),
                 
                 h3("This tab functions as a move search, allowing a user to search for a move in the pokemon world. 
                     As an output, this tab will return a data table consisting of all pokemon capable of learning
                     that specific move. It will also return the total number of pokemon in that table, which gives the 
                     user access to some very interesting data. For example, through the use of this application, we 
                     found the 3 most common moves in the gen 1 pokemon world were Tackle, Leer, and Growl"),
                 
                 h3("This data could be useful in the context it works in, by allowing the user to calculate the strength
                     of a move based on its rarity. For example, 'clamp' is considered one of the best moves in Gen 1.
                     By using this table, you can see it can only be learned by 2 pokemon. Its effect is incredibly potent,
                     and it is a very common occurence to see these high power moves restricted to low numbers of total
                     pokemon that can learn it.")
                 
                 
                 
                 
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
