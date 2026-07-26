{
  programs.git = {
    enable = true;
    lfs.enable = true;
		ignores = [
			"index.norg"
			".ignore"
			".exec"
		];
    settings = {
			user = {
				email = "jroid8@tutanota.com";
				name = "Jroid8";
			};
      init = {
        defaultBranch = "main";
      };
      url = {
        "https://github.com/" = {
          insteadOf = [
            "gh:"
            "github:"
          ];
        };
      };
    };
  };
}
