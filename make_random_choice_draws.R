# ==============================================================================
# setup
# ==============================================================================

# activate project-specific virtual environment
renv::restore(prompt = FALSE)

# set paths
proj_dir <- here::here()

# load programs
fs::path(proj_dir, "R") |>
  fs::dir_ls(type = "file", regexp = "\\.R") |>
	purrr::walk(.f = ~ source(.x))

# ==============================================================================
# create df of M random draws for N members in O households
# ==============================================================================

# create choices data frame for preloading
choices_df <- make_random_choices_per_member(
  n_hholds = 2000,
  n_members = 45,
  choices = c(1:150),
  n_choices = 10,
  seed = 8675309
)

# write it to disk in SuSo-friendly tab-separated value format
readr::write_tsv(
  x = choices_df,
  file = fs::path(proj_dir, "data", "dce_choices.tsv")
)
