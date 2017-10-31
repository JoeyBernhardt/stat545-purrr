
#### Purrr lesson for stat 545


(v_log <- c(TRUE, FALSE, FALSE, TRUE))
(v_int <- 1:4)
(v_doub <- 1:4 * 1.2)
(v_char <- letters[1:4])




## index a vector
v_char[c(FALSE, FALSE, TRUE, TRUE)]
v_char[v_log]

v_doub[2:3]
v_char[-4]


v_int[0]
typeof(v_int[0])
v_doub[100]
typeof(v_doub[100])


v_log
as.integer(v_log)
v_int
as.numeric(v_int)
v_doub
as.character(v_doub)
as.character(as.numeric(as.integer(v_log)))


v_doub_copy <- v_doub
str(v_doub_copy)
v_doub_copy[3] <- "uhoh"
str(v_doub_copy)


(big_plans <- rep(NA_integer_, 4))
str(big_plans)
big_plans[3] <- 5L
## note that big_plans is still integer!
str(big_plans)
## note that omitting L results in coercion of big_plans to double
big_plans[1] <- 10
str(big_plans)


(x <- list(1:3, c("four", "five")))
(y <- list(logical = TRUE, integer = 4L, double = 4 * 1.2, character = "character"))
(z <- list(letters[26:22], transcendental = c(pi, exp(1)), f = function(x) x^2))



## ways to index a list
y
x[c(FALSE, TRUE)]
y[2:3]
z["transcendental"]

x[[2]]

y[["double"]]


z$transcendental


my_vec <- c(a = 1, b = 2, c = 3)
my_list <- list(a = 1, b = 2, c = 3)


## Consider how to square the integers 1 through n. 

n <- 5
res <- rep(NA_integer_, n) 
for (i in seq_len(n)) {
  res[i] <- i ^ 2
}
res


n <- 5
seq_len(n) ^ 2

mm <- seq_len(n)
mm^2


## elementwise exponentiation of numeric vector works
exp(v_doub)
## put the same numbers in a list and ... this no longer works :(
(l_doub <- as.list(v_doub))
exp(l_doub)

library(purrr)
map_dbl(l_doub, exp)

identical(exp(v_doub), map_dbl(l_doub, exp))

### then introduce the various types of map functions


library(stringr)

fruit

str(fruit)

fruit %>% 
  map(str_split, " ")

fruit %>% 
  map_chr(str_to_upper)

fruit %>% 
  map(nchar)

?str


library(listviewer)


map(c(9, 16, 25), sqrt)


map(got_chars[1:4], "name")


jsonedit(got_chars)

map(got_chars[5:8], 3)


map_chr(got_chars[9:12], "name")
map_chr(got_chars[9:12], 3)

### For each character, the second element is named "id".
## This is the character's id in the API Of Ice And Fire. Use a type-specific form of map() and an extraction shortcut to extract these ids into an integer vector.
got_chars %>% 
  map_int(2)


# Use your list inspection strategies to find the list element that is logical. There is one! Use a type-specific form of map() and an extraction shortcut to extract these values for all
## characters into a logical vector.


is.logical(got_chars[[1]][["alive"]])


library(repurrrsive)
library(listviewer)
library(jsonlite)
library(dplyr)
library(tibble)
library(purrr)


str(gh_users, max.level = 1)
str(gh_users[[1]], list.len = 6)


map(gh_users, "login")


map(gh_users, 18)


gh_users %>% 
  map("login")
gh_users %>% 
  map(18)


map_chr(gh_users, "login")

jsonedit(gh_users)

map_chr(gh_users, 18)
map_chr(gh_users, "name")


## Use a type-specific form of map() and an extraction shortcut to extract the ids of these 6 users.

gh_users %>% 
  map_int("id") %>% 
  str


gh_users[[3]][c("name", "login", "id", "location")]


x <- map(gh_users, `[`, c("login", "name", "id", "location"))

class(`[`)


map_df(gh_users, `[`, c("login", "name", "id", "location"))


gh_users %>% {
  tibble(
    login = map_chr(., "login"),
    name = map_chr(., "name"),
    id = map_int(., "id"),
    location = map_chr(., "location")
  )
}


map_df(gh_users, `[`, c("following", "name", "created_at"))


str(gh_repos, max.level = 1)


jsonedit(gh_repos)


gh_repos %>%
  map_chr(c(1, 3))
