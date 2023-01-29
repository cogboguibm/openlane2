{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  packages = with pkgs; let
    boost-static = pkgs.boost.override {
      enableShared = false;
      enabledStatic = true;
    }; magic-vlsi = pkgs.magic-vlsi.overrideAttrs (finalAttrs: previousAttrs: {
      version = "8.3.363";
      src = fetchgit {
        url = "https://github.com/RTimothyEdwards/magic";
        rev = "8d08cb2f2f33c79bea478a79543721d476554c78";
        sha256 = "sha256-CY7Wlgvo/b3szVCnJmNaZ6OnXSGlmwyJsPz+cetLIE4=";
        leaveDotGit = true;
      };

      nativeBuildInputs = [ python3 tcsh git gnused ];

      preConfigure = ''
        for file in ./scripts/*; do
          sed -i 's@/bin/csh/@/usr/bin/env tcsh@g' $file
        done
        sed -i '5386,5388d' ./scripts/configure
        patchShebangs ./scripts/*
      '';

    }); netgen = stdenv.mkDerivation {
    
      name = "netgen";
      src = fetchgit {
        url = "https://github.com/donn/netgen";
        rev = "c10f8efd7dc1a5a1c1330784765d5a38cc22cd2d";
        sha256 = "sha256-WGWnIWL//q7z5HmJ1JpSK6QhNM+X7iWNcDzQpL5CbYc=";
      };

      configureFlags = [
        "--with-tk=${tk}"
        "--with-tcl=${tcl}"
      ];

      buildInputs = [
        tcl
        tk
        m4
        python3Full
      ];

      nativeBuildInputs = [
        clang
        clang-tools
      ];

    }; openroad = let revision = "c295b08a99aacb6147b9c51104627e78ac3859e3"; in stdenv.mkDerivation {
      
      name = "openroad";
      src = fetchgit {
        url = "https://github.com/The-OpenROAD-Project/OpenROAD";
        rev = "${revision}";
        sha256 = "sha256-7TaIz12WX6wvZN+Z+IFZh55zWtMV7ER7G5yGefR5n6I=";
        fetchSubmodules = true;
      };

      preConfigure = ''
        sed -i "s/GITDIR-NOTFOUND/${revision}/" ./cmake/GetGitRevisionDescription.cmake
        patchShebangs ./etc/find_messages.py
      '';

      buildInputs = [
        eigen
        spdlog
        tcl
        tk
        python3Full
        readline
        libffi
        qt6.full
        
        # ortools
        re2
        glpk
        zlib
        clp
        cbc
        lemon-graph
        or-tools
      ];

      nativeBuildInputs = [
        boost-static
        swig
        clang
        clang-tools
        pkg-config
        cmake
        gnumake
        flex
        bison
      ];
    }; in [
      # Requirements
      git
      clang
      clang-tools
      gnumake
      python3Full
      xz

      # Conveniences
      neovim
      zsh

      # Tools
      klayout

      ## Customized
      yosys
      openroad
      magic-vlsi
      netgen
    ];

}