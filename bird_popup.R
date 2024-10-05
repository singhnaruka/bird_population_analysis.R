library(shiny)
library(leaflet)
library(htmltools)
library(shinyjs)
library(readxl)

# Replace the file path with your actual file path
sampling_data <- read_excel("/Users/bhavyasingh/Downloads/sampling_data.xlsx")
sampling_data$longitude <- as.numeric(as.character(sampling_data$longitude))
sampling_data$latitude <- as.numeric(as.character(sampling_data$latitude))

# user-defined UI
ui <- fluidPage(
  leafletOutput("map")
)

bird_height <- 60
# Define server logic for connecting interface to elements
server <- function(input, output, session) {
  output$map <- renderLeaflet({
    # Set the initial map view for Eurasia
    map <- leaflet() %>%
      addTiles() %>%
      addMarkers(
        data = sampling_data,  # Use the sampling_data dataframe
        lng = ~longitude,
        lat = ~latitude,
        icon = icon(
          iconUrl = "/Users/bhavyasingh/Downloads/major.png",
          iconWidth = bird_height * 1.39,
          iconHeight = bird_height,
          iconAnchorX = 100,
          iconAnchorY = 100
        ),
        popup = lapply(1:nrow(sampling_data), function(i) {
          img_tag <- htmltools::tags$img(
            src = "/Users/bhavyasingh/Downloads/major.png",
            height = bird_height, width = bird_height
          )
          htmltools::tagList(img_tag, "Bird Popup")
        })
      )
    
    map
  })
}

# Run the application
shinyApp(ui = ui, server = server)
