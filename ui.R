# Final Project UI Code

my.ui <- fluidPage(
  
  titlePanel("Pokemon Data API Exploration Shiny Application"),
  sidebarLayout(
    # Sidebar Widgets
    sidebarPanel(
      h2("Table Interactivity Tools"),
      
      # Use the slider for something (only show a generation, or X amount of values)
      sliderInput("SliderValue", "Slider [Potential Widget",
                  min = 0, # THESE VALUES ARE ARBITRARY 
                  max = 50,
                  value = 0
      ),
      
      # Perhaps you can search for a specific pokemon
      textInput("PokemonName", "Text Input Widget"),
      
      #ADD MORE WIDGETS HERE ONCE YOU HAVE THE TABLE MADE
      
      selectInput("Generation","Please Select Generation to Parse [Conner]",
                  c("Gen1",
                  "Gen2",
                  "Gen3",
                  "Gen4",
                  "Gen5",
                  "Gen6"
                  ))
    ),
    
    
    #-------------------- ^ Sidebar Panel Rendering Goes Above  ^ ---------------------#
    #--------------------                                         ---------------------#
    #-------------------- V Main Panel Rendering Goe Below Here V ---------------------#
    
    
    mainPanel(
      h2("Pokemon Database Viewing Panel"),
      tabsetPanel(
        # TABLE TABS 
        tabPanel("Table 1 [Conner]",
                h2("Pokemon Generation Data"),
                
                # Lets me show them what they are typing in inside my panel + makes reactive
                textOutput("pokemon")
                # Goal: Let User inpu
                 ),
        tabPanel("Table 2 [Josh]"
                
                 ),
        tabPanel("Table or Map 3 [Karan]"
                
                 ),
        tabPanel("Map [Andrew]"
                 
                )
      )
    ) 
  )
) 


shinyUI(my.ui)