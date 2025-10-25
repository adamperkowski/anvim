# Licensed under European Union Public Licence v1.2
# Inspided by github:tgirlcloud/gift-wrap
{
  lib,
  lndir,
  stdenvNoCC,
  neovim-unwrapped,
  makeBinaryWrapper,
}:

lib.extendMkDerivation {
  constructDrv = stdenvNoCC.mkDerivation;

  extendDrvArgs =
    _:
    {
      pname ? "neovim",
      versionSuffix ? "wrapped",
      userConfig,
    }:
    let
      inherit (neovim-unwrapped) lua;
      inherit (lua.pkgs) luaLib;

      config = stdenvNoCC.mkDerivation {
        name = "${pname}-config";
        __structuredAttrs = true;

        buildCommand = ''
          mkdir -p $out/lua/${pname}
          cp -R ${userConfig}/* $out/lua/${pname}

          cat > $out/init.lua << EOF
          package.path = "${luaLib.genLuaPathAbsStr lua};$LUA_PATH" .. package.path
          package.cpath = "${luaLib.genLuaCPathAbsStr lua};$LUA_CPATH" .. package.cpath

          vim.opt.runtimepath:prepend("$out")

          do
            local ok, err = pcall(require, "${pname}")
            if not ok then
              error("error loading user config: " .. err)
            end
          end
          EOF
        '';
      };
    in
    {
      inherit pname;
      version = "${neovim-unwrapped.version}-${versionSuffix}";

      __structuredAttrs = true;
      strictDeps = true;

      dontUnpack = true;
      dontFixup = true;
      dontConfigure = true;
      dontRewriteSymLinks = true;

      nativeBuildInputs = [
        lndir
        makeBinaryWrapper
      ];

      wrapperArgs = [
        "--set-default"
        "VIMINIT"
        "source ${config}/init.lua"

        "--set-default"
        "NVIM_APPNAME"
        pname
      ];

      installPhase = ''
        runHook preInstall

        mkdir -p $out
        lndir -silent ${neovim-unwrapped} $out

        rm -rf $out/share/applications

        wrapProgram $out/bin/nvim "''${wrapperArgs[@]}"

        runHook postInstall
      '';

      meta = neovim-unwrapped.meta;
    };
}
