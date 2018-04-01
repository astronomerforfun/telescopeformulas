

library(shiny)
library(DT)

source("KingCountyScriptscratch.R", local = TRUE)
# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("KING COUNTY CRIME"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        dateRangeInput("dte", "Date Range", start = "2017-01-01"),
        selectInput("cty", "City", selected = "AUBURN", choices = sort(unique(df$city), decreasing = F)),
         selectInput("type",
                     "Incident Types",
                     selected = NULL, choices = sort(unique(df$incident_description), decreasing = F)
                     )
      ),

   
      # Show a plot of the generated distribution
      mainPanel(
        dataTableOutput("table"),
        leafletOutput("map")
         
      )
   )
)


# Define server logic required to draw a histogram
server <- function(input, output) {

#reactive for table based on dates
tablereact <- reactive({
  df_cty_auburn <- df%>%
    filter(incident_datetime >= input$dte[1] & incident_datetime <= input$dte[2], city == input$cty)%>%
    group_by(incident_description)%>%
    summarise(n = n())
  return(df_cty_auburn)
})

output$table <- renderDataTable({
  datatable(tablereact(), rownames = F)
})

date_map_react <- reactive({
  df_map <- df%>%
    filter(incident_datetime >= input$dte[1] & incident_datetime <= input$dte[2], incident_description == input$type, city == input$cty)
  print(df_map)
})



output$map <- renderLeaflet({
  leaflet(data = date_map_react())%>% 
    addTiles()%>%
    addMarkers(~longitude, ~latitude, popup = ~paste(address_1, day_of_week, hour_of_day, incident_datetime))
  
})
}

# Run the application 
shinyApp(ui = ui, server = server)

