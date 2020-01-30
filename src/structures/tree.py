#!/usr/bin/env python
# -*- coding: utf-8 -*-

import re
import anytree
from tqdm import tqdm
from anytree import Node, RenderTree
from anytree.exporter import UniqueDotExporter, DotExporter
from anytree.iterators.levelorderiter import LevelOrderIter
from .state import State, StateExpanded
from .match import Match
from .step import Step


class Tree:
    """
    Tree class to handle minimax tree construction
    """
    def __init__(self,root=None,game=None):
        """ Initialize with empty root node and game class """
        self.root = root
        self.game = game

    def from_game_def(self, game_def, initial_state = None, main_player="a"):
        """
        Wrapper function to start with a game definition and expand
        root downwards to branch all possibilities. Next, the tree is
        reviewed upwards using the minimax algorithm.

        Args:
            game_def (GameDef*): game definition class
        """
        self.game = game_def
        if initial_state is None:
            initial = game_def.initial
            initial_state = StateExpanded.from_game_def(game_def,game_def.initial)
        root_node = Node(Step(initial_state,None,0))
        # Tree.expand_rec(root_node,0)
        self.root = root_node
        self.expand_root(main_player=main_player)
        root_node = self.build_minimax(root_node,main_player=main_player)
        self.root = root_node

    def expand_root(self, main_player="a"):
        """
        Function to expand a tree downwards until terminal leaves

        Args:
            tree (anytree.Node): a tree to expand till its terminal leaves

        Returns:
            tree (anytree.Node): expanded version of tree
        """
        tree =  self.root
        valid_moves = tree.name.state.legal_actions
        for legal_action in valid_moves:
            step = Step(tree.name.state,legal_action,1)
            Node(step,parent=tree)
        expand_further = True
        time_step = 2
        while expand_further:
            # define current player
            expand_further = False
            # starting iteration to fill branches
            # print("Depth: %s" % (time_step))
            for leaf in tqdm(tree.leaves,disable=True):
                current_state = leaf.name.state
                if current_state.is_terminal:
                    continue

                next_state = current_state.get_next(leaf.name.action)
                valid_moves = next_state.legal_actions
                for legal_action in valid_moves:
                    step = Step(next_state,legal_action,time_step)
                    Node(step,parent=leaf)
                    expand_further = True
                
                if next_state.is_terminal:
                    # Node(next_state,parent=leaf)
                    goals = next_state.goals
                    leaf.name.score = goals[main_player]

            time_step += 1

    def build_minimax(self,tree,main_player="a"):
        """
        Function to review and annotate tree with minimax scores

        Args:
            tree (anytree.Node): a tree with scores on its leaves
            main_player (str): The player to maximize
        Returns:
            tree (anytree.Node): minimax-annotated version of tree
        """
        # print("tracking minimax scores recursively")
        # work recursively backwards to fill up slots
        for node in tqdm(list(reversed
                            (list(LevelOrderIter(tree.root,
                                                maxlevel=tree.root.height)))),disable=True):
            scores = [child.name.score
                      for child in node.children if child != ()]
            if node.name.score == None:
                if node.children[0].name.state.control == main_player:
                    node.name.score = max(scores)
                else:
                    node.name.score = min(scores)
        return tree

    def print_in_file(self,base_dir="./img/",
                      file_name="tree_test.png",html=True,main_player="a"):
        """
        Function to plot generated tree as an image file

        Args:
            base_dir (str): path of image containing directory
            file_name (str): full name of image to be created
            html (bool): Using html tables for image if True
        """
        # define local functions
        def to_label(node):
            a = node.name.ascii_score(main_player)
            a_r = a.replace('\n','\l')+'\l\n'
            """ Minor function to create ascii graph label """
            return 'label="%s" shape=box style=rounded fontname=Calibri labeljust=l'  % ( a_r)
        
        #TODO find a way to make this general
        # define local variables
        def text2html(node):
            piles = self.game.number_piles
            maximum = self.game.max_number
            """ Minor function to parse ascii score to html table """
            html = []
            # make html header
            html.append("<table border='0' cellborder='1' cellspacing='0'" +
                        " cellpadding='2.5' width='100%'>")
            # parse score string into list
            to_parse = list(filter(None,node.name.ascii_score(main_player).split("\n")))
            # create html score header based on node type
            if node.is_root:
                html.append("<tr><td colspan='%s'><b>%s</b></td></tr>" %
                            (maximum,"<br/>".join(to_parse[:2])))
                del to_parse[:2]
            elif node.is_leaf:
                html.append("<tr><td colspan='%s'><b>%s</b></td></tr>" %
                            (maximum,"<br/>".join(to_parse[:1])))
                del to_parse[:1]
            else:
                html.append("<tr><td colspan='%s'>%s</td></tr>" %
                            (maximum,"<br/>".join(to_parse[:1])))
                del to_parse[:1]
            # assert to check all row characters map to column number times 2
            for el in to_parse:
                assert len(el) == 2*maximum
            # add grids based on dimensions and game states
            fill = False
            for i in range(piles):
                string = "<tr>"
                if not fill:
                    try:
                        split = re.findall("..",to_parse[i])
                    except IndexError:
                        fill = True
                if fill:
                    for j in range(maximum):
                        string += "<td width='50%'> </td>"
                else:
                    for j in range(maximum):
                        string += ("<td width='50%'>"+split[j][0]+"</td>")
                string += "</tr>"
                html.append(string)
            # close table
            html.append("</table>")
            return 'shape = plaintext label=<%s>' % "\n".join(html)
        # execute function
        if html:
            UniqueDotExporter(self.root,
                              nodeattrfunc=text2html).to_picture(base_dir+
                                                                 file_name)
        else:
            UniqueDotExporter(self.root,
                              nodeattrfunc=to_label,
                              edgeattrfunc=lambda parent, child: "style=bold").to_picture(base_dir+
                                                                file_name)

    def print_in_console(self):
        """
        Function to plot generated tree within the console
        """
        for pre, fill, node in RenderTree(self.root):
            print("%s%s" % (pre, node.name))

    @staticmethod
    def node_from_match_initial(match):
        """
        Function to construct a tree from match class given initial state

        Args:
            match (Match): a constructed match

        Returns:
            root_node (anytree.Node): tree corresponding to match
        """
        initial = Step(match.steps[0].state,None,-1)
        root_node = Node(initial)
        rest = Tree.node_from_match(match)
        rest.parent = root_node
        return root_node

    @staticmethod
    def node_from_match(match):
        """
        Function to construct a tree from match class

        Args:
            match (Match): a constructed match

        Returns:
            root_node (anytree.Node): tree corresponding to match
        """
        root_node = Node(match.steps[0],children=[])
        current_node = root_node
        for s in match.steps[1:]:
            new = Node(s,parent=current_node)
            current_node = new
        return root_node
