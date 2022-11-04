#' Create deckhand configuration YAML
#'
#' If `path` and `template` are `NULL` (the default), deckhand will copy the
#' default YAML file as `_deckhand.yml` in directory defined by `here::here()`.
#' If using RStudio the file will be opened as a new source document for you
#' to edit.
#'
#' @param path The path of the new file
#' @param template The path of a template file
#'
#' @export
new_config_yml <- function(path = NULL, template = NULL) {

  if (is.null(path)) {
    path <- here::here("_deckhand.yml")
  }

  if (is.null(template)) {
    template <- system.file(
      "resources", "_deckhand.yml",
      package = "deckhand2"
    )
  }

  file.copy(template, path)

  if (requireNamespace("rstudioapi", quietly = TRUE)) {
    if (rstudioapi::isAvailable()) {
      rstudioapi::navigateToFile(path)
    }
  }

}

#' Convert deckhand configuration YAML to a CSS file
#'
#' The deckhand R Markdown formats use CSS to manage page layout, to assist
#' those with limited knowledge of CSS there is a simple YAML format for
#' managing general settings.
#'
#' @param config_yml A YAML file with deckhand configuration settings
#' @param write Whether to write the CSS to a file
#' @param dh_dir Optionally the folder to look for config files
#'
#' @return If `write = TRUE` invisibly returns the path of the CSS file,
#'   otherwise it will print the CSS to the console and return it as a
#'   character vector.
#' @export
deckhand_config_to_css <- function(config_yml = NULL, write_files = TRUE,
                                   dh_dir = NULL, display = !write_files) {

  if (is.null(dh_dir)) {
    dh_dir <- here::here()
  }

  # get the config file
  chk_deckhand_config <- FALSE
  if (is.null(config_yml)) {
    if (file.exists(file.path(dh_dir, "_deckhand.yml"))) {
      config_yml <- file.path(dh_dir, "_deckhand.yml")
      chk_deckhand_config <- TRUE
    }
  } else {
    chk_deckhand_config <- TRUE
  }

  # copy configuration yml if none found exist
  if (!chk_deckhand_config) {

    if (write_files) {
      warning("No deckhand configuration found, copying defaults")

      config_yml <- file.path(dh_dir, "_deckhand.yml")

    file.copy(
      system.file("resources", "_deckhand.yml", package = "deckhand2"),
      config_yml
    )

    } else {
      config_yml <- system.file("resources", "_deckhand.yml", package = "deckhand2")
    }

  }

  # get the deckhand config settings
  deckhand_config <- get_deckhand_config(config_yml)

  # generate CSS from configuration
  deckhand_css <- generate_deckhand_css(deckhand_config)

  deckhand_css_file <- gsub(
    "\\.ya?ml$", ".css",
    tolower(config_yml)
  )

  if (file.exists(deckhand_css_file)) {
    warning("Overwriting existing deckhand CSS file")
  }

  if (display) {
      cat(deckhand_css)
  }

  if (write_files) {
    writeLines(deckhand_css, file.path(deckhand_css_file))
    return(invisible(deckhand_css_file))
  } else {
    return(invisible(deckhand_css))
  }

}

