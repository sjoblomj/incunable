#!/bin/awk -f

# This requires the caller to have set the environment variable
# INCUNABLE_TEMPLATE_DIR to be the directory of where to find
# the templates.

@include "utils.awk"

BEGIN {
    OPENING_BRACKETS = "{{";
    CLOSING_BRACKETS = "}}";
}
{
    while (1) {
        line = $0;
        if (line !~ OPENING_BRACKETS || line !~ CLOSING_BRACKETS) {
            print;
            next;
        }

        line = substitute_templates(line);
        if ($0 == line) {
            if (line ~ OPENING_BRACKETS && line ~ CLOSING_BRACKETS)
                print_error("Unable to perform substitution on line '" line "'")
            break;
        }
        $0 = line;
    }
    print $0;
}


function substitute_templates(line,  start_pos, next_start_pos, end_pos, template_text, template_substitute, t, substituted_rest_of_line) {
    if (line !~ OPENING_BRACKETS || line !~ CLOSING_BRACKETS)
        return line;

    start_pos = index(line, OPENING_BRACKETS) +  length(OPENING_BRACKETS);
    next_start_pos = index(substr(line, start_pos + 1), OPENING_BRACKETS);
    end_pos = index(substr(line, start_pos + 1), CLOSING_BRACKETS);

    if (next_start_pos > 0 && next_start_pos < end_pos) {
        substituted_rest_of_line = substitute_templates(substr(line, next_start_pos + length(OPENING_BRACKETS) + 1));
        return substitute_templates(substr(line, 0, next_start_pos + length(OPENING_BRACKETS)) substituted_rest_of_line);
    }

    template_text = substr(line, start_pos, end_pos);
    template_substitute = substitute_template_content(template_text);
    t = OPENING_BRACKETS template_text CLOSING_BRACKETS;
#    print_error("Substituting '" t "' with '" template_substitute "'");

    return substr(line, 0, index(line, t) - 1) template_substitute substr(line, index(line, t) + length(t));
}


function substitute_template_content(line,  a, template, template_content, l, key_pos0, key_pos1, key, val) {
    split(line, a, "|");
    template = trim(a[1]);
    template_content = read_template_file(template);
    l = line;

    while (1) {
        key_pos0 = match(l, "(\\|[-_a-zA-Z0-9]+ ?= ?)", a);
        if (key_pos0 == 0)
            break;
        l = substr(l, key_pos0 + length(a[1]));
        key_pos1 = match(l, "(\\|[-_a-zA-Z0-9]+ ?= ?)");
        if (key_pos1 == 0)
            key_pos1 = length(l) + 1;

        key = a[1];
        sub("\\|", "", key);
        sub("=", "", key);
        key = trim(key);
        val = trim(substr(l, 0, key_pos1 - 1));
        gsub("\\$\\{" key "\\}", val, template_content);
    }
    if (template_content == "")
        return OPENING_BRACKETS line CLOSING_BRACKETS;
    return template_content;
}

function read_template_file(file) {
    return read_file(ENVIRON["INCUNABLE_TEMPLATE_DIR"] file);
}
