#' Calculate scagnostics for a scatterplot
#' 
#' Scagnostics summarize potentially interesting patterns in 2d scatterplot
#' 
#' Current scagnostics are: 
#' 
#' \itemize{
#'   \item Outlying
#'   \item Skewed
#'   \item Clumpy
#'   \item Sparse
#'   \item Striated
#'   \item Convex
#'   \item Skinny
#'   \item Stringy
#'   \item Monotonic
#' }
#' 
#' These are described in more detail in: 
#' Graph-Theoretic Scagnostics, Leland Wilkinson, Anushka 
#' Anand, Robert Grossman. 
#' \url{http://papers.rgrossman.com/proc-094.pdf}
#' 
#' You can call the function with two 1d vectors to get a single vector
#' of scagnostics, or with a 2d structure (matrix or data frame) to get 
#' scagnostics for every combination of the variables.
#' 
#' @param x,y object to calculate scagnostics on: a vector, a matrix or a data.frame
#' @param bins number of bins, default=50
#' @param outlierRmv logical for trimming data, default=TRUE
#' @param  ... Extra arguments
#' @keyword hplot
#' @useDynLib binostics, .registration = TRUE
#' @export
#' @examples
#' scagnostics(1:10, 1:10)
#' scagnostics(rnorm(100), rnorm(100))
#' scagnostics(mtcars)
#' scagnostics(as.matrix(mtcars))

scagnostics <- function(x, ...) UseMethod("scagnostics", x)


#' @rdname scagnostics
#' @export
scagnostics.default <- function(x, y, bins=50, outlierRmv=TRUE, ...) {
  stopifnot(length(x) == length(y))

  complete <- !is.na(x) & !is.na(y)  
  x <- x[complete]
  y <- y[complete]
  
  x <- (x - min(x)) / diff(range(x))
  y <- (y - min(y)) / diff(range(y))
  
  results <- rep(0, 9 + 3 * 1000)
  r <- .C("scagnosticsC",
    x = as.double(x),
    y = as.double(y),
    length = as.integer(length(x)),
    bins = as.integer(bins),
    outlierRmv = as.integer(outlierRmv),
    results = as.double(results)
  )$results
  
  n <- r[10]
  s <- r[1:9]
  bins <- matrix(r[11:(10 + n * 3)], ncol=3)
  
  names(s) <- c("Outlying", "Skewed", "Clumpy", "Sparse", "Striated", "Convex", "Skinny", "Stringy", "Monotonic")

  list(s=s, bins=bins)
}

#' @rdname scagnostics
#' @export
scagnostics.matrix <- function(x, ...) {
  scagnostics_2d(x, ...)
}

#' @rdname scagnostics
#' @export
scagnostics.data.frame <- function(x, ...) {
  scagnostics_2d(x, ...)
}

#' @rdname scagnostics
scagnostics_2d <- function(x, ...) {
  vars <- expand.grid(x=1:ncol(x), y=1:ncol(x))
  vars <- vars[vars$x < vars$y, ]
  
  each <- lapply(seq_len(nrow(vars)), function(i) {
    scagnostics(x[,vars[i, 1]], x[,vars[i, 2]])$s
  })
  scag <- as.data.frame(do.call("rbind", each))
  scag$var1 <- colnames(x)[vars$x]
  scag$var2 <- colnames(x)[vars$y]
  
  scag
  
}

