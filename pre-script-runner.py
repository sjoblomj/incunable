import re
import sys
from os import listdir
from os.path import isfile, join

# Prints the names of the pre-processing scripts, one per line, in the order that they should be run.
# The order is the same for every page, so this script only needs to be run once per compilation.
#
# Arguments to this script:
# 1. Path to the template directory of the resource type (html/templates, latex/templates, ...)

precedes_string = "# *@precedes"
path = join(sys.argv[1], "pre")


# Returns a dictionary, where each key is the name of a script, and the value is the set of
# scripts that it precedes, i.e. the scripts that must be run after it.
def find_all_scripts():
    files = [f for f in listdir(path) if isfile(join(path, f))]
    following = {f: set() for f in files}

    for f in files:
        with open(join(path, f)) as script:
            for line in script:
                if re.match(precedes_string, line):
                    line = re.sub(precedes_string, "", line)
                    for s in line.split(","):
                        s = s.strip()
                        if s:
                            following[f].add(s)
                            following.setdefault(s, set())
    return following


# Returns the depth of each script, which is the length of the longest chain of scripts that precede it.
# Scripts that are not preceded by anything have depth 1.
def calculate_depths(following):
    depths = {}
    in_progress = []

    def visit(name, depth):
        if name in in_progress:
            chain = in_progress[in_progress.index(name):] + [name]
            raise ValueError("The pre-processing scripts precede each other in a circle: " + " -> ".join(chain))
        if depths.get(name, 0) >= depth:
            return
        depths[name] = depth
        in_progress.append(name)
        for s in sorted(following[name]):
            visit(s, depth + 1)
        in_progress.pop()

    preceded = set().union(*following.values()) if following else set()
    roots = [name for name in following if name not in preceded]
    if following and not roots:
        raise ValueError("The pre-processing scripts precede each other in a circle; none of them can be run first")
    for name in sorted(roots):
        visit(name, 1)
    return depths


# Returns the names of the scripts in the order they should be run; ordered by depth and then by name.
def order_scripts(following):
    depths = calculate_depths(following)
    return sorted(depths, key=lambda name: (depths[name], name))


try:
    scripts = order_scripts(find_all_scripts())
except ValueError as e:
    sys.exit("Error: " + str(e))
for f in scripts:
    if isfile(join(path, f)):
        print(f)
