# Final Project UI Code
# Pokemon Database API and CSV data scraping and wranging

library("shinythemes")
library("ggplot2")
library("leaflet")
library("shiny")
pokemonInfo <- read.csv("data/PokemonInfo.csv")
moveInfo <- read.csv("data/PokemonMoves.csv")

my.ui <- fluidPage(theme = shinytheme("darkly"),
   tags$head(
     tags$style(HTML(".leaflet-container { background: #ffffff; }"))
   ),
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
                
                # Print out tables and explain why this data is relevant in a larger context 
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
  
     tabPanel("Table or Map 3 [Karan]"
              
     ),
     
     tabPanel("Kanto Map",
              leafletOutput("pokemon.map")
     )
   )
) 

shinyUI(my.ui)
