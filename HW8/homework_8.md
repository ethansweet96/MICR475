Homework 8
================

# Question 1

``` r
data(diamonds)
summary(diamonds)
```

    ##      carat               cut        color        clarity          depth      
    ##  Min.   :0.2000   Fair     : 1610   D: 6775   SI1    :13065   Min.   :43.00  
    ##  1st Qu.:0.4000   Good     : 4906   E: 9797   VS2    :12258   1st Qu.:61.00  
    ##  Median :0.7000   Very Good:12082   F: 9542   SI2    : 9194   Median :61.80  
    ##  Mean   :0.7979   Premium  :13791   G:11292   VS1    : 8171   Mean   :61.75  
    ##  3rd Qu.:1.0400   Ideal    :21551   H: 8304   VVS2   : 5066   3rd Qu.:62.50  
    ##  Max.   :5.0100                     I: 5422   VVS1   : 3655   Max.   :79.00  
    ##                                     J: 2808   (Other): 2531                  
    ##      table           price             x                y         
    ##  Min.   :43.00   Min.   :  326   Min.   : 0.000   Min.   : 0.000  
    ##  1st Qu.:56.00   1st Qu.:  950   1st Qu.: 4.710   1st Qu.: 4.720  
    ##  Median :57.00   Median : 2401   Median : 5.700   Median : 5.710  
    ##  Mean   :57.46   Mean   : 3933   Mean   : 5.731   Mean   : 5.735  
    ##  3rd Qu.:59.00   3rd Qu.: 5324   3rd Qu.: 6.540   3rd Qu.: 6.540  
    ##  Max.   :95.00   Max.   :18823   Max.   :10.740   Max.   :58.900  
    ##                                                                   
    ##        z         
    ##  Min.   : 0.000  
    ##  1st Qu.: 2.910  
    ##  Median : 3.530  
    ##  Mean   : 3.539  
    ##  3rd Qu.: 4.040  
    ##  Max.   :31.800  
    ## 

``` r
ggplot(diamonds, aes(factor(color), (x=price/carat), fill=color)) + geom_violin(trim = FALSE) + theme_base() + ggtitle("Diamond Price per Carat grouped by Color") + xlab("Color") + ylab("Diamond Price per Carat in US Dollars") 
```

![](homework_8_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

``` r
#Slope of the relationship of price as a function of weight (carat) for each unique color, in decreasing order of slope
```

``` r
cuberoot_trans = function()trans_new('cuberoot', transform = function(x) x^(1/3), inverse = function(x) x^3)

ggplot(aes(x = carat, y = price, color = color), data = diamonds) + 
  geom_point(alpha = 0.5, size = 1, position = 'jitter') +
  scale_color_brewer(type = 'div',
                     guide = guide_legend(title = 'Color', 
                                          reverse = T,
                                          override.aes = list(alpha = 1, 
                                                              size = 2))) +  
  scale_x_continuous(trans = cuberoot_trans(), limits = c(0.2, 5),
                     breaks = c(0.2, 0.5, 1, 2, 3, 4, 5)) + 
  scale_y_continuous(trans = log10_trans(), limits = c(350, 30000),
                     breaks = c(350, 1000, 5000, 10000, 15000, 20000, 25000, 30000)) +
  ggtitle('Price by Carat & Color') + theme_base()
```

    ## Warning: Removed 21 rows containing missing values (geom_point).

![](homework_8_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

# Question 2

``` r
monod_mod <- formula(density ~ (conc*dmax)/(conc + k))

sqrt_mod <- formula(density ~ beta_1 * sqrt(conc) + beta_0)
single_sqrt_model <- nls2(sqrt_mod,
                          data = DNase,
                          start = list(beta_1 = 0.5, beta_0 = 0.1))

compare_models <- DNase %>%
  group_by(Run) %>%
  nest() %>%
  mutate(sqrt_mod = map(data, ~ nls2(
    sqrt_mod,
    data = .,
    start = list(beta_1 = 0.5, beta_0 = 0.1)
  )),
  monod_mod = map(data,  ~ nls2(
    monod_mod, data = ., start = list(dmax = .3, k = .4)
  )),
  sqrt_aic= map_dbl(sqrt_mod,~glance(.)$AIC),
  monod_aic=map_dbl(monod_mod,~glance(.)$AIC))

longer_data <- compare_models %>%
  pivot_longer(sqrt_aic:monod_aic, names_to = "Model", values_to = "Value")%>%
  ggplot(aes(x = Run, y=Value)) +
  facet_wrap(vars(Model), ncol = 3) +
  geom_point() +
  geom_line() +
  labs(x = "Run Number", y = "AIC Value") 


print(longer_data)
```

    ## geom_path: Each group consists of only one observation. Do you need to adjust
    ## the group aesthetic?
    ## geom_path: Each group consists of only one observation. Do you need to adjust
    ## the group aesthetic?

![](homework_8_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->
