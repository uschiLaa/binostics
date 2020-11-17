scagnostics_pairs <- function(scag, columns = 1:9, interactive = FALSE){
  if (!interactive){
    return(GGally::ggpairs(scag, columns=columns))
  }
  # FIXME if length(columns)==2: make single scatter plot instead of matrix
  print("Click on points for linked highlighting, mouse-over to display variable combinations.")
  scag %>%
    dplyr::mutate(label = paste0(var1,"-",var2)) %>%
    # using GGally
    GGally::ggpairs(aes(text = label), columns = columns) %>%
    plotly::ggplotly()
}
