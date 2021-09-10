Script for Homework 4
================
Ethan Sweet
09/10/2021

# Part 1: Calculate Sum with Variables

``` r
print(a+b)
```

    ## [1] 5

# Part 2: Calculate Sum with Sum Function

``` r
sum(2+3)
```

    ## [1] 5

# Part 3: nycflights13 Package

``` r
#Filtering data for American Airline flights
aa_flights <- filter (flights, carrier=="AA")
aa_flights <- as.data.frame(aa_flights)

#Plotting the filtered data
ggplot(data = aa_flights) +
  geom_point(mapping = aes(x = dep_delay, y = arr_delay))
```

    ## Warning: Removed 782 rows containing missing values (geom_point).

![](homework_4_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->
