# A demo of Functional Programming in R
# Key ideas:
#   1) Function composition
#   2) Storing functions in lists
#   3) Closures

power <- function(exponent) {
  print(environment())
  function(x) { x ^ exponent }
}

summary <- function(x) {
  funs <- c(mean, median, sd) # storing functions in lists
  lapply(funs, function(f) f(x, na.rm = TRUE))
}

fix_missing <- function(x) {
  x[x == -99] <- NA
  x
}

midpoint_composite <- function(f, a, b, n = 10) {
  points <- seq(a, b, length = n + 1)
  h <- (b - a) / n
  
  area <- 0
  for (i in seq_len(n)) {
    area <- area + h * f((points[i] + points[i + 1]) / 2)
  }
  area
}

trapezoid_composite <- function(f, a, b, n = 10) {
  points <- seq(a, b, length = n + 1)
  h <- (b - a) / n
  
  area <- 0
  for (i in seq_len(n)) {
    area <- area + h / 2 * (f(points[i]) + f(points[i + 1]))
  }
  area
}

composite <- function(f, a, b, n = 10, rule) {
  points <- seq(a, b, length = n + 1)
  
  area <- 0
  for (i in seq_len(n)) {
    area <- area + rule(f, points[i], points[i + 1])
  }
  
  area
}

# --------------------------------------------------------------
# Generate a sample datase (-99 represents missing values)
set.seed(1014)
df <- data.frame(replicate(6, sample(c(1:10, -99), 6, rep = TRUE)))
names(df) <- letters[1:6]

# Apply a function over the data frame
#   - Function composition: lapply + fix_missing
df[] <- lapply(df, fix_missing)

# Apply a function over the data frame
#   - Storing functions in lists
lapply(df, summary)

# The simplest FP tool - the anonymous function
integrate(function(x) sin(x), lower =  0, upper = 2 * pi)

# Closures 
#   - Parent function and child functions
square <- power(2)
square(2)

cube <- power(3)
cube(2)

# Case study: numerical integration
composite(sin, 0, pi, n = 10, rule = trapezoid_composite)
composite(sin, 0, pi, n = 10, rule = midpoint_composite)
