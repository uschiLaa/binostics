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
    # fully plotly version from Di's tutorial
    #plotly::highlight_key(~label) %>%
    #plotly::plot_ly() %>% 
    #plotly::add_trace(
    #  type = 'splom',
    #  dimensions = list(
    #    list(label='Outlying', values=~Outlying),
    #    list(label='Skewed', values=~Skewed),
    #    list(label='Clumpy', values=~Clumpy),
    #    list(label='Sparse', values=~Sparse),
     #   list(label='Striated', values=~Striated),
    #    list(label='Convex', values=~Convex),
    #    list(label='Skinny', values=~Skinny),
    #    list(label='Stringy', values=~Stringy),
    #    list(label='Monotonic', values=~Monotonic)
    #  ),
    #  text=~label
    #) %>%
    # highlighting not working for SLOM?
    #plotly::highlight(on = "plotly_click", off = "plotly_deselect", color="red")
}
