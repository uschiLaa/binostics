#' Find selected scagnostics index value for a scatterplot
#' 
#' Returns the selected scagnostics index for a provided set of
#' two 1d vectors, either by providing the name to the
#' scagnostics.index function, or calling the corresponding wrapper
#' function.
#' 
#' Available scagnostics are: 
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
#' 
#' @param x,y 1d vectors
#' @param name selected index from the list of available scagnostics
#' @export
#' @examples
#' scagnostic.index(rnorm(100), rnorm(100), name = "Convex")
#' convex(rnorm(100), rnorm(100))
scagnostic.index <- function(x, y, name = "Outlying"){
  scag <- scagnostics.default(x, y)$s
  as.numeric(scag[name])
}

#' @rdname scagnostic.index
#' @export
outlying <- function(x, y){
  scagnostic.index(x, y, "Outlying")
}

#' @rdname scagnostic.index
#' @export
skewed <- function(x, y){
  scagnostic.index(x, y, "Skewed")
}

#' @rdname scagnostic.index
#' @export
clumpy <- function(x, y){
  scagnostic.index(x, y, "Clumpy")
}

#' @rdname scagnostic.index
#' @export
sparse <- function(x, y){
  scagnostic.index(x, y, "Sparse")
}

#' @rdname scagnostic.index
#' @export
striated <- function(x, y){
  scagnostic.index(x, y, "Striated")
}

#' @rdname scagnostic.index
#' @export
convex <- function(x, y){
  scagnostic.index(x, y, "Convex")
}

#' @rdname scagnostic.index
#' @export
skinny <- function(x, y){
  scagnostic.index(x, y, "Skinny")
}

#' @rdname scagnostic.index
#' @export
stringy <- function(x, y){
  scagnostic.index(x, y, "Stringy")
}

#' @rdname scagnostic.index
#' @export
monotonic <- function(x, y){
  scagnostic.index(x, y, "Monotonic")
}
