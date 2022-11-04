# test get_deckhand_config()
test_that("read configuration yaml", {

  expect_visible(get_deckhand_config())

  expect_error(
    get_deckhand_config("test.txt"),
    "config_yml does not appear to be a YAML file"
  )

  test_config <- get_deckhand_config()

  expect_length(test_config, 20)
  expect_s3_class(test_config, "deckhand_config")
  expect_type(test_config, "list")

  expect_named(
    test_config,
    c(
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
    ),
    ignore.order = TRUE
  )

})


# test is_deckhand_config()
test_that("check configuration object", {

  # check validates default config
  expect_true(is_deckhand_config(get_deckhand_config()))

  # must be a list
  expect_false(is_deckhand_config(character()))

  # must have class deckhand_config
  expect_false(is_deckhand_config(list()))

  # must have length 20
  expect_false(is_deckhand_config(structure(list(), class = "deckhand_config")))
  expect_false(is_deckhand_config(structure(rep(list(), 19), class = "deckhand_config")))
  expect_false(is_deckhand_config(structure(rep(list(), 21), class = "deckhand_config")))

  # elements must have names
  expect_false(is_deckhand_config(structure(rep(list(), 20), class = "deckhand_config")))

  # elements must have correct classes
  expect_false(
    is_deckhand_config(
      structure(
        list(
          "page_size" = logical(),
          "headings_font_name" = logical(),
          "headings_font_base_format" = logical(),
          "headings_font_size" = logical(),
          "headings_font_weight" = logical(),
          "headings_font_colour" = logical(),
          "body_font_name" = logical(),
          "body_font_base_format" = logical(),
          "body_font_size" = logical(),
          "body_font_weight" = logical(),
          "body_font_colour" = logical(),
          "google_fonts_url" = logical(),
          "colour_primary" = logical(),
          "colour_light_grey" = logical(),
          "colour_dark_grey" = logical(),
          "colour_accent_1" = logical(),
          "colour_accent_2" = logical(),
          "colour_accent_3" = logical(),
          "colour_accent_4" = logical(),
          "colour_accent_n" = logical()
        ),
        class = "deckhand_config"
      )
    )
  )

  # elements must be of length 1
  expect_false(
    is_deckhand_config(
      structure(
        list(
          "page_size" = character(2),
          "headings_font_name" = character(2),
          "headings_font_base_format" = character(2),
          "headings_font_size" = integer(2),
          "headings_font_weight" = integer(2),
          "headings_font_colour" = character(2),
          "body_font_name" = character(2),
          "body_font_base_format" = character(2),
          "body_font_size" = integer(2),
          "body_font_weight" = integer(2),
          "body_font_colour" = character(2),
          "google_fonts_url" = character(2),
          "colour_primary" = character(2),
          "colour_light_grey" = character(2),
          "colour_dark_grey" = character(2),
          "colour_accent_1" = character(2),
          "colour_accent_2" = character(2),
          "colour_accent_3" = character(2),
          "colour_accent_4" = character(2),
          "colour_accent_n" = integer(2)
        ),
        class = "deckhand_config"
      )
    )
  )


})

# test generate_deckhand_css()
test_that("check CSS generation", {

  expect_error(
    generate_deckhand_css("test"),
    "deckhand_config is not in valid deckahnd_config format"
  )

  expect_visible(generate_deckhand_css())

  expect_snapshot(cat(generate_deckhand_css()))

})

# test deckhand_config_to_css()
test_that("check config to CSS end user function", {

  skip_on_cran()

  # get a temporary directory for testing
  tmp_dir <- file.path(tempdir(), "deckhand-tests")

  # clean out directory if already exists
  if (dir.exists(tmp_dir)) {
    if (length(dir(tmp_dir)) != 0) {
      for (tempf in dir(tmp_dir)) {
        file.remove(tmp_dir)
      }
    }
  } else {
    dir.create(tmp_dir)
  }

  # no config file should give a warning
  expect_warning(deckhand_config_to_css(dh_dir = tmp_dir))

  # config must be a yaml file
  expect_error(deckhand_config_to_css("test.txt", dh_dir = tmp_dir))

  # writing CSS file returns invisible file path
  css_file <- expect_invisible(suppressWarnings(deckhand_config_to_css(dh_dir = tmp_dir)))

  # output file name is a CSS file
  expect_true(grepl("\\.css$", css_file))

  # expect CSS if write is FALSE
  expect_snapshot(deckhand_config_to_css(write = FALSE))
  expect_snapshot_value(deckhand_config_to_css(write = FALSE, display = FALSE))

})
