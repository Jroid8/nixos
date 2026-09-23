{
  rofi,
  rofi-calc,
}:
rofi.override (_: {
  plugins = [ rofi-calc ];
  theme = ./mytheme.rasi;
})
