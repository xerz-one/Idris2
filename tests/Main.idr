module Main

import Data.Maybe
import Data.List
import Data.List1
import Data.Strings

import System
import System.Directory
import System.File
import System.Info
import System.Path

import Test.Golden

%default covering

------------------------------------------------------------------------
-- Test cases

ttimpTests : TestPool
ttimpTests = MkTestPool []
     [ "basic001", "basic002", "basic003", "basic004", "basic005"
     , "basic006"
     , "coverage001", "coverage002"
     , "dot001"
     , "eta001", "eta002"
     , "lazy001"
     , "nest001", "nest002"
     , "perf001", "perf002", "perf003"
     , "record001", "record002", "record003"
     , "qtt001", "qtt003"
     , "total001", "total002", "total003"
     ]

idrisTestsBasic : TestPool
idrisTestsBasic = MkTestPool []
      -- Fundamental language features
      ["basic001", "basic002", "basic003", "basic004", "basic005",
       "basic006", "basic007", "basic008", "basic009", "basic010",
       "basic011", "basic012", "basic013", "basic014", "basic015",
       "basic016", "basic017", "basic018", "basic019", "basic020",
       "basic021", "basic022", "basic023", "basic024", "basic025",
       "basic026", "basic027", "basic028", "basic029", "basic030",
       "basic031", "basic032", "basic033", "basic034", "basic035",
       "basic036", "basic037", "basic038", "basic039", "basic040",
       "basic041", "basic042", "basic043", "basic044", "basic045",
       "basic046", "basic047", "basic048", "basic049", "basic050",
       "basic051", "basic052", "basic053", "basic054", "basic055",
       "basic056", "basic057", "basic058"]

idrisTestsCoverage : TestPool
idrisTestsCoverage = MkTestPool []
       -- Coverage checking
      ["coverage001", "coverage002", "coverage003", "coverage004",
       "coverage005", "coverage006", "coverage007", "coverage008",
       "coverage009", "coverage010", "coverage011", "coverage012",
       "coverage013", "coverage014"]

idrisTestsCasetree : TestPool
idrisTestsCasetree = MkTestPool []
       -- Case tree building
      ["casetree001"]

idrisTestsError : TestPool
idrisTestsError = MkTestPool []
       -- Error messages
      ["error001", "error002", "error003", "error004", "error005",
       "error006", "error007", "error008", "error009", "error010",
       "error011", "error012", "error013", "error014", "error015",
       "error016",
       -- Parse errors
       "perror001", "perror002", "perror003", "perror004", "perror005",
       "perror006", "perror007", "perror008"]

idrisTestsInteractive : TestPool
idrisTestsInteractive = MkTestPool []
       -- Interactive editing support
      ["interactive001", "interactive002", "interactive003", "interactive004",
       "interactive005", "interactive006", "interactive007", "interactive008",
       "interactive009", "interactive010", "interactive011", "interactive012",
       "interactive013", "interactive014", "interactive015", "interactive016",
       "interactive017", "interactive018", "interactive019", "interactive020",
       "interactive021", "interactive022", "interactive023", "interactive024",
       "interactive025", "interactive026", "interactive027", "interactive028",
       "interactive029"]

idrisTestsInterface : TestPool
idrisTestsInterface = MkTestPool []
       -- Interfaces
      ["interface001", "interface002", "interface003", "interface004",
       "interface005", "interface006", "interface007", "interface008",
       "interface009", "interface010", "interface011", "interface012",
       "interface013", "interface014", "interface015", "interface016",
       "interface017", "interface018", "interface019", "interface020",
       "interface021", "interface022", "interface023", "interface024",
       "interface025"]

idrisTestsLinear : TestPool
idrisTestsLinear = MkTestPool []
       -- QTT and linearity related
       ["linear001", "linear002", "linear003", -- "linear004" -- disabled due to requiring linearity subtyping
        "linear005", "linear006", "linear007", "linear008",
        "linear009", "linear010", "linear011", "linear012",
        "linear013"]

idrisTestsLiterate : TestPool
idrisTestsLiterate = MkTestPool []
       -- Literate
      ["literate001", "literate002", "literate003", "literate004",
       "literate005", "literate006", "literate007", "literate008",
       "literate009", "literate010", "literate011", "literate012",
       "literate013", "literate014", "literate015", "literate016"]

idrisTestsPerformance : TestPool
idrisTestsPerformance = MkTestPool []
       -- Performance: things which have been slow in the past, or which
       -- pose interesting challenges for the elaborator
      ["perf001", "perf002", "perf003", "perf004", "perf005", "perf006"]

idrisTestsRegression : TestPool
idrisTestsRegression = MkTestPool []
       -- Miscellaneous regressions
      ["reg001", "reg002", "reg003", "reg004", "reg005", "reg006", "reg007",
       "reg008", "reg009", "reg010", "reg011", "reg012", "reg013", "reg014",
       "reg015", "reg016", "reg017", "reg018", "reg019", "reg020", "reg021",
       "reg022", "reg023", "reg024", "reg025", "reg026", "reg027", "reg028",
       "reg029", "reg030", "reg031", "reg032", "reg033", "reg034", "reg035",
       "reg036", "reg037", "reg038"]

