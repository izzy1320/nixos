{ config, pkgs, ... }:

{
	home.username = "izzy";
	home.homeDirectory = "/home/izzy";
	home.stateVersion = "26.05";
	programs.git.enable = true;
	programs.fish = {
		enable = true;
		shellAliases = {
			ls = "eza --icons=always --group-directories-first";
			ll = "eza -lh --icons=always --group-directories-first";
			la = "eza -a -icons=always";
			cat = "batcat --style=plain";
			grep = "grep --color=auto";
			sudo = "sudo ";
			nrs = "nixos-rebuild switch --flake .";
		};
		interactiveShellInit = ''
			set -g fish_greeting "fastfetch"
		'';
	};
	programs.starship = {
		enable = true;
		enableFishIntegration = true;
	};
}
