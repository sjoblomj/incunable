import re
import sys
import subprocess
from os import listdir
from os.path import isfile, join

# Arguments to this script:
# 1. Path to the template directory of the resource type (html/templates, latex/templates, ...)
# 2. Path to file being processed
# 3. Name of file being processed
# 4. Path to directory with extra files belonging to the file being processed

produce_string = "# *@produces"
path = join(sys.argv[1], "pre")
root_node_name = ""

class Tree:
    def __init__(self, name, depth = -1):
        self.children = []
        self.parents = []
        self.name = name
        self.depth = depth


def recalculate_depth_of_children(node):
    for c in node.children:
        c.depth = max(c.depth, node.depth + 1)
        recalculate_depth_of_children(c)

def is_descendant_of_itself(tree, name):
    if tree.name == name:
        return True
    for p in tree.parents:
        if is_descendant_of_itself(p, name):
            return True
    return False


def find_all_scripts():
    files = [f for f in listdir(path) if isfile(join(path, f))]
    all_nodes = {}

    for f in files:
        if f not in all_nodes:
            all_nodes[f] = Tree(f)

        for line in open(join(path, f)).readlines():
            if re.match(produce_string, line):
                line = re.sub(produce_string, "", line)
                produced_scripts = map(lambda x: x.strip(), line.split(","))

                parent = all_nodes[f]
                for s in produced_scripts:
                    if is_descendant_of_itself(parent, s):
                        raise ValueError("Attempting to add '" + s + "', but it is already a descendant of itself")

                    if s not in all_nodes:
                        new_node = Tree(s)
                        new_node.parents.append(parent)
                        all_nodes[s] = new_node
                    parent.children.append(all_nodes[s])

    root = Tree(root_node_name, 0)
    for k, v in all_nodes.items():
        if not v.parents:
            v.parents.append(root)
            root.children.append(v)
    recalculate_depth_of_children(root)
    return root


def tree_to_set(node):
    tups = [(node.name, node.depth)]
    for c in node.children:
        tups.extend(tree_to_set(c))
    return set(tups)

def tree_to_list(node):
    tups = tree_to_set(node)
    sorted_tups = sorted(tups, key=lambda tup: tup[1])
    list_of_names = map(lambda tup: tup[0], sorted_tups)
    return filter(lambda x: x is not root_node_name, list_of_names)

def run_scripts(scripts):
    for f in scripts:
        filepath = join(path, f)
        if isfile(filepath):
            s = [filepath, sys.argv[2], sys.argv[3], sys.argv[4]]
            subprocess.call(s)

scripts = find_all_scripts()
run_scripts(tree_to_list(scripts))
