return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = {
          settings = {
            typescript = {
              preferences = {
                includeCompletionsForModuleExports = true,
                includeCompletionsForImportStatements = true,
                importModuleSpecifier = "non-relative",
              },
            },
          },
        },
        tailwindcss = {
          settings = {
            tailwindCSS = {
              classAttributes = {
                "class",
                "className",
                "ngClass",
                "class:list",
                "headerClassName",
                "contentContainerClassName",
                "columnWrapperClassName",
                "endFillColorClassName",
                "imageClassName",
                "tintColorClassName",
                "ios_backgroundColorClassName",
                "thumbColorClassName",
                "trackColorOnClassName",
                "trackColorOffClassName",
                "selectionColorClassName",
                "cursorColorClassName",
                "underlineColorAndroidClassName",
                "placeholderTextColorClassName",
                "selectionHandleColorClassName",
                "colorsClassName",
                "progressBackgroundColorClassName",
                "titleColorClassName",
                "underlayColorClassName",
                "colorClassName",
                "drawerBackgroundColorClassName",
                "statusBarBackgroundColorClassName",
                "backdropColorClassName",
                "backgroundColorClassName",
                "ListFooterComponentClassName",
                "ListHeaderComponentClassName",
                ".*ClassName",
              },
              classFunctions = { "clsx", "cva", "cn", "tv", "tw", "twMerge" },
              experimental = {
                classRegex = {
                  { "(`.*?`)", '(".*?")', "('.*?')" },
                },
              },
            },
          },
        },
      },
    },
  },
}
