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

      plugins ? [ ],

      userConfig,

      extraPackages ? [ ],
    }:
    let
      inherit (neovim-unwrapped) lua;
      inherit (lua.pkgs) luaLib;

      transitiveClosure =
        p: [ p ] ++ (lib.unique (lib.concatLists (map transitiveClosure p.dependencies or [ ])));
      findDeps = p: lib.concatMap transitiveClosure p;
      mkPluginPaths =
        p: "pack/${pname}/start/${if lib.typeOf p == "path" then baseNameOf p else (p.pname or p.name)}";

      pluginDeps = lib.unique (findDeps plugins ++ plugins);

      config = stdenvNoCC.mkDerivation {
        name = "${pname}-config";
        __structuredAttrs = true;

        plugins = pluginDeps;
        pluginPaths = map mkPluginPaths pluginDeps;

        nativeBuildInputs = [ lndir ];

        buildCommand = ''
          mkdir -p $out/lua/${pname}
          lndir "${userConfig}" $out/lua/${pname}

          cat > $out/init.lua << EOF
          package.path = "${luaLib.genLuaPathAbsStr lua};$LUA_PATH" .. package.path
          package.cpath = "${luaLib.genLuaCPathAbsStr lua};$LUA_CPATH" .. package.cpath

          vim.env.PATH = vim.env.PATH .. ":${lib.makeBinPath extraPackages}"

          vim.opt.packpath:prepend("$out")
          vim.opt.runtimepath:prepend("$out")

          do
            local ok, err = pcall(require, "${pname}")
            if not ok then
              error("error loading user config: " .. err)
            end
          end
          EOF

          for (( i = 0; i < "''${#plugins[@]}" ; i++ )); do
            source="''${plugins[$i]}"
            dest="$out/''${pluginPaths[$i]}"

            if [ -d "$dest" ]; then
              echo "$dest already exists, skipping"
              continue
            fi

            mkdir -p "$dest"
            lndir -silent "$source" "$dest"
          done
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
