library(shinythemes)
library(shiny)
library(DT)

# Define UI for application that draws a histogram
ui <- navbarPage(
  theme = shinytheme("cosmo"),
  title = "TELESCOPE FORMULAS",
  tabPanel("DATA",
           sidebarLayout(
             sidebarPanel(
              sliderInput("length", "Length of Telscope in mm", min = 100, max = 3000, value = 750, step = 50),
              sliderInput("aparture", "Aparture in mm", min = 50, max = 500, value = 100, step = 10),
              sliderInput("eyepiece", "Eyepiece in mm", min = 5, max = 56, value = 24, step = 1),
              sliderInput("fov", "FOV of Eyepiece in degrees", min = 30, max = 120, value = 50, step = 1),
               textInput("words", "Search")

),
mainPanel(
  # fluidRow(csvDownloadUI("dwnld", "DOWNLOAD"), style = "padding:10px"),
  textOutput("data"),
  textOutput('data3'),
  textOutput('data4'),
  textOutput('data5'),
  dataTableOutput("table2")
)
  
)
           ))




# Define server logic required to draw a histogram
server <- function(input, output) {
   
fratio <- reactive({
  x <- input$length/input$aparture
  return(x)
})

fieldofview <- reactive({
y <- input$fov/input$eyepiece
return(y)
})

mag <- reactive({
  z <- input$length/input$eyepiece
  return(z)
})
tvof <- reactive({
  mag <- input$length/input$eyepiece
  h <- input$fov/mag
  return(h)
})
exitpupil <- reactive({
  a <- input$eyepiece/fratio()
  return(a)
})
output$data <- renderText({
  fratio()
  paste("Fratio is", fratio())
})


output$data4 <- renderText({
  tvof()
  paste("True Field of View is", tvof(), "degrees")
})

output$data5 <- renderText({
  mag()
  paste("Magnification is", mag())
})
output$data3 <- renderText({
  exitpupil()
  paste("Exit Pupil is", exitpupil(), "degrees")
})
}
# Run the application 
shinyApp(ui = ui, server = server)

