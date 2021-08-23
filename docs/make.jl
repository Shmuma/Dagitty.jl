using Documenter
using Dagitty

makedocs(
    sitename="Dagitty",
    modules=[Dagitty],
    format = Documenter.HTML(
        prettyurls = get(ENV, "CI", nothing) == "true"
    ),
)
