{pkgs, ...}: {
	home.pointerCursor = {
		enable = true;
		name = "phinger-cursors-dark";
		size = 32;
		package = pkgs.phinger-cursors;
		hyprcursor.enable = true;
	};
	gtk.iconTheme = {
		package = pkgs.papirus-icon-theme;
		name = "Papirus-Dark";
	};
}
