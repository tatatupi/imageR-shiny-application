#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(imager)
library(dplyr)
library(png)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  im <- load.image("./coins.png")
  
  output$preImage <- renderImage({
    # Return a list containing the filename and alt text
    imOut <- t(im[,,1,1])
    outfile <- tempfile(fileext = ".png")
    writePNG(imOut, target = outfile)
    
    list(src = outfile,
         contentType = "image/png",
         alt = "This is alternate text")
  }, deleteFile = FALSE)
  
  
  output$thresh <- renderPlot({
    
    d <- as.data.frame(im)
    ##Subsamble, fit a linear model
    m <- sample_n(d,input$samples) %>% lm(value ~ x*y,data=.) 
    ##Correct by removing the trend
    im.c <- im-predict(m,d)
    out <- threshold(im.c)
    out <- clean(out,3) %>% imager::fill(7)
    plot(im,main="Thresholding",axes=FALSE)
    highlight(out)

  })

  
  output$water <- renderPlot({
    
    d <- as.data.frame(im)
    ##Subsamble, fit a linear model
    m <- sample_n(d,input$samples) %>% lm(value ~ x*y,data=.) 
    ##Correct by removing the trend
    im.c <- im-predict(m,d)
    
    bgPercent <- paste(toString(input$bgValue),"%",sep="")
    fgPercent <- paste(toString(100-input$bgValue),"%",sep="")
    
    bg <- (!threshold(im.c,bgPercent))
    fg <- (threshold(im.c,fgPercent))
    #Build a seed image where fg pixels have value 2, bg 1, and the rest are 0
    seed <- bg+2*fg
    
    edges <- imgradient(im,"xy") %>% enorm
    p <- 1/(1+edges)
    
    ws <- (watershed(seed,p)==1)
    
    ws <- bucketfill(ws,1,1,color=2) %>% {!( . == 2) }
    
    plot(im,main="Watershed",axes=FALSE)
    out2 <- clean(ws,5)
    highlight(out2,col="green")

  })
  

})
