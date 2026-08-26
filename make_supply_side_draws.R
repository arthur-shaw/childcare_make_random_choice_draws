# ==============================================================================
# setup
# ==============================================================================

# set paths
proj_dir <- here::here()

# load programs
fs::path(proj_dir, "R") |>
  fs::dir_ls(type = "file", regexp = "\\.R") |>
	purrr::walk(.f = ~ source(.x))

# ==============================================================================
# create
# ==============================================================================

# create random class order numbers data frame for preloading
class_order_numbers_df <- make_order_number_df(
  n_settings = 150,
  n_classes = 60
)

# write it to disk in SuSo-friendly tab-separated value format
readr::write_tsv(
  x = class_order_numbers_df,
  file = fs::path(proj_dir, "data", "random_class_order_numbers.tsv")
)