# get deckhand configuration settings from a YAML file
get_deckhand_config <- function(config_yml = NULL) {

  if (!is.null(config_yml)) {
    if (!grepl("\\.ya?ml$", config_yml)) {
      stop("config_yml does not appear to be a YAML file")
    }
  }

  # read in the base configuration
  default_config <- yaml::read_yaml(
    system.file("resources", "_deckhand.yml", package = "deckhand2")
  )

  # read in configuration yml if provided
  if (is.null(config_yml)) {
    config_in <- default_config
  } else {
    config_in <- yaml::read_yaml(config_yml)
  }

  # output collector
  deckhand_config <- list()

  # set page size variable
  if (!is.null(config_in$layout$size) &&
      !is.null(config_in$layout$orientation)) {

    if (toupper(config_in$layout$size) != "A4") {
      stop("page sizes other than A4 are not supported")
    }

    if (tolower(config_in$layout$orientation) != "landscape") {
      stop("page orientations other than landscape are not supported")
    }

    deckhand_config["page_size"] <- paste(
      toupper(config_in$layout$size),
      tolower(config_in$layout$orientation)
      )

  } else {
    deckhand_config["page_size"] <- paste(
      default_config$layout$size,
      default_config$layout$orientation
      )
  }

  # get font info
  google_headings_font <- FALSE
  google_body_font <- FALSE

  for (i in c("headings", "body")) {
    for (j in c("name", "base_format", "size", "weight", "colour")) {
      if (!is.null(config_in$fonts[[i]][[j]])) {

        # use config file settings
        deckhand_config[paste(i, j, sep = "_font_")] <- config_in$fonts[[i]][[j]]

        # set google markers
        if (j == "name") {
          if (!is.null(config_in$fonts[[i]][["google"]])) {
            if (config_in$fonts[[i]][["google"]]) {
              if (i == "headings") {
                google_headings_font <- TRUE
              } else if (i == "body") {
                google_body_font <- TRUE
              }
            }
          }
        }

      } else {

        # use default config
        deckhand_config[paste(i, j, sep = "_font_")] <- default_config$fonts[[i]][[j]]

        # set google markers
        if (i == "headings" & j == "name") {
          google_headings_font <- TRUE
        } else if (i == "body" & j == "name") {
          google_body_font <- TRUE
        }
      }
    }
  }

  # process google fonts
  if (google_headings_font && google_body_font) {
    # both heading and body are google fonts

    if (deckhand_config[["headings_font_name"]] == deckhand_config[["body_font_name"]]) {
      # heading and body font family match

      gf_hfam <- gsub("\\s", "+", deckhand_config[["headings_font_name"]])

      if (deckhand_config[["headings_font_weight"]] == deckhand_config[["body_font_weight"]]){
        # heading and body font weight match

        gf_hwght <- as.numeric(deckhand_config[["headings_font_weight"]])

        deckhand_config["google_fonts_url"] <- glue::glue(
          "https://fonts.googleapis.com/css2",
          "?family={gf_hfam}:",
          "ital,wght@0,{gf_hwght};1,{gf_hwght}",
          "&display=swap"
        )

      } else {
        # heading and body font weight don't match
        gf_hwght <- as.numeric(deckhand_config[["headings_font_weight"]])
        gf_bwght <- as.numeric(deckhand_config[["body_font_weight"]])

        deckhand_config["google_fonts_url"] <- glue::glue(
          "https://fonts.googleapis.com/css2",
          "?family={gf_fam}:",
          "ital,wght@0,{gf_bwght};0,{gf_hwght};",
          "1,{gf_bwght};1,{gf_hwght}",
          "&display=swap"
        )

      }
    } else {
      # heading and body font family don't match

      gf_hfam <- gsub("\\s", "+", deckhand_config[["headings_font_name"]])
      gf_hwght <- as.numeric(deckhand_config[["headings_font_weight"]])
      gf_bfam <- gsub("\\s", "+", deckhand_config[["body_font_font"]])
      gf_bwght <- as.numeric(deckhand_config[["body_font_weight"]])

      deckhand_config["google_fonts_url"] <- glue::glue(
        "https://fonts.googleapis.com/css2",
        "?family={gf_hfam}:",
        "ital,wght@0,{gf_hwght};1,{gf_hwght}",
        "&family={gf_bfam}:",
        "ital,wght@0,{gf_bwght};1,{gf_bwght}",
        "&display=swap"
      )

    }

  } else if (google_headings_font) {
    # if only heading font is google

    gf_hfam <- gsub("\\s", "+", deckhand_config[["headings_font_name"]])
    gf_hwght <- as.numeric(deckhand_config[["headings_font_weight"]])

    deckhand_config["google_fonts_url"] <- glue::glue(
      "https://fonts.googleapis.com/css2",
      "?family={gf_hfam}:",
      "ital,wght@0,{gf_hwght};1,{gf_hwght}",
      "&display=swap"
    )

  } else if (google_body_font) {
    # if only body font is google

    gf_bfam <- gsub("\\s", "+", deckhand_config[["body_font_name"]])
    gf_bwght <- as.numeric(deckhand_config[["body_font_weight"]])

    deckhand_config["google_fonts_url"] <- glue::glue(
      "https://fonts.googleapis.com/css2",
      "?family={gf_bfam}:",
      "ital,wght@0,{gf_bwght};1,{gf_bwght}",
      "&display=swap"
    )

  } else {
    # if no google fonts

    deckhand_config["google_fonts_url"] <- NULL

  }

  # process colours

  if (("colours" %in% names(config_in))) {

    if ("colors" %in% names(config_in)) {
      warning("<colours> and <colors> defined in config YAML, prefering <colours>")
    }

    for (k in c("primary", "light_grey", "dark_grey")) {

      if (!is.null(config_in$colours[[k]])) {
        deckhand_config[paste("colour", k, sep = "_")] <- config_in$colours[[k]]
      } else if (!is.null(config_in$colours[[gsub("e", "a", k)]])) {
        deckhand_config[paste("colour", k, sep = "_")] <- config_in$colours[[gsub("e", "a", k)]]
      } else {
        deckhand_config[paste("colour", k, sep = "_")] <- default_config$colours[[k]]
      }

    }

    if ("accents" %in% names(config_in$colours)) {
      accent_cols <- config_in$colours$accents
    } else {
      accents_cols <- default_config$colours$accents
    }

  } else if ("colors" %in% names(config_in)) {

    for (k in c("primary", "light_grey", "dark_grey")) {

      if (!is.null(config_in$colors[[k]])) {
        deckhand_config[paste("colour", k, sep = "_")] <- config_in$colors[[k]]
      } else if (!is.null(config_in$colors[[gsub("e", "a", k)]])) {
        deckhand_config[paste("colour", k, sep = "_")] <- config_in$colors[[gsub("e", "a", k)]]
      } else {
        deckhand_config[paste("colour", k, sep = "_")] <- default_config$colours[[k]]
      }

    }

    if ("accents" %in% names(config_in$colors)) {
      accent_cols <- config_in$colors$accents
    } else {
      accents_cols <- default_config$colours$accents
    }

  } else {

    for (k in c("primary", "light_grey", "dark_grey")) {
      deckhand_config[paste("colour", k, sep = "_")] <- default_config$colours[[k]]
    }

    accents_cols <- default_config$colours$accents

  }

  # process accent colours
  for (ac in seq_along(accent_cols)) {
    deckhand_config[paste("colour_accent", ac, sep = "_")] <- accent_cols[ac]
  }

  deckhand_config["colour_accent_n"] <- ac

  class(deckhand_config) <- "deckhand_config"

  return(deckhand_config)

}

