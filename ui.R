#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Taiguara Tupinambás, Data Product CP, August 30, 2018"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      numericInput("samples",
                   label="Number of Samples", 
                   min = 1, 
                   max = 1000000, step = 1,
                   value = 1),
       sliderInput("bgValue",
                   label="Background Pixels %", 
                   min = 1, 
                   max = 100, post  = " %", 
                   value = 50),
       submitButton("Submit")
    ),
    
    # Show a plot of the generated distribution
    
    mainPanel(h1("Image Segmentation"),
              tabsetPanel(type="tabs",
                          tabPanel("Instructions and Motivation",
                                   h2("Motivation"),
                                   p("Image segmentation methods are important to break down an image into meaningful regions."),
                                   p("We will use as an example an image of coins. We wish to determine the regions where the coins appear"),
                                   imageOutput("preImage"),
                                   h2("Instructions"),
                                   p("Two methods were applied: a simple thresholding method with linear model; and a watershed method. In this app you can change parameters for each method and check the results for both of them"),
                                   tags$ol(
                                     tags$li("Thresholding and linear model: You can selec the amount of samples for the linear model. The higher the better"), 
                                     tags$li("Watershed: you can select the percentage of the background pixels. A small value is ideal, but not too small.")
                                   ),
                                   p("Go the results page and check the default results. They don't look so good"),
                                   p("Try selecting a higher number of samples and choosing a background percentage between 5 and 20%")),
                          tabPanel("Results Comparison",
                                   imageOutput("thresh"),
                                   imageOutput("water"))
                          )
    )
  )
))
