# Final Project UI Code


library("rsconnect")
library("shinythemes")
library("ggplot2")
library("png")
library("imager")

source("BaseStats.R") 

pokemonInfo <- read.csv("data/PokemonInfo.csv")

my.ui <- fluidPage(theme = shinytheme("sandstone"),
                   

  titlePanel("Pokemon Data"),
  
  tabsetPanel(
    # TABLE TABS 
    tabPanel("Welcome",
             mainPanel(
               h2("Welcome to our Pokemon Data Shiny App!"),
               h4("The purpose of this app is to allow users to 
                  obtain further knowledge on a specific feature for all Generation 1 Pokemon. This offers a
                  wide variety of information ranging from pokemon move sets, passive abilities, particular
                  stats, and to even the location of a pokemon you are looking for by using the provided tabs."),
               tags$img(src = "https://scontent-sea1-1.xx.fbcdn.net/v/t34.0-12/28722063_580603685627571_671311557_n.png?oh=186389e7c561470c3194c5f2cb2623a0&oe=5AA3C616", width = "400px", height = "325px"),
               h2("Sources"),
               h4(strong("Used the pokeapi to obtain data")),
               h4("https://pokeapi.co/docsv2/"),
               h4(strong("Cover image")),
               h4("https://scontent-sea1-1.xx.fbcdn.net/v/t34.0-12/28722063_580603685627571_671311557_n.png?oh=186389e7c561470c3194c5f2cb2623a0&oe=5AA3C616")
             )
            
    ),
    
    tabPanel("Pokemon Moves",
             
             h2("Move Search"),
             
             sidebarLayout(
               # Sidebar Widgets
               sidebarPanel(
                 
                 textInput("MoveName", "Please Enter a Move Name")
                 
               ),
               
               
               #-------------------- ^ Sidebar Panel Rendering Goes Above  ^ ---------------------#
               #--------------------                                         ---------------------#
               #-------------------- V Main Panel Rendering Goe Below Here V ---------------------#
               
               
               mainPanel(
                 h2("Pokemon Database Information Panel"),
                 
                 h4("Showing move information for:"),
                 textOutput("moveName"),
                 tableOutput("moveTable"),
                 
                 h4("Total Number of Pokemon in Gen 1 this move can be taught to:"),
                 h4(textOutput("count")),
                 h3("Why does this Data Matter?"),
                 
                 p("This tab functions as a move search, allowing a user to search for a move in the pokemon world. 
                     As an output, this tab will return a data table consisting of all pokemon capable of learning
                     that specific move. It will also return the total number of pokemon in that table, which gives the 
                     user access to some very interesting data. For example, through the use of this application, we 
                     found the 3 most common moves in the gen 1 pokemon world were Tackle, Leer, and Growl"),
                 
                 p("This data could be useful in the context it works in, by allowing the user to calculate the strength
                     of a move based on its rarity. For example, 'clamp' is considered one of the best moves in Gen 1.
                     By using this table, you can see it can only be learned by 2 pokemon. Its effect is incredibly potent,
                     and it is a very common occurence to see these high power moves restricted to low numbers of total
                     pokemon that can learn it.")
 
                 
               ) 
             )
    ),
    
    
    
    
    tabPanel("Passive Abilities",
             h2("Passive Abilities"),
             
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
                 h3("Why does this Data Matter?"),
                 p("Each passive ability is uniquely limited to a number of pokemon as the data shows. 
                     It's important to know which ability a pokemon can carry because certain abilities are
                     ineffective to specific move, and some passives can even change the dynamics of the playing field.")
                      
                 
               )
             ) 
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
          h4(textOutput("tableMessage")),
          tableOutput("tableOutput"),
          h3("Why does this Data Matter?"),
          p("This data matters becuase it allows the user to search for Pokemon
            based on their type and this functionality enables the user to understand
            the importance of each type. For example, this table allows the user
            to understand the importance and abundance of Poison type Pokemon (a 
            fact that is often overlooked) and the rarity of Dragon type Pokemon.
            Further, this table gives data about weight and height. Combined with the
            other tabs in this app, a user can find co-relations between two seemingly
            unrelated values. For example, a user can find a co-relation between the
            height of a Pokemon and the Speed Base Stat of a Pokemon, or between a
            particular type and the location that type is found at.")
        )
      )
    ),
    
    tabPanel("Base Stats",
             h2("Base Stats"),
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
                 p(""),
                 plotOutput("plotOutput", hover = hoverOpts(id = "plot_hover")),
                 verbatimTextOutput("hover_info"),
                 h3("Why does this Data Matter?"),
                 p("This data matters becuase it allows the user to see every individual
                   stat for every single Pokemon. It shows if a particular stat is rare,
                   and therefore more valuable, and it shows how a Pokemon with a high
                   value for one stat often has a low value for many in order to receive
                   a comparable average. For example, these plots show that having high
                   attack is a common stat, but having defense is rare and might be more
                   valuable to increase the depth of your Pokemon squad."),
                 p("These plots also reveal an interesting fact. Every stat has a trendline
                   that increases with the increase in Pokemon ID. This shows that
                   Pokemon with higher Pokemon ID are stronger on average as compared to
                   Pokemon with a lower Pokemon ID.")
               )
             )
    ),
    
    tabPanel("Pokemon Sprites",
       sidebarLayout(
         sidebarPanel(
           textInput("spriteName", "Pokemon Name:")
         ),
         
         mainPanel(
           h2("Sprites"),
           h5("In case you were wondering what the pokemon looks like, here are 4 different perspectives of the desired pokemon!"),
           tabsetPanel(
             tabPanel("Front",
                imageOutput("frontSprite")
              ),
             
              tabPanel("Back",
                imageOutput("backSprite")
              ),
             
              tabPanel("Shiny",
                imageOutput("shinySprite")
              ),
             
             tabPanel("Shiny",
                      imageOutput("shinybackSprite")
             )
           )
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

