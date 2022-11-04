test_that("wrong page sizes", {
  expect_error(deckhand(page_size = "a4 landscape"))
})
