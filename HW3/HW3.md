Homework 3
================
Ethan Sweet
09/03/2021

# Load in Tidyverse

``` r
library(tidyverse)
```

# Show the graph, show the graph!

``` r
print(mpg)
```

    ## # A tibble: 234 × 11
    ##    manufacturer model      displ  year   cyl trans drv     cty   hwy fl    class
    ##    <chr>        <chr>      <dbl> <int> <int> <chr> <chr> <int> <int> <chr> <chr>
    ##  1 audi         a4           1.8  1999     4 auto… f        18    29 p     comp…
    ##  2 audi         a4           1.8  1999     4 manu… f        21    29 p     comp…
    ##  3 audi         a4           2    2008     4 manu… f        20    31 p     comp…
    ##  4 audi         a4           2    2008     4 auto… f        21    30 p     comp…
    ##  5 audi         a4           2.8  1999     6 auto… f        16    26 p     comp…
    ##  6 audi         a4           2.8  1999     6 manu… f        18    26 p     comp…
    ##  7 audi         a4           3.1  2008     6 auto… f        18    27 p     comp…
    ##  8 audi         a4 quattro   1.8  1999     4 manu… 4        18    26 p     comp…
    ##  9 audi         a4 quattro   1.8  1999     4 auto… 4        16    25 p     comp…
    ## 10 audi         a4 quattro   2    2008     4 manu… 4        20    28 p     comp…
    ## # … with 224 more rows

# Here is my crappy graph! Sorry for your eyes!

I am using this plot to look at the city miles per gallon of different
auto manafacturers

``` r
ggplot(data = mpg) +
  geom_point(mapping = aes(x = manufacturer, y = cty, colour = trans))
```

![](HW3_files/figure-gfm/HW3%20Plot-1.png)<!-- -->
