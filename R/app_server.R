#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @import DBI
#' @import duckdb
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic

    # Define reactive values ----
    r <- reactiveValues(
        ## Data ----
        best_movies = NULL,

        ## Colors ----
        colors = c(
            '#c84843',
            '#13afe9',
            '#e1c19b',
            '#45dbf2',
            '#6d201c',
            '#083c84',
            '#949054',
            '#639a98',
            '#2f3d53',
            '#adc2d1',
            '#2e5a50',
            '#a4a4cc'

        )
    )

    # Observe block to load data into r$best_movies
    observe({
        result <- custom_query_duckdb("SELECT * FROM stg_best_movies")
        if (is.null(result) || nrow(result) == 0) {
            r$best_movies <- data.frame(genre = character(), year = integer(), reviewer = character())  # Empty data frame
        } else {
            r$best_movies <- result
        }
    })

    # Load modules ----
    mod_summary_server("summary", r = r)
}
