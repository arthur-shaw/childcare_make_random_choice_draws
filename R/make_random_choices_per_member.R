#' Make a data set of random choices for M members for N hholds
#'
#' @description
#' Create a data frame of random choices with the following structure:
#'
#' - One row per household, with `hhid` as a sequential identifier.
#' - One choice string per household that contains a nested list of choices.
#' The outer list is a semi-colon delimited list of rows
#' (e.g., `{row 1 list};{row 2 list};{row 3 list}`).
#' The inner list is a sequence of numbers for the selected row
#' (e.g., `{choice 1},{choice 2},{choice 3},{choice 4}`).
#'
#' To explain by way of practical example, consider `21,83,17;91,19,9;37,31,2`.
#' The row-level values are delimited by `;`.
#' The first row's values, for example, are `21,83,17`.
#' The choice-level values are comma-delimited.
#' The second choice for row one is `83`.
#'
#' @param n_hholds Integer. Number of households to produce.
#' @param n_members Integer. Number of members to produce per household.
#' @param choices Numeric vector. Set of choices from which to draw
#' (e.g. `c(1:150)` for choices between 1 and 150).
#' @param n_choices Integer. Number of choices to draw without replacement
#' from `choices` for each member.
#' @param varname_choices Character. Name of the variable containing the
#' character string of selected choices.
#' @param seed Integer. Seed to reproduce random process.
#'
#' @importFrom tidyr uncount
#' @importFrom dplyr rowwise mutate ungroup group_by summarise rename
#' @importFrom glue glue_collapse
make_random_choices_per_member <- function(
  n_hholds,
  n_members,
  choices,
  n_choices,
  varname_choices = "choices",
  seed
) {

  set.seed(seed)

  random_choices <- data.frame(
    hhid = 1:n_hholds,
    n_members = n_members
  ) |>
    # create N roster rows for each household
    tidyr::uncount(
      weights = n_members,
      .id = "members__id"
    ) |>
    # draw 3 random numbers,
    # concatenating them into a comma-delimited string
    dplyr::rowwise() |>
    dplyr::mutate(
      nums = sample(
        x = choices,
        size = n_choices,
        replace = FALSE
      ) |>
        glue::glue_collapse(sep = ",")
    ) |>
    dplyr::ungroup() |>
    # concatenate the number strings for each row into a single hhold string
    dplyr::group_by(hhid) |>
    dplyr::summarise(
      nums = glue::glue_collapse(nums, sep = ";")
    ) |>
    dplyr::ungroup() |>
    dplyr::rename(!!rlang::sym(varname_choices) := nums)

  return(random_choices)

}
