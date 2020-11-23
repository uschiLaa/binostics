scagnostics_pairs <- function(scag, columns = 1:9, interactive = FALSE){
  if (length(columns)==2) return(scagnostics_pair(scag, columns, interactive))
  if (!interactive){
    return(GGally::ggpairs(scag, columns=columns,
                           upper = list("continuous" = "blank"),
                           diag = list("continuous" = "blankDiag")))
  }
  # FIXME if length(columns)==2: make single scatter plot instead of matrix
  print("Click on points for linked highlighting, mouse-over to display variable combinations.")
  scag %>%
    dplyr::mutate(label = paste0(var1,"-",var2)) %>%
    # using GGally
    GGally::ggpairs(ggplot2::aes(text = label), columns = columns,
                    upper = list("continuous" = "blank"),
                    diag = list("continuous" = "blankDiag")) %>%
    plotly::ggplotly()
}

scagnostics_pair <- function(scag, vars, interactive = FALSE){
  if (!interactive){
    return(ggplot2::ggplot(scag,
                           ggplot2::aes_string(vars[1], vars[2])) +
             ggplot2::geom_point())
  }
  plotly::ggplotly(
  scag %>%
    dplyr::mutate(label = paste0(var1,"-",var2)) %>%
    ggplot2::ggplot(ggplot2::aes_string(vars[1], vars[2], text = "label")) +
      ggplot2::geom_point()
  )
}
