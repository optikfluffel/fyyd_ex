%{
  configs: [
    %{
      name: "default",
      color: true,
      files: %{
        included: ["lib/"],
        excluded: ["_build/", "deps/", "test/"]
      },
      checks: [
        {Credo.Check.Readability.MaxLineLength, priority: :normal, max_length: 100}
      ]
    }
  ]
}
