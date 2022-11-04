#' Grid layout pages
#'
#' @param css Additional CSS files to include
#' @param page_size Set page size
#' @param ... Additional arguments passed to pagedown
#'
#' @export
deckhand <- function(css = NULL, page_size = NULL, ...) {

  if (page_size != "A4 landscape") {
    stop("Only A4 landscape is permitted")
  }

  core_css <- system.file(
    "resources", "css",
    c("deckhand-a4-landscape.css"),
    package = "deckhand2"
  )

  if (!is.null(css)) {
    css <- c(core_css, css)
  } else {

    # try and find a _deckhand.css file
    if (file.exists(file.path(getwd(), "_deckhand.css"))) {
      dh_css <- file.path(getwd(), "_deckhand.css")
    } else if (file.exists(file.path(getwd(), "css", "_deckhand.css"))) {
      dh_css <- file.path(getwd(), "css", "_deckhand.css")
    } else if (file.exists(file.path(here::here("_deckhand.css")))) {
      dh_css <- file.path(here::here("_deckhand.css"))
    } else {

      # find a deckhand yaml file and convert it
      if (file.exists(file.path(getwd(), "_deckhand.yml"))) {
        config_yml <- file.path(getwd(), "_deckhand.yml")
        dh_dir <- getwd()
        warn_msg <- config_yml
      } else if (file.exists(file.path(here::here("_deckhand.yml")))) {
        config_yml <- file.path(here::here("_deckhand.yml"))
        dh_dir <- here::here()
        warn_msg <- config_yml
      } else {
        config_yml <- NULL
        dh_dir <- getwd()
        warn_msg <- "default settings"
      }

      warning("No _deckhand.css file located, generating from ")
      dh_css <- deckhand_config_to_css(config_yml = config_yml, dh_dir = dh_dir)
      message("Deckhand CSS saved as: ", dh_css)

    }

    css <- c(core_css, dh_css)

  }

  pagedown::html_paged(
    css = css,
    number_sections = FALSE,
    ...
  )


}