# general validation
is_deckhand_config <- function(deckhand_config) {

  if (typeof(deckhand_config) != "list") {
    return(FALSE)
  }

  if (class(deckhand_config) != "deckhand_config") {
    return(FALSE)
  }

  if (length(deckhand_config) != 20) {
    return(FALSE)
  }

  dc_names <- c(
    "page_size",
    "headings_font_name",
    "headings_font_base_format",
    "headings_font_size",
    "headings_font_weight",
    "headings_font_colour",
    "body_font_name",
    "body_font_base_format",
    "body_font_size",
    "body_font_weight",
    "body_font_colour",
    "google_fonts_url",
    "colour_primary",
    "colour_light_grey",
    "colour_dark_grey",
    "colour_accent_1",
    "colour_accent_2",
    "colour_accent_3",
    "colour_accent_4",
    "colour_accent_n"
  )

  if (!all.equal(names(deckhand_config), dc_names)) {
    return(FALSE)
  }

  dc_classes <- c(
    "character",
    "character",
    "character",
    "integer",
    "integer",
    "character",
    "character",
    "character",
    "integer",
    "integer",
    "character",
    "character",
    "character",
    "character",
    "character",
    "character",
    "character",
    "character",
    "character",
    "integer"
  )

  item_classes <- character(0)

  for (i in deckhand_config) {
    item_classes <- c(item_classes, class(i))
  }

  if (!identical(item_classes, dc_classes)) {
    return(FALSE)
  }

  if (unique(lengths(deckhand_config)) != 1) {
    return(FALSE)
  }

  return(TRUE)

}

