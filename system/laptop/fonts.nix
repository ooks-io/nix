
{ pkgs, ... }
{

# Fonts

	font.fonts = with pkgs; [
		(nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
		];
