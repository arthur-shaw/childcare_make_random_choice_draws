#' Make a comma-separated list of up to 2 draws
#'
#' @description
#' Construct a comma-separated list of up to 2 random draws.
#'
#' From the set of integers between 1 and N, draw up to 2 random numbers.
#' If N == 1, draw 1 with certainty. For N > 1, draw 2 numbers without
#' replacement.
#'
#' Return the draws as an atomic character vector composed of a comma-separated
#' list.
#' 
#' @param n_classes Numeric. Number of classes in the childcare setting.
#'
#' @return Character. Comma-separated list of up to 2 numbers between 1 and N.
make_draw <- function(
  n_classes
) {

  if (n_classes == 1) {

    return("1")

  } else {

    draw <- sample(
      x = c(1:n_classes),
      size = 2,
      replace = FALSE
    )

    draw_chr <- as.character(draw) |>
      paste(collapse = ",")

    return(draw_chr)

  }

}

#' Make N sets of draws per childcare setting, one for each
#' possible number of classes in a childcare setting.
#'
#' @param n_classes Number of (possible) classes for which to make a draw.
#'
#' @return Character vector of draws of size `n_classes`.
#'
#' @importFrom purrr map_chr
make_draws_per_setting <- function(
  n_classes = 200
) {

  c(1:n_classes) |>
    purrr::map_chr(.f = ~ make_draw(n_classes = .x)) |>
    paste(collapse = ";")

}

#' Make a set of draws for N childcare settings
#'
#' @param n_settings Numeric. Number of settings for which to generate draws.
#' @param n_classes Numeric. Number of (possible) classes for which to generate draws.
#'
#' @return Data frame. Consisting of:
#'
#' - `setting_id`. Simple count number that is an ID for each childcare setting.
#' - `random_class_rowcodes`. Character string of random draws for a childcare
#' setting of arbitrary number of classes/groups.
#'
#' @importFrom purrr map_chr
make_class_draws_per_setting <- function(
  n_settings,
  n_classes = 200
) {

  draws_as_vec <- purrr::map_chr(
    .x = c(1:n_settings),
    .f = ~ make_draws_per_setting(n_classes = n_classes)
  )

  draws_df <- data.frame(
    setting_id = c(1:n_settings),
    random_class_rowcodes = draws_as_vec
  )

  return(draws_df)

}
