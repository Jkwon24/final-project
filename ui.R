# Final Project UI Code


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
                                 # TO BE MOVED TO KARAN'S SECTION
                                 # h2("Pokemon Search!"),
                                 # textInput("PokemonName", "Please Enter a Pokemon Name"),
                                  
                                  
                                  h2("Move Search"),
                                  textInput("MoveName", "Please Enter a Move Name")
                                  
                                              
                                           
                                ),
                                
                                
                                #-------------------- ^ Sidebar Panel Rendering Goes Above  ^ ---------------------#
                                #--------------------                                         ---------------------#
                                #-------------------- V Main Panel Rendering Goe Below Here V ---------------------#
                                
                                
                                mainPanel(
                                  # LASTS THINGS I NEED TO DO:
                                  # - FIX COLUMN NAMES
                                  # - ADD GGPLOT GRAPHIC
                                  # - FIND OUT HOW TO USE NROW ON THE GENERATED TABLE
                                  # - USE THAT VALUE TO GIVE TEXT BASED FACTS (LIKE % OF ALL POKEMON THAT CAN LEARN IT)
                                  
                                  h2("Pokemon Database Information Panel"),
                                  
                                  # Lets me show them what they are typing in inside my panel + makes reactive
                                  h3("Showing information on:"),
                                  textOutput("moveName"),
                                  tableOutput("moveTable"),
                                  
                                  # I cant figure out how to get the nrow value, since it always overwrites the table 
                                  h4(moveString <- "The selected move is common to [Insert Count Here] Pokemon")
                                  #renderText(moveCount) CANNOT GET THIS WORKING
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
