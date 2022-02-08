
# Test case #1
ll <- matrix(c(5, 12/0,6, 60), ncol=2)
km <- spDistsN1(ll, ll[2,], longlat=FALSE)


#Test case #2
utm32 <- matrix(c(276.9799,6658.1572, 6655.2055,NA), ncol=2)
spDistsN1(utm32, utm32[1,],longlat = TRUE)