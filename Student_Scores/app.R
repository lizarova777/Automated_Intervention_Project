rsconnect::setAccountInfo(name='lizarova777', token='A82632B84B58B29E75A9305C573AA3B9', secret='NjOyxji+TGcavxIcxuCwHe8HJwO7mk0wq3/2SoMx')

library(shiny)
library(dplyr)
library(tidyr)
library(ggplot2)

### Datasets

s <- read.csv("scores.csv", header=TRUE)

### Score and Time Interactive Visualization (By Student)
## Data Wrangling
s2 <- s %>% select(id, year, unit.choice.1,unit.choice.2, unit.choice.3, unit.choice.4, unit.choice.5, unit.choice.6) %>% group_by(id) %>% gather(Week, Unit, 3:8) 
s2$Week = ifelse(s2$Week == "unit.choice.1", 1, ifelse(s2$Week == "unit.choice.2",2, ifelse(s2$Week == "unit.choice.3",3, ifelse(s2$Week == "unit.choice.4", 4, ifelse(s2$Week == "unit.choice.5", 5, ifelse(s2$Week == "unit.choice.6", 6, 0))))))
s3 <- s %>% select(id, score1,score2, score3, score4,score5, score6) %>% group_by(id) %>% gather(ScoreType, Score, 2:7) %>% select(-c(ScoreType))
s4 <- cbind(s2,s3) %>% select(-id1)
s5 <- s %>% select(id, minutes.1,minutes.2, minutes.3, minutes.4, minutes.5, minutes.6) %>% group_by(id) %>% gather(MinuteType, Minute, 2:7) %>% select(-c(MinuteType))
s6 <- cbind(s2,s5) %>% select(-id1)
s7 <- cbind(s4,s6) %>% select(-c(id1, Unit1, Week1, year1))
s7$P_F = ifelse(s7$Score > 0.65, "Pass", "Fail")
s7 <- s7 %>% group_by(id,year) %>% mutate(Avg_Score= mean(Score)) 
s7$Class_P_F = ifelse(s7$Avg_Score > 0.65, "Pass", "Fail")
s7$year = as.factor(s7$year)
s8 <- s7 %>% group_by(Unit) %>% mutate(avg_score = mean(Score)) %>% mutate(avg_time = mean(Minute)) 
s8 <- s8 %>% select(Unit, avg_score, avg_time)
s8 <- unique(s8)
s9 <- s7 %>% group_by(Week) %>% mutate(avg_score = mean(Score)) %>% mutate(avg_time = mean(Minute)) 
s9 <- s9 %>% select(Week, avg_score, avg_time)
s9 <- unique(s9)
s10 <- s7[!duplicated(s7[,'id']),]
s10 <- s10 %>% select(year, Class_P_F) %>% group_by(year) %>% count(Class_P_F)


## Interactive Visualization

ui <- fluidPage(
  titlePanel("Student Performance on Units"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "id", label = "Student ID:", choices= s7$id, hr())
    ),
    mainPanel(
      plotOutput("timehist"),
      plotOutput("scorehist"), 
      plotOutput("weekhist")
    )
  )
)


server <- function(input, output) {
  output$timehist <- renderPlot({
    data <- reactive(s7[s7$id %in% input$id, ])
    ggplot(data(), aes(Unit,Minute)) + geom_col(fill="Red") + labs(title = "Time Spent on Units", y ="Time (in Minutes)")
  })
  output$scorehist <- renderPlot({
    data <- reactive(s7[s7$id %in% input$id, ])
    ggplot(data(), aes(Unit,Score)) + geom_col(fill="blue") + labs(title = "Student's Scores on the Units")
  })
  output$weekhist <- renderPlot({
    data <- reactive(s7[s7$id %in% input$id, ])
    ggplot(data(), aes(Week,Score)) + geom_col(fill="green") + labs(title = "Change of Student's Scores Over the Course")
  })
}

shinyApp(ui = ui, server = server)

