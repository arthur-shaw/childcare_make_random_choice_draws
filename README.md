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

### Demand-side 👨‍👩‍👧‍👦

To set up:

- Open `make_demand_side_draws.R`
- Change `n_hholds` to the number of observations for which random selections should be generated (e.g., full sample size, current batch of assignments, etc.)
- Change `n_members` if households may have more than 45 members.

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

To use, run `make_demand_side_draws.R`

The resulting output in `data/dce_choices.tsv` has the following structure

- One row per household, with `hhid` as a sequential identifier.
- One choice string per household that contains a nested list of choices.
The outer list is a semi-colon delimited list of rows
(e.g., `{row 1 list};{row 2 list};{row 3 list}`).
The inner list is a sequence of numbers for the selected row
(e.g., `{choice 1},{choice 2},{choice 3},{choice 4}`).

To explain by way of practical example, consider `21,83,17;91,19,9;37,31,2`.
The row-level values are delimited by `;`.
The first row's values, for example, are `21,83,17`.
The choice-level values are comma-delimited.
The second choice for row one is `83`.

For example:

```tsv
hhid	choices
1	20,43,10,11,13,19;41,14,55,23,21,59;27,31,17,36,13,34;3,6,28,59,38,57;35,48,5,52,9,19;15,54,20,24,46,56;49,54,57,8,16,48;12,18,37,54,6,38;2,7,27,6,45,11;9,14,43,48,40,16;4,47,58,19,49,6;35,1,52,34,37,27;40,4,29,24,41,7;53,8,41,35,14,25;39,30,12,9,48,59;35,24,28,37,49,54;60,16,32,24,21,37;49,38,12,35,47,50;44,51,59,1,9,48;48,43,17,26,31,52;21,41,17,5,46,37;1,13,19,53,24,40;57,23,26,32,11,22;31,23,26,52,6,16;8,30,39,21,15,25;15,4,14,17,11,49;28,39,43,4,10,18;39,30,2,45,51,41;59,12,6,10,26,24;30,28,58,53,6,16;51,12,7,30,56,52;2,10,4,9,36,1;47,49,45,55,15,8;8,25,3,43,60,23;16,26,48,45,60,17;52,31,5,34,40,2;11,36,18,53,47,2;7,29,2,19,9,46;51,2,45,20,39,43;8,9,30,32,5,31;43,12,51,25,21,29;1,42,27,22,53,49;7,25,29,60,23,15;48,55,28,2,45,4;57,38,45,53,20,32
2	19,48,6,8,15,34;29,16,47,22,39,12;12,27,15,50,16,31;29,59,44,28,14,51;9,14,51,10,6,17;55,52,9,54,47,17;54,3,42,57,14,8;37,56,50,30,46,57;22,57,35,14,45,7;37,60,21,41,22,33;13,23,39,50,36,42;11,13,60,2,33,4;32,27,20,18,29,11;21,3,15,43,25,55;59,46,38,9,51,8;53,31,17,28,13,29;10,7,47,43,9,50;1,24,45,37,2,35;50,7,34,15,30,44;49,39,9,14,20,10;58,15,8,27,22,16;25,2,21,41,57,44;22,53,50,9,17,13;53,5,54,39,55,60;49,53,24,26,54,25;42,23,54,12,45,55;59,43,13,7,4,39;51,34,59,40,14,9;4,46,30,53,27,21;35,60,19,26,45,3;17,55,60,13,44,34;53,24,46,57,48,55;34,41,33,56,9,30;14,1,36,54,34,15;8,56,57,6,18,50;50,18,53,11,17,19;46,1,51,20,55,26;4,33,56,42,19,6;11,17,6,8,26,35;21,5,42,4,8,41;41,51,32,5,15,48;32,17,30,47,23,13;15,55,51,37,10,56;26,51,58,53,19,27;1,51,23,6,22,33
3	9,35,59,50,54,11;28,56,10,5,2,51;26,10,48,57,58,21;23,11,39,26,15,56;10,2,25,23,24,28;4,8,34,31,49,18;51,31,40,43,57,18;47,36,38,32,35,11;26,11,7,48,34,24;49,38,29,17,42,59;34,29,55,18,52,53;40,28,6,42,57,49;11,50,12,31,13,38;6,57,45,32,27,29;47,2,49,55,22,28;8,51,17,9,57,25;6,49,58,16,18,43;48,27,56,58,50,17;28,52,18,4,16,24;43,48,59,20,31,34;39,47,2,49,36,54;9,1,8,19,49,37;40,26,27,57,45,49;50,20,60,45,39,55;31,36,40,60,44,4;50,56,44,47,31,51;15,13,17,30,52,24;23,8,16,47,17,35;14,49,54,42,18,20;5,1,53,17,42,9;23,52,50,38,2,24;3,28,38,49,47,41;16,42,46,25,15,57;52,3,26,39,34,60;51,4,3,57,59,11;8,29,49,30,3,23;21,41,19,3,2,8;41,14,44,31,29,25;17,52,37,49,24,15;7,6,21,2,30,49;9,32,11,51,50,1;39,10,24,53,18,45;9,51,54,35,55,21;28,50,32,29,5,17;28,4,9,2,45,17
```

