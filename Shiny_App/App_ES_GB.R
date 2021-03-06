#loading required packages
library(shiny)
library(ggplot2)

#creating arbitrary stress variables and assigning data frame
x <-c(1,2,3,4,6,7,8,9,7,6,3,5,6,7,8)
y <-c(5,6,7,8,4,2,2,5,6,7,8,6,5,6,5)
data1 = data.frame(x=x, y=y)

#creating the UI page
ui <- fluidPage(
    titlePanel("R Mental Evaluation"),
    sidebarLayout(
        sidebarPanel(
            helpText("This is a Drew Steen motivational survey"),
            #creating clickable action buttons
            
            actionButton("button", "Click me if you are stressed"),
            actionButton("buton", "Click me for R Stress levels"),
            selectInput("var", 
                        label = "Stress level from R",
                        choices = c("Very low", 
                                    "Low",
                                    "Medium", 
                                    "High",
                                    "Very High"),
                        selected = "High"),
            
            sliderInput("x", " time in R", min = 1, max = 50, value = 30),
            sliderInput("y", "Projects unfinished", min = 1, max = 50, value = 5),
            "then, (Stress level) is", textOutput("product")),
        
        #assigning main panel outputs      
        mainPanel(
            textOutput("selected_var"),
            plotOutput("distPlot"),
            textOutput("text")
        )
    )
)
#creating separate server functions
server <- function(input, output, session) {
    output$product <- renderText({ 
        product <- input$x * input$y
        product
        
        
    })
    output$selected_var <- renderText({ 
        paste("You have selected", input$var)
    })   
    observeEvent(input$button, {
        output$text <- renderText({"You arent stressed, back in my day we had to write R code on a calculator and use it to power jets. Get back to work"})    
    })
    observeEvent(input$buton, {
        output$distPlot <- renderPlot({
            ggplot(data1) +  geom_point(aes(x=x,y=y))   
            
            
        })       
        
    })
    
}
shinyApp(ui = ui, server = server)   