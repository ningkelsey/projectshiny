library(shiny)
library(ggplot2)

function(input, output) {
  

  output$plot <- renderPlot({ #draw the plot
    
    p <- ggplot(mtcars, aes_string(x=input$x, y=input$y)) + geom_point() 
    
    facets <- paste(input$facet_row, '~', input$facet_col) #Add facets
    if (facets != '. ~ .')
      p <- p + facet_grid(facets)
    
    if (input$smooth) #Add smoothed condition mean
      p <- p + geom_smooth()
    
    print(p)

  }, height=700)
  
  mpgpred<-function(wtinput) { #function to predict mpg by given weight
    wti<-wtinput/1000
    fit<-lm(mpg~wt,data=mtcars)
    predict(fit,data.frame(wt=wti),interval="prediction")
  }
  output$result<-renderPrint({mpgpred(input$wtinput)})

}