### Supply-side 🏫

To set up:

- Open `make_supply_side_draws.R`
- Change `n_settings` to the number of childcare settings for which random numbers need to be generated
- Change `n_classes` if childcare settings may have more than 50 classes.

In particular:

```r
class_order_numbers_df <- make_order_number_df(
  n_settings = 150, # <--------- CHANGE THIS VALUE
  n_classes = 50
)
```

To use, run `make_supply_side_draws.R`

The resulting output in `data/random_class_order_numbers.tsv` has the following structure:

- `setting_id`. Simple count number that is an ID for each childcare setting.
- `random_class_rowcodes`. Character string of random draws for a childcare
setting of arbitrary number of classes/groups.

The `random_class_rowcodes` column contains a list of `n_classes` numbers between 1 and `n_classes` in order to shuffle the order of classes randomly.

For example:

```tsv
setting_id	random_class_rowcodes
1	5,16,6,41,45,9,1,29,36,24,12,34,42,27,17,22,30,47,8,7,25,14,10,20,48,32,23,39,33,43,3,44,4,21,28,19,2,37,50,40,15,35,11,26,38,31,18,13,49,46;22,12,14,42,6,23,27,2,49,15,34,13,5,20,40,30,31,9,17,16,10,4,1,37,36,21,25,38,19,33,26,28,45,47,41,48,32,46,44,39,50,35,43,8,7,18,11,24,29,3;25,13,1,26,10,5,46,11,2,32,22,38,35,49,44,28,4,27,37,50,3,6,15,16,45,17,39,31,19,42,48,41,47,21,18,9,30,34,40,33,7,29,43,24,36,8,12,14,20,23
2	38,3,40,46,15,25,10,50,43,28,35,37,32,31,22,11,48,44,1,26,20,12,6,19,33,5,14,23,45,41,4,24,17,7,16,29,8,49,27,34,13,39,2,9,42,47,21,18,36,30;47,34,48,6,17,32,29,37,3,15,20,39,31,45,24,26,28,5,40,23,11,49,30,36,27,4,14,44,10,1,33,41,43,18,38,16,19,25,46,7,35,9,13,50,12,8,2,22,42,21;37,3,29,26,46,35,15,28,20,40,38,14,12,27,47,32,43,33,45,23,50,41,7,5,9,25,13,39,16,4,2,19,17,34,24,42,11,44,21,36,10,48,22,1,8,30,18,6,31,49
3	28,48,49,46,26,38,34,15,8,40,1,31,30,2,3,9,7,10,44,18,33,32,6,11,17,12,25,24,41,21,35,42,37,43,45,16,39,13,5,4,50,36,27,14,20,47,29,19,23,22;32,49,6,22,34,50,40,33,27,28,19,43,7,35,48,38,18,37,3,31,13,5,41,25,1,12,45,14,16,17,15,44,47,29,24,42,36,8,9,11,10,23,20,39,4,26,46,30,2,21;31,30,6,19,15,38,16,35,18,4,2,43,44,7,49,32,36,41,39,23,42,37,33,25,27,17,5,8,1,34,3,50,12,11,40,26,10,45,14,21,47,24,9,20,29,28,48,46,22,13
```
