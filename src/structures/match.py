#!/usr/bin/env python
# -*- coding: utf-8 -*-

from collections import defaultdict
from structures.state import State, StateExpanded
from structures.action import ActionExpanded, Action
from structures.step import Step
from py_utils.colors import *

class Match:
    """
    Class to represent a match 

    Attributes
    ----------
    steps : list(Step)
        list of steps performed in the match
    """
    def __init__(self,steps):
        self.steps = steps

    def add_step(self, step):
        """
        Adds a nex step
        """
        self.steps.append(step)

    @classmethod
    def from_time_model(cls, model, game_def, main_player = None):
        """
        Given a stabel model for the full time representation of the game,
        the functions creates a match with each action taken.

        Args:
            model: Stable model from the full time representation
            game_def: The game definition
            main_player: The player for which we aim to minmax
        """
        atoms = model.symbols(atoms=True)
        fluent_steps = defaultdict(lambda: {'fluents':[],'goals':[],
                                            'action':None})
        for a in atoms:
            if(a.name == "goal"):
                time = a.arguments[2].number
                fluent_steps[time]['goals'].append(a)
            elif(a.name=="holds"):
                time = a.arguments[1].number
                fluent_steps[time]['fluents'].append(a.arguments[0])
            elif(a.name=="does"):
                time = a.arguments[2].number
                fluent_steps[time]['action'] = a
        fluent_steps = dict(fluent_steps)
        steps = []
        for i in range(len(fluent_steps)):
            state = State(fluent_steps[i]['fluents'],fluent_steps[i]['goals'],
                          game_def)
            action = None
            if(not fluent_steps[i]['action']):
                pass
            else:
                action = Action(fluent_steps[i]['action'].arguments[0].name,
                                fluent_steps[i]['action'].arguments[1])
            step = Step(state,action,i)
            steps.append(step)
        steps[-1].state.is_terminal = True
        steps[-1].set_score_player(main_player)
        return cls(steps)

    @property
    def goals(self):
        """
        Returns: Obtains the goals of a match using the last step
        """
        if(len(self.steps) == 0):
            return {}
        return self.steps[-1].state.goals

    def __str__(self):
        """
        Returns: A console representation of the match
        """
        s = ""
        c = [bcolors.OKBLUE,bcolors.HEADER]
        for step in self.steps:
            s+=c[step.time_step%2]
            s+="\nSTEP {}:".format(step.time_step)
            s+= step.ascii
            if(step.state.is_terminal):
                s+="{}GOALS: \n{}{}".format(bcolors.OKGREEN, step.state.goals,
                                            bcolors.ENDC)
            s+=bcolors.ENDC
        return s

    def generate_train(self, training_list, i):
        if training_list is None:
            return
        step = self.steps[i]
        p = step.state.control
        control_goal = self.goals[p]
        training_list.append(
            {'s_init':step.state,
            'action':step.action,
            's_next':self.steps[i+1].state,
            'reward':control_goal,
            'win':-1 if control_goal<0 else 1})
