#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinyjs
#' @import bslib
#' @noRd
app_ui <- function(request) {
    tagList(
        # Add external resources
        golem_add_external_resources(),

        # Application Layout with Filters Inside Tabs
        bslib::page_navbar(
            title = "Movie Awards",
            theme = bs_theme(
                bootswatch = "sketchy",
                base_font = font_google("Inter")
            ),

            # Tab: Summary ----
            bslib::nav_panel(
                "Summary",
                fluidPage(
                    # Shared Filter Bar for Year and Reviewer
                    div(class = "filter-bar", common_filters()),

                    # Main Content for Summary
                    plotOutput("summary_plot")
                )
            ),

            # Tab: Trends ----
            bslib::nav_panel(
                "Trends",
                fluidPage(
                    # Common filters with additional tab-specific filters in the same row
                    div(
                        class = "filter-bar",
                        common_filters(
                            list(
                                column(
                                    3,
                                    shiny::selectInput(
                                        "specific_filter",
                                        "Category:",
                                        choices = c("All", "Shallow", "Moderate", "Deep")
                                    )
                                ),
                                column(
                                    3,
                                    shiny::sliderInput(
                                        "specific_range",
                                        "Specific Range:",
                                        min = 10,
                                        max = 30,
                                        value = c(15, 25)
                                    )
                                )
                            )
                        )
                    ),
                    plotOutput("trends_plot")
                )
            )

        )
    )
}



#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    # Include Font Awesome from CDN
    tags$link(rel = "stylesheet", href = "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.1/css/all.min.css"),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "movieawardsapp"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
