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

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
   
  # output$distPlot <- renderPlot({
  #   
  #   # generate bins based on input$bins from ui.R
  #   x    <- faithful[, 2] 
  #   bins <- seq(min(x), max(x), length.out = input$bins + 1)
  #   
  #   # draw the histogram with the specified number of bins
  #   hist(x, breaks = bins, col = 'darkgray', border = 'white')
  #   
  # })
  filename <- normalizePath(file.path('./images',
                                      paste('img')))
  candy <- load.image(filename)
  
  ind=0;
    for i=1:size(img,1)
    for j=1:size(img,2)
    ind=ind+1;
    x(ind,:)=img(i,j,:);
    end
  end
  
  
  output$outImage <- renderImage({
    # Return a list containing the filename and alt text
    
    m <- 2
    p <- input$bins
    eps <- 0.01
    N <- 10000
    
    n = dim(candy)[4]
    
    
    
    list(src = filename,
         alt = paste("Number of segments", input$bins))
    
  }, deleteFile = FALSE)
  
  # 
  # output$outImage <- renderImage({
  #   
  # }
  # 
  
})
