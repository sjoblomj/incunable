BEGIN {
    OPENING_BRACKETS = "{{";
    CLOSING_BRACKETS = "}}";
}

# Given a [text], this function returns the value of the
# parameter key given in [param_name].
# If [text] does not contain [param_name], the empty string
# is returned.
function get_parameter(text, param_name,  param, next_param_pos, template_end_pos, pos) {
    if (!match(text, param_name))
        return "";
    param_name = "|" param_name;
    param = substr(text, index(text, param_name) + length(param_name));
    sub("^ *=? *", "", param);

    next_param_pos = index(param, "|");
    template_end_pos = find_template_closing_pos(param);
    pos = (next_param_pos > 0 && next_param_pos < template_end_pos) ? next_param_pos : template_end_pos;

    param = substr(param, 0, pos - 1);
    sub(" *$", "", param);

    return param;
}


# Returns the position of the rightmost occurrence of
# closing brackets before a new template is opened.
# If no template is opened, it returns the position of
# the rightmost occurrence of closing brackets on the line.
function find_template_closing_pos(line,  next_start_pos) {
    # If the line starts with opening brackets, loop past them
    while (1) {
        next_start_pos = index(line, OPENING_BRACKETS);
        if (next_start_pos == 1) {
            line = substr(line, 2);
        } else if (next_start_pos == 0) {
            next_start_pos = length(line);
            break;
        } else {
            break;
        }
    }
    line = substr(line, 0, next_start_pos + 1);

    return find_rightmost_occurrence(line, CLOSING_BRACKETS);
}


# Finds the rightmost occurrence of [str_to_find] in [line].
# Returns 0 if no result is found.
function find_rightmost_occurrence(line, str_to_find,  len, i) {
    len = length(str_to_find);
    for (i = length(line) - len + 1; i > 0; i--) {
       if (substr(line, i, len) == str_to_find)
           return i;
    }
    return 0;
}

# Trims away any whitespace (i.e. space, tab, newlines, carrige-returns) from the left and right of given [string]
function trim(string) {
    sub(/^[ \t\r\n]+/,  "", string);
    sub( /[ \t\r\n]+$/, "", string);
    return string;
}

# Prints [message] to stderr
function print_error(message) {
    print FILENAME ": " message > "/dev/stderr"
}

# Reads every line of the given [file] from disk and
# returns the content.
function read_file(file,  line, lines) {
    lines = "";
    while ((getline line < file) > 0) {
        if (lines == "")
            lines = line;
        else
            lines = lines "\n" line;
    }
    close(file);
    return lines;
}

