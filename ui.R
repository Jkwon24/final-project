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
                 h4("Why is it important to know the passive abilities of a pokemon?
                     It's important because certain abilities are ineffective to specific moves,
                     and some passives can even change the dynamics of the playing field.")
                      
                 
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

shinyApp(ui=my.ui, server=my.server)
