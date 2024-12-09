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
        movies = NULL,

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

        ),
        genre_colors = c(
            Action = "#c84843",
            Comedy = "#13afe9",
            Drama = "#e1c19b",
            Fantasy = "#45dbf2",
            Horror = "#6d201c",
            `Science Fiction` = "#083c84",
            Superhero = "#949054",
            Musical = "#639a98",
            Crime = "#2f3d53",
            Romance = "#adc2d1",
            Thriller = "#2e5a50",
            Adventure = "#a4a4cc"
        )
    )

    # Observe block to load data into r$best_movies
    observe({
        result <- custom_query_duckdb("SELECT * FROM movies")
        if (is.null(result) || nrow(result) == 0) {
            r$movies <- data.frame(genre = character(), year = integer(), reviewer = character())  # Empty data frame
        } else {
            r$movies <- result
        }
    })

    # Load modules ----
    mod_summary_server("summary", r = r)
}
