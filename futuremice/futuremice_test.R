library(mice)

## First check: are we actually faster?
tictoc::tic()
reg_imp <- mice(boys, m = 250, print = F)
tictoc::toc()

tictoc::tic()
ftr_imp <- futuremice(boys, m = 250, n.core = 4)
tictoc::toc()
## Yes we are.

## Users get a prompt, if the answer is yes, futuremice continues, but still 
## outputs a warning. If the answer is no, futuremice sets the seed to NA, 
## specifies parallelseed for the user and continues thereafter.
## If the answer is cancel, futuremice stops.
ftr_imp <- futuremice(boys, m = 4, n.core = 4, seed = 1)

## Check future over futures:

library(furrr)

plan(multisession)

tictoc::tic()
furrr_over_mice <- future_map(1:10, ~mice(boys, 20, print = F), .progress = TRUE)
tictoc::toc()

tictoc::tic()
furrr_over_futuremice <- future_map(1:10, ~ futuremice(boys, 20, n.core = 4, use.logical = FALSE), .progress = TRUE)
tictoc::toc()

## Does not break down, also does not improve speed (of course)

futuremice(boys, 20, n.core = 10, use.logical = FALSE)

## More cores than I have