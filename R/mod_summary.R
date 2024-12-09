#' summary UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_summary_ui <- function(id){
  ns <- NS(id)
  tagList(
        # Best movie by genre count
        fluidRow(
            column(
                # Movie count by genre count
                width = 6,
                plotlyOutput(ns("genre_count"))
            ),
            column(
                width = 6
            )
        )
  )
}

#' name_of_module1 Server Functions
#'
#' @noRd
mod_summary_server <- function(id,r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    output$genre_count <- renderPlotly({
        req(r$best_movies)

        # Group data by genre and count the occurrences
        genre_data <- r$best_movies |>
            # filter(
            #     year == input$year_filter,
            #     reviewer == input$reviewer_filter
            #     ) |>
            group_by(genre) |>
            summarise(count = n(), .groups = 'drop') |>
            arrange(desc(count)) # Sort data by count in descending order

        # Reorder genre factor levels based on descending count
        genre_data$genre <- factor(genre_data$genre, levels = rev(genre_data$genre))

        # Create ggplot with coord_flip()
        p <- genre_data |>
            ggplot(aes(x = genre, y = count, fill = genre)) +
            geom_bar(stat = 'identity') +
            geom_text(aes(label = count)) +
            labs(title = "Genre Count", x = "Genre", y = "Count") +
            theme_minimal() +
            coord_flip()

        # Convert ggplot to plotly
        ggplotly(p)
    })


  })
}

## To be copied in the UI
# mod_summary_ui("summary")

## To be copied in the server
# mod_summary_server("summary")
