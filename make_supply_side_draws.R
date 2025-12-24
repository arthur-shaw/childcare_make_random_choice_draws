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
# create 
# ==============================================================================

# create random selection data frame for preloading
class_draws_df <- make_class_draws_per_setting(
  n_settings = 150
)

# write it to disk in SuSo-friendly tab-separated value format
readr::write_tsv(
  x = class_draws_df,
  file = fs::path(proj_dir, "data", "random_class_selections.tsv")
)
