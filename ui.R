library(shiny)
library(ggplot2)
library(rCharts)
dataset <- mtcars # read data
shinyUI(
  navbarPage("Motor Trend Car Road Tests", # add navigation bar including plot and instructions
             tabPanel("Instructions", # description of this application
                      mainPanel(
                        includeMarkdown("instructions.Rmd")
                      )
             ),
             
     tabPanel("Plot",
      sidebarPanel( # input section - how to make the plot

        selectInput('x', 'X Variables', names(dataset)), 
        selectInput('y', 'Y Variables', names(dataset)),
        checkboxInput('smooth', 'Smooth'),
        selectInput('facet_row', 'Facet Row', c(None='.', names(dataset))),
        selectInput('facet_col', 'Facet Column', c(None='.', names(dataset)))
      ), 
      mainPanel( # plot secstion
        plotOutput('plot')
      )
    ),
    
  tabPanel("Impact of Vehicle Weight on Fuel consumption", # predict value egression model on given pairs of variables
           sidebarPanel(
             numericInput('wtinput','Weight, lb',1000)
             ),
           mainPanel(
             h3('Results of Fuel consumption on a given weight'),
             h4('mpg value, Miles/galon'),
             verbatimTextOutput('result')
             )
    )
  
)
)