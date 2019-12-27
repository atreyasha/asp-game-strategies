#!/usr/bin/env python
# -*- coding: utf-8 -*-

from collections import defaultdict

class GameDef():
    """
    Creates a game definition from a path.

    Args:
        game_path: Path to the folder of the game must have the following files:
                --> all.lp : Clingo file to generate all
                    possible actions(regardless of the player) and fluents
                --> background.lp : Clingo file with all rules
                    from the game in GDL format
                --> full_time.lp : Clingo file with all rules
                    from the game in action description language with time steps
                --> initial.lp : Clingo file with all facts
                    for the initial state
    """
    def __init__(self,path):
        self.path = path
        self.background = path + "/background.lp"
        self.full_time = path + "/full_time.lp"
        self.initial = path + "/initial.lp"
        self.all = path + "/all.lp"
        # TODO think how to put this inside clingo..
        self.subst_var = {"remove":[True,False],
                          "has":[True,False],"control":[False]}

    def state_to_ascii(self, state):
        """
        Transforms a state into ascii representation

        Args:
            state: A state of type State

        Returns:
            String with asciii representation
        """
        return NotImplementedError

    def step_to_ascii(self, step):
        """
        Transforms a state into ascii representation
        with the efects of the action

        Args:
            state: A step of type Step

        Returns:
            String with asciii representation
        """
        return NotImplementedError

class GameNimDef(GameDef):
    def __init__(self,path="./game_definitions/nim"):
        super().__init__(path)
        self.number_piles = 3
        self.max_number = 5

    def state_to_ascii(self, state):
        div = "-"*(self.max_number*2 +1) +"\n"
        a = div
        has = {f.arguments[0].number:f.arguments[1].number
               for f in state.fluents if f.name=="has"}
        for p in range(self.number_piles):
            n = has[p+1] if p+1 in has else 0
            a+="• "*n  + " "*(7-n*2) + "\n"
        return a + div

    def step_to_ascii(self, step):
        state = step.state
        a = "\n"
        a += self.state_to_ascii(state)
        if(not step.action):
            return a
        p = step.action.action.arguments[0].number
        n = step.action.action.arguments[1].number
        lines = a.splitlines()
        new_line = (step.action.player+" ")*(n) + lines[p+1][(n)*2:]
        lines[p+1] = new_line
        return "\n".join(lines)
