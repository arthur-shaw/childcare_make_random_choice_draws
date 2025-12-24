## Objective 🎯

The CAPI applications for Childcare rely on preloaded random numbers:

- **Demand-side.** Choose N images to show in the discrete choice experiment.
- **Supply side.** Choose 2 classrooms to observe.

## Installation 🔌

Simply:

- Download the repository
- Run the code

The `{renv}` lockfile does the necessary for setting and provisioning project-level dependencies.

## Usage 👩‍💻

The TL;DR:

- Run the relevant script
- Find the output `tsv` file in `data/`

### Demand-side

To set up:

- Open `make_random_choice_draws.R`
- Change `n_hholds` to the number of observations for which random selections should be generated (e.g., full sample size, current batch of assignments, etc.)

In particular:

```r
choices_df <- make_random_choices_per_member(
  n_hholds = 2000, # <-------  CHANGE THIS VALUE
  n_members = 45,
  choices = c(1:60),
  n_choices = 6,
  seed = 8675309
)
```

To use: run `make_random_choice_draws.R`

### Supply-side

To set up:

- Open `make_supply_side_draws.R`
- Change `n_settings` to the number of childcare settings for which random numbers need to be generated

In particular:

```r
class_draws_df <- make_class_draws_per_setting(
  n_settings = 150 # <--------- CHANGE THIS VALUE
)
```

To use, run `make_random_choice_draws.R`
