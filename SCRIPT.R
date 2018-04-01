fieldofview <- function(FOV, M){
 x <- FOV/M
 y <- paste("Field Of View is", x, "degrees")
  return(y)
}

exitpupil <- function(eyepiece, fratio){
  a <- eyepiece/fratio
  return(a)
}

fratio <- function(length, diameter){
  t <- length/diameter
  tt<- paste("F-Ratio is", t)
  return(tt)
}

TFOV <- function(afov, mag){
  h <- afov/mag
  return(h)
}

