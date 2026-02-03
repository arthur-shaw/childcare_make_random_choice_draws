#' Make a comma-separated list of numbers to reorder classes
#'
#' @description
#' Implement the following algorithm:
#'
#' - Construct a set of numbers from 1 to `n`
#' - Select `n` elements from that list without replacement
#' - Return the list of numbers as a comma-separated atomic character vector.
#'
#' @param n Numeric upper end of the range for the number list.
#'
#' @return Character Comma-separated list of numbers from 1 to `n`.
make_order_numbers_for_group <- function(n = 50) {
  order_numbers_vec <- base::sample(
    x = c(1:n),
    size = n,
    replace = FALSE
  )

  order_numbers_chr <- as.character(order_numbers_vec) |>
    paste(collapse = ",")

  return(order_numbers_chr)

}

#' Make a nested list of numbers to reorder classes
#'
#' @description
#' Classes fall into 3 age-based sampling categories:
#'
#' - Ages 0-3
#' - Ages > 3
#' - Mixed ages, where min and max ages that span the two categories
#'
#' Accordingly, create a character list that is structured as follows:
#'
#' - Each category's list is delimited by `;`
#' - Each category's numbers are delimited by `,`
#'
#' The first block will be for ages 0-3, the second for > 3, and the last
#' for mixed ages.
#'
#' @inheritParams make_order_numbers_for_group
#'
#' @return Character. Nested list described in the description.
make_order_numbers <- function(n = 50) {

  group_0_to_3 <- make_order_numbers_for_group(n = n)
  group_3_plus <- make_order_numbers_for_group(n = n)
  group_mixed <- make_order_numbers_for_group(n = n)

  numbers_combined <- c(group_0_to_3, group_3_plus, group_mixed) |>
    paste(collapse = ";")

  return(numbers_combined)

}

#' Make a data frame of class order numbers for each childcare setting
#'
#' @description
#' Data frame of numbers to reorder classes and thereby select the first N
#' randomly.
#'
#' @param n_settings Numeric. Number of settings for which to create numbers.
#' @param n_classes Numeric. Maximum number of classes in a setting.
#'
#' @return Data frame. Consisting of:
#'
#' - `setting_id`. Simple count number that is an ID for each childcare setting.
#' - `random_class_rowcodes`. Character string of random draws for a childcare
#' setting of arbitrary number of classes/groups.
make_order_number_df <- function(
  n_settings,
  n_classes = 50
) {

  numbers_as_vec <- purrr::map_chr(
    .x = c(1:n_settings),
    .f = ~ make_order_numbers(n = n_classes)
  )

  numbers_df <- data.frame(
    setting_id = c(1:n_settings),
    random_class_order = numbers_as_vec
  )

  return(numbers_df)

}
