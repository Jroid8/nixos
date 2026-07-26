(import ../../../system/aliases.nix)
// {
  yt720 = "yt-dlp -f 'bv[height<=720][fps<=?30]+ba[abr<=?95][language*=?en]/bv[height<=720]+ba[language*=?en]'";
  rfb = "rofi -show filebrowser -config filebrowser -filebrowser-directory";
  tree = "eza --tree";
}
