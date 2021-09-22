#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(data.table)
library(ggplot2)
library(plyr)
library(callr)
library(shinyBS)
library(shinyWidgets)
library(DT)
library(shinydashboard)
# Define UI for application that draws a histogram
ui <- dashboardPage(
  skin='black',
  dashboardHeader(title="Decision Making Tool for Optimal Age-Based Maintenance under Population Heterogeneity",titleWidth = 900),
  dashboardSidebar(sidebarMenu(
    menuItem("Parameter Selection", tabName = "parameter"),
    menuItem("Decision Making", tabName = "decision"),
    menuItem("Replacement History", tabName = "data_table")
  )),
  dashboardBody(
    h4('Version 1.0.0-alpha-1'),
    tabItems(  tabItem(tabName = "parameter",
                       fluidRow(
                       box(
             title=h3("Parameter Selection"), width=15,
              h4('In this demonstrator, the failure distribution of spare parts are assumed to be discrete Weibull distribution. Scale parameters of weak and strong components
                               are assumed as 10 and 20 respectively. In the plots below, you can see the how cost and action change with respect to belief and remaining lifespan.'))),
              sidebarLayout(
                sidebarPanel(
                             
                             shiny::selectInput(
                               "shape",
                               "Choose a shape parameter for Discrete Weibull Distribution:",
                               list("5","10")
                             )
                             ,
                             selectInput(
                               inputId = "cp",
                               label = "Select a preventetive replacement cost (corrective replacement cost=1 money unit)",
                               list("0.05","0.1","0.2")
                             ),
                             actionButton('button','Submit')
                             ),
                
                mainPanel(
                  h3('Plots'),
                  tabsetPanel(type = "tabs",
                              tabPanel("Optimal Cost", plotOutput("distPlot1")),
                              tabPanel("Optimal Action", plotOutput("distPlot2"))
                            )
                ))
              
      ),
      tabItem(tabName = "decision",
              fluidRow(
              box(title=
   h3("Optimal Decision Making for Next Preventive Maintenance Time"), width=15,
   h4('There are two state inputs in this model: Belief of a component coming from a weak population and remaning lifepsan of the system. Please choose these inputs from the slider below to calculate optimal next planned maintenance time and associated costs to it:' ))),
   
   fluidRow(
     
     box(
  title= 'States', width = 6, solidHeader = TRUE, status = "primary",
       sliderInput(inputId = "select_z", "Select the remaining lifespan",  min = 0, max = 200, value = 100),
                 sliderInput(inputId = "select_p", "Select the belief of the component coming from a weak population ",
                             min = 0, max = 1, value = 0.5)),
 box(
    title='Results', width = 6, solidHeader = TRUE, status = "primary",
              h4('Optimal next planned maintenance time (time unit): '),
              h4(strong(textOutput("resultsaction"))),
              h4('Expected next cycle cost (money unit):'),
              h4(strong(textOutput("resultsimmediatecost"))),
              h4('Expected total cost until the end of lifespan (money unit):'),
              h4(strong(textOutput("resultscost"))))),
  
 fluidRow(
   box( title='Replacement Realization', width=15,
   h4('You can enter the realized type of replacement and time between two replacements below to calculate the new belief and remaining lifespan.'))),
 fluidRow(
   box(width = 6, solidHeader = TRUE, status = "primary",  

 selectInput(inputId = 'replacement','Is realization a preventive or corrective replacement?',list('preventive','corrective')),
                   numericInput(inputId ='realization', 'Enter the realized time to between two replacements:',value=1),actionButton('update', 'Update')), 
 
    box(
      title='New belief and remaining lifespan', width = 6, solidHeader = TRUE, status = "primary",
      p(' You can update the inputs above with these updated values to see new optimal action and expected costs.'),
      h4('Updated belief is:'),
      h4(strong(textOutput('newbelief'))),
      h4('Updated remaining lifespan is (time units):'),
      h4(strong(textOutput('newlifespan'))))),
 fluidRow(
   box(
     
     
     h4('If you want to save this realization moment please click to the button below. You can see the submitted observations in Replacement history tab. '), width=15,
    
     actionButton('submit2', 'Submit Observation')
     
   )
 )
 ),
  
  tabItem(tabName = "data_table",
          h2("Historical Replacement Data"),
  #actionButton('savecsv', 'Download the data in .csv format'),
  #actionButton('saverdata', 'Download the data in .Rdata format'),
  DT::dataTableOutput("responses", width = 300),
  actionButton("remove", "Clear the table permanently"),
  bsModal("warning", "Warning!", "remove",
          p("If you clear the table permanently and did not downloaded the data beforehand, you will lose this information permanently. Do you agree with continuing?"),
          actionButton("BUTyes", "Yes"),
          actionButton("BUTno", "No")),
  #checkboxInput(inputId = 'compile','Do you want to generate your own dataset? It may take longer.'),
  mainPanel(textOutput('sum'))
    ))))




server <- function(input, output,session) {
  output$value <- renderText({
    req(input$go)
    isolate(input$password)
  })
  
  saveData <- function(data) {
    data <- as.data.frame(t(data))
    colnames(data)<-c('Belief', 'Lifespan', 'Exp._total_Cost', 'Exp._cycle_Cost', 
                      'Action', 'Replacement_type', 'Replacement_time', 'Realized_cycle_cost', 'Updated_belief', 'updated_lifespan')
    if (exists("responses")) {
      responses <<- rbind(responses, data)
    } else {
      colnames(data)<-c('Belief', 'Lifespan', 'Exp._total_Cost', 'Exp._cycle_Cost', 
                        'Action', 'Replacement_type', 'Replacement_time', 'Realized_cycle_cost', 'Updated_belief', 'updated_lifespan')
      responses <<- data
      
    }
  }
  
  loadData <- function() {
    if (exists("responses")) {
      responses
    }
  }
  records=NULL
  observeEvent(input$button,{
    
    dataInput<-reactive({ 
      #setwd(input$wd)
      load('tool_int.RData')
      data=overall_results
      data<-data.table(data)
      cols_value<-c(paste0("Value_",input$shape,"_",input$cp))
      cols_tau<-c(paste0("tau_",input$shape,"_",input$cp))
      data<-data[,c('p','z',cols_tau,cols_value),with=F]
      
    })
    
    
    outputaction<-reactive({
      data=req(dataInput())
      p_increment=0.0025
      out_act=data[p==round_any(input$select_p,p_increment)&z==input$select_z,c(3)]
      return(out_act)
    })
    
    output$resultsaction<-renderText(
      {
        
        val=req(outputaction())
        paste(val)
      })
    
    outputcost<-reactive({
      data=req(dataInput())
      p_increment=0.0025
      out_cost=round(data[p==round_any(input$select_p,p_increment)&z==input$select_z,c(4)],3)
      return(out_cost)
      
    })
    output$resultscost<-renderText({
      val2=req(outputcost())
      paste(val2)
    })
    
    immediate_cost<-reactive({
      
      b_1=10
      b_2=20
      F<-function(x,beta,alpha){
        x<-x-1
        return(1-exp(-((x+1)/beta)^alpha))
      }
      f<-function(x,beta,alpha){
        x<-x-1
        return(exp(-((x)/beta)^alpha)-exp(-((x+1)/beta)^alpha))
      }
      
      alpha=as.numeric(input$shape)
      val=req(outputaction())
      C_pr=ifelse(input$select_z==val,0,as.numeric(input$cp))
      cycle_cost=input$select_p*(F(val,b_1,alpha)+C_pr*(1-F(val,b_1,alpha)))+(1-input$select_p)*(F(val,b_2,alpha)+(C_pr*(1-F(val,b_2,alpha))))
      return(round(cycle_cost,2))
    })
    output$resultsimmediatecost<-renderText({
      val3=req(immediate_cost())
      paste(val3)
    })
    
    observeEvent(input$submit2,{
      record2<-reactive({
        P_new_val=req(newbelief())
        records=c(input$select_p,input$select_z,outputcost(),immediate_cost(),outputaction(),input$replacement,input$realization,
                  ifelse(input$replacement=='preventive',ifelse(input$select_z!=0,input$cp,0),1),P_new_val,max(input$select_z-input$realization,0))
      })
   
      saveData(record2())
      output$responses <- DT::renderDataTable({
        input$submit
        loadData()
      })  
      
    })
    # observeEvent(input$showtable,{
    #   output$responses <- DT::renderDataTable({
    #     input$submit
    #     loadData()
    #   })  
    # })
    
    observeEvent(input$BUTyes, {
      toggleModal(session, "modalnew", toggle = "close")
      responses <<- NULL
      output$responses <- DT::renderDataTable({
        input$submit
        loadData()
      })  
    })
    
    observeEvent(input$BUTno, {
      toggleModal(session, "modalnew", toggle = "close")
    })
    newbelief<-reactive({
      time<-input$realization
      event<-ifelse(input$replacement=='preventive',0,1)
      p=input$select_p
      p_increment=0.0025
      b_1=10
      b_2=20
      F<-function(x,beta,alpha){
        x<-x-1
        return(1-exp(-((x+1)/beta)^alpha))
      }
      f<-function(x,beta,alpha){
        x<-x-1
        return(exp(-((x)/beta)^alpha)-exp(-((x+1)/beta)^alpha))
      }
      
      alpha=as.numeric(input$shape)
      p_new=ifelse(round(event,1)==round(1,1),p*f(time,b_1,alpha)/(p*f(time,b_1,alpha) +(1-p)*f(time,b_2,alpha)), p*(1-F(time,b_1,alpha))/(p*(1-F(time,b_1,alpha))+(1-p)*(1-F(time,b_2,alpha))))
      p_new= ifelse(is.na(p_new),0,p_new)
      p_new=round_any(p_new,p_increment,f=ceiling)
      return(p_new)
    })
    
    
    
    v <- reactiveValues(doPlot = FALSE)
    
    observeEvent(input$update, {
      # 0 will be coerced to FALSE
      # 1+ will be coerced to TRUE
      v$doPlot <- input$update
    })
    
    observeEvent(input$submit, {
      v$doPlot <- FALSE
    })  
    
    output$newbelief <- renderText({
      if (v$doPlot == FALSE) return()
      
      isolate({
        p_new =req(newbelief())

        
        paste(mean(p_new))
      })
    })
    
    
    output$newlifespan<-renderText({
      if(v$doPlot==FALSE)return()
      isolate({
   z_new=max(input$select_z-input$realization,0)
   
   })
      print(z_new)
    
})
     
    output$distPlot1 <- renderPlot({
      data=req(dataInput())
      # generate bins based on input$bins from ui.R
      colnames(data)[3]<-'OptimalAction'
      colnames(data)[4]<-'Cost'
      par(mfrow=c(1,2))
      ggplot(data, aes(x=p, y=z,  color=Cost)) + 
        geom_point() + theme(text = element_text(size = 20),
                             #panel.background = element_blank(),
                             plot.margin = margin(2, 2, 2, 2, "cm")) +
        # ggtitle(paste0("Optimal Cost with respect to belief and remaining lifespan"))+
        labs(x = 'Belief', y = 'Remaining Lifespan')+
        theme(
          axis.title.x = element_text(size = 14, face = "bold.italic"),
          axis.title.y = element_text(size = 14, face = "bold.italic")
        ) + scale_color_viridis_c()
      
    })
    
    output$distPlot2 <- renderPlot({
      data=req(dataInput())
      # generate bins based on input$bins from ui.R
      colnames(data)[3]<-'Action'
      colnames(data)[4]<-'Cost'
      ggplot(data, aes(x=p, y=z,  color=Action)) + 
        geom_point() + theme(text = element_text(size = 20),
                             panel.background = element_blank(),
                             plot.margin = margin(2, 2, 2, 2, "cm")) +
        #ggtitle(paste0("Optimal Action with respect to belief and remaining lifespan"))
        labs(x = 'Belief', y = 'Remaining Lifespan')+
        theme(
          axis.title.x = element_text(size = 14, face = "bold.italic"),
          axis.title.y = element_text(size = 14, face = "bold.italic")
        ) + scale_color_viridis_c()
      
    })
    
    
    
    output$sum<-renderText(
      if(input$compile==T){
        
        source('try.R',local = TRUE)
        rs=r_session$new()
        data=rs$run(optimal_function, list(input$cp, input$shape))  
        #  data=optimal_function(as.numeric(input$cp),input$shape)
        # paste(data[200,])
      }
    ) }
  )
  #make colors more distinctive
  #plot with ggplot2
  
}

# Run the application 
shinyApp(ui = ui, server = server)

