with (import <nixpkgs> {});
let 
	cyrl = buildGoModule {
		src = ./git/development-tools/cyrl;
		vendorHash = "sha256-It57jZjFrrsS0q8APnmJDyjz7xTA0AD5e2WmRwetXLI=";
		name = "cyrl";
	};
	molecularHelper = buildGoModule {
		src = ./git/molecular-pipeline/molecular_helper;
		vendorHash ="sha256-0SsYVBAym9iXOH0TFVbZ9+RMD3kR034F6O1EVEoMU7g=";
		name = "molecular_helper";
	};
in
mkShell {
	buildInputs = [
	prometheus-graphite-exporter
		neovim
		gh
		go
		ripgrep
		awscli2
		R
		cyrl
		molecularHelper
		postgresql_16
		openssl
    jq
	];
}
