Install Package from tar.gz file
================
Daniel Carpenter
2023-04-22

Do this every time you make a change

``` r
install.packages('../AdvRPackage_0.1.0.tar.gz', 
                 repos = NULL, type = 'source')
```

    ## Installing package into 'C:/Users/daniel.carpenter/AppData/Local/R/win-library/4.2'
    ## (as 'lib' is unspecified)

``` r
# view the vignette
packageName  = "AdvRPackage"
vignetteName = "intro-to-package"

vignette(vignetteName, package = packageName)
```

    ## starting httpd help server ... done

``` r
?AdvRPackage::myttest
?AdvRPackage::print
?AdvRPackage::print.Rttest
?AdvRPackage::plot
?AdvRPackage::plot.Rttest
```
