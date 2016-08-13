# A demo of Functional Programming in R
# Key idea:
#   Function composition: lapply + fix_missing

fix_missing <- function(x) {
  x[x == -99] <- NA
  x
}

# Generate a sample datase (-99 represents missing values)
set.seed(1014)
df <- data.frame(replicate(6, sample(c(1:10, -99), 6, rep = TRUE)))
names(df) <- letters[1:6]
# df (-99 represents a missing value)
#    a  b c   d   e f
# 1  1  6 1   5 -99 1
# 2 10  4 4 -99   9 3
# 3  7  9 5   4   1 4
# 4  2  9 3   8   6 8
# 5  1 10 5   9   8 6
# 6  6  2 1   3   8 5

# Apply a Function over a List/Vector/Data Frame
df[] <- lapply(df, fix_missing) # function compositon: lapply + fix_missing
# df (-99 replaced with NA)
#    a  b c  d  e f
# 1  1  6 1  5 NA 1
# 2 10  4 4 NA  9 3
# 3  7  9 5  4  1 4
# 4  2  9 3  8  6 8
# 5  1 10 5  9  8 6
# 6  6  2 1  3  8 5
