{ pkgs, buildGoModule, makeDesktopItem, lib }:

with import ./shell.nix { inherit pkgs; };

buildGoModule rec {
	inherit name;
	inherit version;
	inherit buildInputs;
	inherit nativeBuildInputs;

	src = ./.; # root Git directory

	desktopFile = makeDesktopItem {
		inherit name;
        desktopName = "gtkcord";
		exec = "gtkcord3";
		icon = "gtkcord3";
		categories = "GTK;GNOME;Chat;";
	};

	preFixup = ''
		mkdir -p $out/share/icons/hicolor/256x256/apps/ $out/share/applications/
		# Install the desktop file
		cp "${desktopFile}"/share/applications/* $out/share/applications/
		# Install the icon
		cp "${./logo.png}" $out/share/icons/hicolor/256x256/apps/gtkcord3.png
	'';

	modSha256   = "0dfxrcvaz6k9cmkgwx9zpdlyv1hh2iiw27ibgfvj1zm1wacg2l27";
	subPackages = [ "." ];
}
