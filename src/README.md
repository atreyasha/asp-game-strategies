## Learning game strategies in ASP :clubs: :game_die:

Here we document our source code and its various functionalities. Most functions use a combination of ASP (clingo), ILASP and python.

### Table of contents

1. [Dependencies](#1-Dependencies) 
2. [Code structure](#2-Code-structure)

### 1. Dependencies

#### i. Pythonic dependencies 

To install python-based dependencies, one can use the file `requirements.txt`. Simply execute the following (possibly within a virtual environment):

```shell
$ pip install -r requirements.txt
```

#### ii. External dependencies

The next steps involve setting up this repository for testing. To proceed, execute the following prompt-based script:

```shell
$ ./init.sh
```

a. The first prompt will initialize a pre-commit hook, which will automatically update `requirements.txt` on every `git commit`.

b. The next prompt will download and decompress an appropriate upstream binary for `clingo-5.4.0`, based on your OS. Alternatively, you could skip this step and install `clingo` via your OS's package manager, if it is available upstream.

c. The next prompt will download and decompress an appropriate upstream binary for `ILASP-3.4.0`, based on your OS.

**Note:** It is necessary to manually copy both decompressed binaries into a directory located on your `PATH` variable. Additionally, both binaries must be located in a directory owned by a user with the same access permissions, since `ILASP` will call `clingo` in our scripts. This action can be omitted for the `clingo` binary if you installed it via your package manager, but it would still need to be done for the `ILASP` binary.

**Note:** If you are using the downloaded `clingo` binary in step "b" above, you would need to install python support for `clingo`. This step can be skipped if you installed `clingo` via your package manager.

To install python support for `clingo`, you can run the following command using `conda`:

```shell
$ conda install -c potassco clingo 
```

### 2. Code structure

Here we provide a tabular summary of our main code structure.

#### i. `game_definitions`

| L1                   | L2                                          | L3                                                  | Description                                                                                                                                 |
| :---:                | :---:                                       | :---:                                               | :---                                                                                                                                        |
| **game_definitions** |                                             |                                                     | Contains files with the asp encodings of games                                                                                              |
| --->                 | [game_def.py](game_definitions/game_def.py) |                                                     | Definitions of games that include the paths for the game, any extra configuration and a transformation of the states to ascii for printing. |
| --->                 | **game_name**                               |                                                     | Generic name of game (eg. "nim"). It is passed as a path in many functions.                                                                 |
| --->                 | --->                                        | [background.lp](game_definitions/nim/background.lp) | Defines the basic rules using of the game for one `time_step`, using `next`                                                                 |
| --->                 | --->                                        | [initial.lp](game_definitions/nim/initial.lp)       | Defines the initial state of the game                                                                                                       |
| --->                 | --->                                        | [full_time.lp](game_definitions/nim/full_time.lp)   | Defines the basic rules using of the game for all the game, using `holds` in each possible `time_step`                                      |

#### ii. `players`

| L1          | L2                               | L3                                                   | Description                                                                                   |
| :---:       | :---:                            | :---:                                                | :---                                                                                          |
| **players** |                                  |                                                      | Contains all the possible players representing the approaches for selecting actions in a game |
| --->        | [players.py](players/players.py) |                                                      | Defines the behaivour of each player                                                          |
| --->        | **min_max_asp**                  |                                                      | Approach using asp optimization statements to compute the minmax algorithm                    |
| --->        | --->                             | [min_max_asp.py](players/min_max_asp/min_max_asp.py) | Functions to compute algorithm using asp                                                      |
| --->        | **min_max_python**               |                                                      | Approach using the minmax algorithm in python                                                 |
| --->        | --->                             | [min_max_python.py](players/minmax_python/minmax.py) | Functions to compute algorithm in python                                                      |

#### iii. `py_utils`

| L1           | L2                                                  | Description                                |
| :---:        | :---:                                               | :---                                       |
| **py_utils** |                                                     | Folders with utils functions               |
| --->         | [clingo_utils.py](py_utils/clingo_utils.py)         | Clingo bindings to be used in python       |
| --->         | [colors.py](py_utils/colors.py)                     | Defining python colors for pretty-printing |
| --->         | [match_simulation.py](py_utils/match_simulation.py) | Match simulation functions                 |

#### iv. `structures`

| L1             | L2                                | Description                                                                                                                                                                          |
| :---:          | :---:                             | :---                                                                                                                                                                                 |
| **structures** |                                   | Contains the structures used to model the games                                                                                                                                      |
| --->           | [action.py](structures/action.py) | An action selected by a player. An extended class also includes the fluents of the next state once the action ins performed                                                          |
| --->           | [state.py](structures/state.py)   | The state of the game, including board state, hows turn it is, if the game finished and if such, the goals reached. An extended class also includes all valid actions from the state |
| --->           | [step.py](structures/step.py)     | The step on a match, includes the state and the action performed in such state                                                                                                       |
| --->           | [match.py](structures/match.py)   | A full match of a game, list of steps                                                                                                                                                |
| --->           | [tree.py](structures/tree.py)     | A full tree of a game created by steps, with all possible paths                                                                                                                      |
| --->           | [game.py](structures/game.py)     | The game representation used for RL agents                                                                                                                                           |

### Test ILASP with small example

In order to check some basic results, you can run the snippet below and you should receive a similar output (timings may differ):

```shell
$ ILASP --clingo5 --version=3 ./src/players/ilasp_strategy/ilasp_examples/schedule.las

:~ assigned(V0, V1), type(V0, V1, c2).[1@2, 1, V0, V1]
:~ assigned(V0, V1), assigned(V2, V3), V2 != V0.[1@1, 2, V0, V1, V2, V3]
%% score = 5
Pre-processing  : 0.015s
Solve time      : 1.125s
Total           : 1.14s
```

### Learn weak constraints with ILASP

In order to run ILASP for learning weak constraints in the game of NIM run the following command

```shell
$ ILASP --clingo5 --version=3 ./src/game_definitions/nim/nim_ILASP.las --max-wc-length=6

:~ next(has(V0,2)), next(has(V1,2)), next(has(V2,0)), V0 != V1.[-1@2, 1, V0, V1, V2]
:~ next(has(V0,1)).[-1@1, 2, V0]
%% score = 5
Pre-processing  : 0.318s
Solve time      : 77.426s
Total           : 77.745s
```

This process will take over 1 minute.

When using a *conda* environment you might need to define the *clingo* path or deactivate the environment.

### Run main to simulate a match

Use the following command to simulate a match of nim using a strategy found by ILASP

```shell
$ python src/main.py
```

### Tests

For the test we use the pytest pakage, the documentation can be found [here](https://docs.pytest.org/en/latest/getting-started.html#install-pytest).

To run all tests use the following command

```shell
pytest . -v -s -p no:warnings
```

To run tests in one file run

```shell
pytest src/tests/test_file.py -v -s
```

This will run the tests in all the files in the tests folder.
All test files must have the format `test_*.py`