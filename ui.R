# Final Project UI Code


library("shinythemes")
library("ggplot2")
library("png")
#library("imager")

source("BaseStats.R") 

pokemonInfo <- read.csv("data/PokemonInfo.csv")

my.ui <- fluidPage(theme = shinytheme("sandstone"),
                   

  titlePanel("Pokemon Data"),
  
  tabsetPanel(
    # TABLE TABS 
    tabPanel("Welcome",
             mainPanel(
               h1("Welcome to our Pokemon Data Shiny App!"),
               h3("The purpose of this app is to allow users to 
                  obtain further knowledge on a specific feature for all Generation 1 Pokemon. This offers a
                  wide variety of information ranging from pokemon move sets, passive abilities, particular
                  stats, and to even the location of a pokemon you are looking for by using the provided tabs."),
               tags$img(src = "https://scontent-sea1-1.xx.fbcdn.net/v/t34.0-12/28722063_580603685627571_671311557_n.png?oh=186389e7c561470c3194c5f2cb2623a0&oe=5AA3C616", width = "400px", height = "325px"),
               h3("Sources"),
               h6("Used the pokeapi to obtain data"),
               h6("https://pokeapi.co/docsv2/"),
               h6("Cover image"),
               h6("https://scontent-sea1-1.xx.fbcdn.net/v/t34.0-12/28722063_580603685627571_671311557_n.png?oh=186389e7c561470c3194c5f2cb2623a0&oe=5AA3C616")
             )
            
    ),
    
    tabPanel("Pokemon Moves",
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
    
    
    
    
    tabPanel("Passive Abilities",
             h1("Passive Abilities"),
             
             sidebarLayout(
               sidebarPanel(
                 selectInput("pokemonNames", "Enter a Pokemon Name", choices = abilities$Pokemon.Name),
                 h4 ("or"),
                 selectInput("only", "Enter a Passive Ability", choices = abilities$Passive.Abilities)
               ),
               mainPanel(
                 h4(textOutput("pokemonMessage")),
                 tableOutput("abilities"),
                 h4(textOutput("abilitiesMessage")),
                 tableOutput("pokemon.names"), 
                 h5(textOutput("countAbilities")),
                 br(),
                 h4("Each passive ability is uniquely limited to a number of pokemon as the data shows. 
                     It's important to know which ability a pokemon can carry because certain abilities are
                     ineffective to specific move, and some passives can even change the dynamics of the playing field.")
                      
                 
               )
             ) 
    ),
    
    
    
    
    
    ##################################
    ##### Workspace for Karan ########
    ##################################
    
    tabPanel("Pokemon Search",
      h1("Pokemon Search!"),

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
          h4(textOutput("tableMessage")),
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