# convert deckhand config into CSS
generate_deckhand_css <- function(deckhand_config = NULL) {

  if (is.null(deckhand_config)) {
    deckhand_config <- get_deckhand_config()
  }

  if (!is_deckhand_config(deckhand_config)) {
    stop("deckhand_config is not in valid deckahnd_config format")
  }

  base_css <- glue::glue_data(
  "
  h1, h2, h3, h4, h5, h6 {{
    font-family: '{headings_font_name}', {headings_font_base_format};
    font-weight: {headings_font_weight};
    color: var(--colour-headings);
    margin: 0px;
    padding: 0px;
  }}

  h1 {{
    font-size: {headings_font_size}pt;
  }}

  h2, h3, h4, h5, h6 {{
    font-size: {body_font_size}pt;
    margin-top: 6pt;
  }}

  body, p {{
    font-family: '{body_font_name}', {body_font_base_format};
    font-weight: {body_font_weight};
    font-size: {body_font_size}pt;
    color: var(--colour-body);
  }}

  p {{
    margin-bottom: 6pt;
  }}

  .text-primary {{
    color: var(--colour-primary);
  }}

  .bg-primary {{
    background-color: var(--colour-primary);
  }}

  .text-light-grey {{
    color: var(--colour-light-grey);
  }}

  .bg-light-grey {{
    background-color: var(--colour-light-grey);
  }}

  .text-light-gray {{
    color: var(--colour-light-gray);
  }}

  .bg-light-gray {{
    background-color: var(--colour-light-gray);
  }}

  .text-dark-grey {{
    color: var(--colour-dark-grey);
  }}

  .bg-dark-grey {{
    background-color: var(--colour-dark-grey);
  }}

  .text-dark-gray {{
    color: var(--colour-dark-gray);
  }}

  .bg-dark-gray {{
    background-color: var(--colour-dark-gray);
  }}

  .text-white {{
    color: var(--colour-white);
  }}

  .bg-white {{
    background-color: var(--colour-white);
  }}

  .draft {{
    border: 1px solid var(--colour-light-grey);
  }}
  ",
  .x = deckhand_config
  )

  root_colours <- c(
    "--colour-headings" = deckhand_config$headings_font_colour,
    "--colour-body" = deckhand_config$body_font_colour,
    "--colour-primary" = deckhand_config$colour_primary,
    "--colour-dark-grey" = deckhand_config$colour_dark_grey,
    "--colour-dark-gray" = deckhand_config$colour_dark_grey,
    "--colour-light-grey" = deckhand_config$colour_light_grey,
    "--colour-light-gray" = deckhand_config$colour_light_grey,
    "--color-headings" = deckhand_config$headings_font_colour,
    "--color-body" = deckhand_config$body_font_colour,
    "--color-primary"  = deckhand_config$colour_primary,
    "--color-dark-grey" = deckhand_config$colour_dark_grey,
    "--color-dark-gray" = deckhand_config$colour_dark_grey,
    "--color-light-grey" = deckhand_config$colour_light_grey,
    "--color-light-gray" = deckhand_config$colour_light_grey,
    "--color-white" = "#ffffff"
  )

  accents <- unlist(deckhand_config[grepl("colour_accent_\\d", names(deckhand_config))])
  names(accents) <- gsub("_", "-", names(accents))
  accents_us <- accents
  names(accents_us) <- gsub("colour", "color", names(accents_us))

  accents_all <- c(accents, accents_us)

  accents_css <- list()

  for (ac in seq_along(accents_all)) {
    accents_css <- append(
      accents_css,
      glue::glue_data(
        "
        .text-{names(accents_all[ac])} {{
          color: var(--{names(accents_all[ac])});
        }}

        .bg-{names(accents_all[ac])} {{
          background-color: var(--{names(accents_all[ac])});
        }}
        ",
        .x = accents_all[ac]
      )
    )
  }

  accents_css <- paste0(accents_css, collapse = "\n\n")

  names(accents_all) <- paste0("--", names(accents_all))

  root_colours <- c(
    root_colours,
    accents_all
  )

  root_block <- paste(
    ":root {",
    paste0("  ", names(root_colours), ": ", root_colours, collapse = ";\n"),
    "}",
    sep = "\n"
  )

  deckhand_css <- paste(root_block, base_css, accents_css, sep = "\n\n")

  if (!is.null(deckhand_config$google_fonts_url)) {
    deckhand_css <- paste(
      glue::glue_data("
      @import url('{google_fonts_url}');
      ", .x = deckhand_config
      ),
      deckhand_css,
      sep = "\n\n"
    )
  }

  return(deckhand_css)

}


