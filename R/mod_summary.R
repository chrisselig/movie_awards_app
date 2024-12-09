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

        # Count by Genre ----
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

        # Define threshold for label placement
        label_threshold <- max(genre_data$count) * 0.25


        # Create ggplot with coord_flip()
        p <- genre_data |>
            ggplot(aes(x = genre, y = count, fill = genre)) +
            geom_bar(stat = "identity") + # Horizontal bars
            geom_text(aes(
                label = count,
                color = ifelse(count > label_threshold, "inside", "outside"),
                hjust = ifelse(count > label_threshold, 0.5, -1.5) # Adjust larger values further inside/outside
            ),
            position = position_nudge(y = ifelse(genre_data$count > label_threshold, -0.2, 0.2)), # Fine-tune y-axis nudging
            size = 4, show.legend = FALSE) + # Adjust text size
            scale_fill_manual(values = r$colors) + # Use consistent genre colors
            scale_color_manual(
                values = c("inside" = "white", "outside" = "black") # White text for inside, black for outside
            ) +
            labs(title = "Genre Count", x = NULL, y = NULL) +
            theme_minimal() +
            theme(
                axis.text.x = element_blank(),      # Remove x-axis text labels
                axis.title.x = element_blank(),     # Remove x-axis title
                panel.grid = element_blank(),       # Remove all grid lines
                axis.ticks.x = element_blank(),     # Remove x-axis ticks
                legend.position = "none"            # Turn off legend
            ) +
            coord_flip()

        # Convert ggplot to plotly
        ggplotly(p)
    })

    # Total time of movies watched ----

    # Movie count by country ----

    # Count by director ----

    # Count by director gender ----

    # County by director race ----

    # Count by Actor ----

    # Count by actor gender ----

    # Count by actor race ----

    # Count by Distributor ----

    # Count by Release Month ----

  })
}

## To be copied in the UI
# mod_summary_ui("summary")

## To be copied in the server
# mod_summary_server("summary")
