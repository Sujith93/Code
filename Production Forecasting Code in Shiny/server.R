library(shiny)
library(lubridate)
library(ggplot2)
library(forecast)
library(plyr)
library(tsintermittent)
library(Mcomp)
library(fma)
library(fpp)
library(expsmooth)
library(dplyr)

##data <- HistoricalC
##View(data)
data <- read.csv("Demand Forecasting.csv")
##class(data)
##str(data)

Sys.setenv("HIVE_HOME"="/usr/lib/hive")
Sys.setenv("HADOOP_HOME"="/usr/lib/hadoop")
Sys.setenv("JAVA_HOME"="/opt/jdk1.7.0_79")

library('RHive')
library('rJava')

rhive.init()

rhive.connect(host='192.168.84.213',port=10000,hiveServer2=TRUE,defaultFS="hdfs://192.168.84.212:8020")
#using hive database from R: 
rhive.use.database("teamc")

#show the table list in hive db: 
rhive.list.tables()

x<-rhive.query('select * from historical')

colnames(x)<-c( "Region", "Month","Year","Production.Forecast","Rig.count.Forecast", "M_Hide","Month_Year")

data<-x
data$year1<-as.Date(data$Month_Year,"%d-%M-%y")

data1<-subset(data,year(year1)>=2010)

data1$prod<-as.numeric(data1$Production.Forecast)

data1<- data1 %>% arrange(year1)

data1$YEAR<-format(data1$year1,"%Y")
data1$MONTH<-format(data1$year1,"%b")


shinyServer(function(input, output,session) {
  
  
  data<-function(place,freq)
  {
    Niobraradata<-subset(data1,Region==place)
    
    Niobraradatats<-ts(Niobraradata$prod,start=c(2010,1,1),end=c(2015,9,1),frequency = freq)
    return(Niobraradatats)
    
  }
  
  #output$contents <- renderPlot({  
  
    
   # ggplot(data1,aes(x=Year,y=prod)) + geom_line()  +ylab("Production") + facet_wrap(~Region)+theme_bw()
        
    
  #})
  
  
  
  
entity2<-reactive({
  
    entity2<-data(input$RegionNames,input$Frequency)}
  )

meanfactor<-reactive({
    
  data<-entity2()
  b<-(meanf(data,h=input$Frequency))
  return(b)
  }
  )


naive1<-reactive({
  
  data<-entity2()
  c<-(naive(data,h=input$Frequency))
  return(c)
}
)

drif<-reactive({
  
  data<-entity2()
  e<-(rwf(data,drift=TRUE,h=input$Frequency)) ##Drift method-Forecasts equal to last value plus average change.
  return(e)
}
)
Ar<-reactive({
  
  data<-entity2()
  
  return(data)
}
)


output$contents1 <- renderPlot({
    data<-entity2()
    plot(data)

  })
  
  
  output$contents2 <- renderPlot({
    
    plot(meanfactor())
   
    
  })
  
  output$contents6 <- renderPlot({
    
    plot(drif())
    
    
  })
  
  output$contents3 <- renderTable({
    
    accuracy(meanfactor())
    
  })
  
  output$contents7 <- renderTable({
    
    accuracy(drif())
    
  })
  

  output$contents4 <- renderPlot({
    
    plot(naive1())
    
    
  })
  
  output$contents5 <- renderTable({
    
    accuracy(naive1())
    
  })
  output$contents8 <- renderPlot({
    
    plot(forecast(Ar()))
    

    })
  
  output$contents9 <- renderPrint({
    
     
     arima(Ar())
  
    
  })
  
  
})