idrisTests : TestPool
idrisTests = MkTestPool []
       -- Documentation strings
      ["docs001", "docs002",
       -- Evaluator
       "evaluator001", "evaluator002", "evaluator003", "evaluator004",
       -- Modules and imports
       "import001", "import002", "import003", "import004", "import005",
       -- Miscellaneous REPL
       "interpreter001", "interpreter002", "interpreter003", "interpreter004",
       "interpreter005", "interpreter006", "interpreter007",
       -- Implicit laziness, lazy evaluation
       "lazy001",
       -- Namespace blocks
       "namespace001",
       -- Parameters blocks
       "params001",
       -- Packages and ipkg files
       "pkg001", "pkg002", "pkg003", "pkg004", "pkg005", "pkg006",
       -- Positivity checking
       "positivity001", "positivity002", "positivity003",
       -- Larger programs arising from real usage. Typically things with
       -- interesting interactions between features
       "real001", "real002",
       -- Records, access and dependent update
       "record001", "record002", "record003", "record004", "record005",
       "record006", "record007",
       -- Quotation and reflection
       "reflection001", "reflection002", "reflection003", "reflection004",
       "reflection005", "reflection006", "reflection007", "reflection008",
       "reflection009",
       -- Totality checking
       "total001", "total002", "total003", "total004", "total005",
       "total006", "total007", "total008", "total009", "total010",
       -- The 'with' rule
       "with001", "with002", "with004", "with005",
       -- with-disambiguation
       "with003"]

typeddTests : TestPool
typeddTests = MkTestPool []
     [ "chapter01", "chapter02", "chapter03", "chapter04", "chapter05"
     , "chapter06", "chapter07", "chapter08", "chapter09", "chapter10"
     , "chapter11", "chapter12", "chapter13", "chapter14"
     ]

chezTests : TestPool
chezTests = MkTestPool [Chez]
    [ "chez001", "chez002", "chez003", "chez004", "chez005", "chez006"
    , "chez007", "chez008", "chez009", "chez010", "chez011", "chez012"
    , "chez013", "chez014", "chez015", "chez016", "chez017", "chez018"
    , "chez019", "chez020", "chez021", "chez022", "chez023", "chez024"
    , "chez025", "chez026", "chez027", "chez028", "chez029", "chez030"
    , "chez031", "chez032"
    , "futures001"
    , "semaphores001"
    , "semaphores002"
    , "perf001"
    , "reg001"
    ]

refcTests : TestPool
refcTests = MkTestPool [C]
  [ "refc001" , "refc002" ]

racketTests : TestPool
racketTests = MkTestPool [Racket]
    [ "forkjoin001"
    , "semaphores001", "semaphores002"
    , "futures001"
    , "mutex001", "mutex002", "mutex003", "mutex004", "mutex005"
    , "conditions001"
    , "conditions002"
    , "conditions003"
    , "conditions004"
    , "conditions005"
--    , "conditions006"
--    , "conditions007"
    ]

nodeTests : TestPool
nodeTests = MkTestPool [Node]
    [ "node001", "node002", "node003", "node004", "node005", "node006"
    , "node007", "node008", "node009", "node011", "node012", "node015"
    , "node017", "node018", "node019", "node021", "node022", "node023"
    , "node024", "node025"
    -- , "node14", "node020"
    , "reg001"
    , "syntax001"
    , "tailrec001"
    , "idiom001"
    ]

ideModeTests : TestPool
ideModeTests = MkTestPool []
  [ "ideMode001", "ideMode002", "ideMode003", "ideMode004"
  ]

preludeTests : TestPool
preludeTests = MkTestPool []
  [ "reg001"
  ]

templateTests : TestPool
templateTests = MkTestPool []
  [ "simple-test", "ttimp", "with-ipkg"
  ]

-- base library tests are run against
-- each codegen supported and to keep
-- things simple it's all one test group
-- that only runs if all backends are
-- available.
baseLibraryTests : TestPool
baseLibraryTests = MkTestPool [Chez, Node]
  [ "system_file001"
  , "data_bits001"
  , "system_info001"
  ]

main : IO ()
main = runner
  [ testPaths "ttimp" ttimpTests
  , testPaths "idris2" idrisTestsBasic
  , testPaths "idris2" idrisTestsCoverage
  , testPaths "idris2" idrisTestsCasetree
  , testPaths "idris2" idrisTestsError
  , testPaths "idris2" idrisTestsInteractive
  , testPaths "idris2" idrisTestsInterface
  , testPaths "idris2" idrisTestsLiterate
  , testPaths "idris2" idrisTestsLinear
  , testPaths "idris2" idrisTestsPerformance
  , testPaths "idris2" idrisTestsRegression
  , testPaths "idris2" idrisTests
  , testPaths "typedd-book" typeddTests
  , testPaths "ideMode" ideModeTests
  , testPaths "prelude" preludeTests
  , testPaths "base" baseLibraryTests
  , testPaths "chez" chezTests
  , testPaths "refc" refcTests
  , testPaths "racket" racketTests
  , testPaths "node" nodeTests
  , testPaths "templates" templateTests
  ] where

    testPaths : String -> TestPool -> TestPool
    testPaths dir = record { testCases $= map ((dir ++ "/") ++) }
