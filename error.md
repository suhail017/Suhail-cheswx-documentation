# Error Description
when try to run the ``prcp_homog_ref.R`` for more than 60 years of temporal range (tnterpolation end date - Interpolation start date) the following error take
place:

```
Error with station: USH00413992

Error in if (length(c(year, month, day, hour, min, sec)) == 6 && all(c(year,  : 
  missing value where TRUE/FALSE needed  
  
In addition: Warning messages:  
1: In as_numeric(YYYY) : NAs introduced by coercion  
2: In as_numeric(YYYY) : NAs introduced by coercion
```

## Possible Solutions:
We tried the following way to get rid of the error:

1. Delete the error Station: USH00413992:
We tried to delete the station USH00413992, however this method doesn't work and the error persist.

2. Change the start and end date:
We try to change the start and end date for the interpolation start and end date procedure, it didn't work out as well.
