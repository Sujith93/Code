library(shiny)

shinyUI(fluidPage(
  tags$body(
    background="oil.jpg"
    
  ),

  img(src='myImage.jpg', align = "left"),theme = "svs.css",
  
  titlePanel("     Demand Forecasting with Time Series"),
  sidebarLayout(
    sidebarPanel(
      selectInput("RegionNames","Select the Region",c("Utica Region"="Utica Region", 
                                                      "Permian Region"="Permian Region",
                                                      "Niobrara Region"="Niobrara Region",
                                                      "Marcellus Region"="Marcellus Region",
                                                      "Haynesville Region"="Haynesville Region",
                                                      "Eagle Ford Region"="Eagle Ford Region"
                                                      ,"Bakken Region"="Bakken Region"),selected ="Utica Region",selectize = TRUE ),
      sliderInput("Frequency","Number of Months use for Forecast:",min=1,max=24,value=12,step=1)
      
    
  ), 
  
     mainPanel(
      
      tabsetPanel(
       # tabPanel("Main Plot",plotOutput('contents')),
        tabPanel("Time Series",plotOutput('contents1')),
        tabPanel("meanf-Forecast Series",plotOutput('contents2'),tableOutput('contents3')),
        tabPanel("Naive Forecast Series",plotOutput('contents4'),tableOutput('contents5')),
        tabPanel("Drift method-Forecast ",plotOutput('contents6'),tableOutput('contents7')),
        tabPanel("Arima-Forecast ",plotOutput('contents8'),verbatimTextOutput('contents9'))
        
      )
      
      )
  )
)
)

 

