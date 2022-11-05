using BlockingMC
using Documenter

DocMeta.setdocmeta!(BlockingMC, :DocTestSetup, :(using BlockingMC); recursive=true)

makedocs(;
    modules=[BlockingMC],
    authors="v1j4y <vijay.gopal.c@gmail.com> and contributors",
    repo="https://github.com/v1j4y/BlockingMC.jl/blob/{commit}{path}#{line}",
    sitename="BlockingMC.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://v1j4y.github.io/BlockingMC.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/v1j4y/BlockingMC.jl",
)
