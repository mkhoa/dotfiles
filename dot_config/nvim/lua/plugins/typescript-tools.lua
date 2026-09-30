return {
  {
    "pmizio/typescript-tools.nvim",
    ft = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      settings = {
        -- Diagnostics
        separate_diagnostic_server = true,
        publish_diagnostic_on = "insert_leave",

        -- Code actions
        expose_as_code_action = {
          "fix_all",
          "add_missing_imports",
          "remove_unused_imports",
          "organize_imports",
        },

        -- Use default tsserver
        tsserver_path = nil,
        tsserver_plugins = {},

        -- Memory
        tsserver_max_memory = "auto",

        -- Language
        tsserver_locale = "en",

        -- Completion
        complete_function_calls = false,
        include_completions_with_insert_text = true,

        -- CodeLens
        code_lens = "off",
        disable_member_code_lens = true,

        -- JSX auto closing tags
        jsx_close_tag = {
          enable = false,
          filetypes = {
            "javascriptreact",
            "typescriptreact",
          },
        },

        -- File preferences
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeInlayVariableTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,

          includeCompletionsForModuleExports = true,
          includeCompletionsForImportStatements = true,

          quotePreference = "auto",
        },

        -- Formatting
        tsserver_format_options = {
          semicolons = "insert",
          insertSpaceAfterCommaDelimiter = true,
          insertSpaceAfterSemicolonInForStatements = true,
          insertSpaceBeforeAndAfterBinaryOperators = true,
          insertSpaceAfterConstructor = false,
          insertSpaceAfterKeywordsInControlFlowStatements = true,
          insertSpaceAfterFunctionKeywordForAnonymousFunctions = true,
          insertSpaceBeforeFunctionParenthesis = false,
          placeOpenBraceOnNewLineForFunctions = false,
          placeOpenBraceOnNewLineForControlBlocks = false,
        },
      },
    },
  },
}
