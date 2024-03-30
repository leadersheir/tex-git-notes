test_exists() {
    echo "I exist"
}

populate_logs() {
    project_name="$1"

    read -p "Enter study type: " type
    read -p "Enter title: " title
    read -p "Enter authors (separate with comma): " authors
    read -p "Enter primary material source: " src
    today=$(date +"%a %d %b %Y")

    cd; cd Notes/$project_name
    # rpl has to be installed with apt
    rpl -q TYPE "$type" README.md
    rpl -q TITLE "$title" README.md
    rpl -q AUTHORS "$authors" README.md
    rpl -q SRC "$src" README.md
    rpl -q DATE "$today" README.md session_log.csv
}

new_proj() {
    project_name="$1"
    template_path="/home/cne/dev/tgn/templates"

    echo "Creating new project"

    cd; cd Notes

    # create project dir if doesn't already exist
    if ! [ -d $project_name ]; then
        echo "Creating project directory"
        mkdir $project_name
        cd $project_name
        echo "Initiating git repo"
        git init -q
        cd ..
    fi

    # set up directories and files
    echo "Setting up directories and files"
    cd $project_name
    mkdir notes ext_res && mkdir notes/images
    touch README.md session_log.csv notes/main.tex

    # copy templates
    echo "Copying templates"
    cat $template_path/template.md > README.md
    cat $template_path/template.csv > session_log.csv
    cat $template_path/template.tex > notes/main.tex

    echo "Populating logs"
    populate_logs $project_name

    # check if current dir is a git repo
    if ! [ git rev-parse --is-inside-work-tree >/dev/null 2>&1 ]; then
        echo "Initiating git repo"
        git init -q
    fi

    # make first commit
    git add .
    echo "Making first commit"
    git commit -m "create new study"

    # launch tex document in code
    code ./notes/main.tex
}

new_sess() {
    sess="$1"
    res="$2"
    today=$(date +"%a %d %b %Y")
    newline="|$today|$sess|$res|"
    echo $newline >> README.md
}