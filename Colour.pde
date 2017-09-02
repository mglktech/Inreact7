color HSBConvert (int hue, int sat, int brightness, boolean opposite)
{
  NoDraw = true;
  if(hue>255)
  {
    hue = hue - 255;
  }
  colorMode(HSB, 255);
  color c = color(hue,sat,brightness);
  int r = floor(red(c));
  int g = floor(green(c));
  int b = floor(blue(c));
  colorMode(RGB, 255);
  NoDraw = false;
  if(opposite == true)
  {
    
  return color(255-r,255-g,255-b);
  }
  else
  {
    
   return color(r,g,b);
  }
  
}