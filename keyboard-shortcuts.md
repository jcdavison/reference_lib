VIM COMMANDS - http://www.tuxfiles.org/linuxhelp/vimcheat.html

  ATOM
  ctrl + shift + m toggle markdown preview

  ON DECK
  ma set mark at current position indicated with id 'a'
  `a move to mark indicated with 'a'
  @: repeats whatever the last : command was, no visual display or indication that it has been triggered occurs
  .  repeats last change
  n. repeat n instances of .
  :A opens the alternate of a file, for a controller, the spec file
  :R opens the related file, for a controller, opens the helper file
  ^ left or right arrow key, switches between workspaces
  :set nofoldenable , useful to turn off folding if it should for some reason get triggered
  S) , uses vim surround to add parens to a visual selection with no inserted spaces, very fucking useful
  `` returns to the last line, useful when using gg
  * on a word will search within the file for that word, very fucking useful
  ⇧⌘3 takes a screen shot
  ^r search previous shell commands
  ^] jump to tag definition
  ^t jump back to where tag was used
  ^w t moves cursor to top left window
  ^w t ^w K changes vertical to horizontal split
  ^w t ^w H changes horizontal to vertical split
  \R run rspec on individual test
  \r run rspec on entire file

  VIM-SURROUND
  note to change we use 'cs' change surrounding
  cs"' change the surrounding " to a '
  cs'<h1> the the srrounding ' to <h1></h1>
  cst' to change the <tag></tag> back to '
  to remove we use 'ds' delete surrounding
  ysiw] to add [] around a [word] iw is a text-object
  yss' will surrsound any line of text with ''

  
  BUFFERGATOR
  \b to activate buffergator
  [b to move backward in the buffer stack
  ]b to move forward in buffer stack

  NERDTREE 
  \q togggle buffergator



  ACK IN AN OPEN RESULTS WINDO

  h to open result in horizontal, and focuse
  H to open result in horizontal, silently
  v to open vertical split
  gv to open vertical split silently

  PRODUCTIVITY SUITE
  w move forward a word, to beginning char
  b move backward a word, to beginning char
  ge move backward a word, to last character 
  f{character} search for next occurence of character 
  F{character} reverse direction search for next occurence of character
  e move forward a word, to last character
  t{character} search for next character, insert in previous space
  T{character} reverse direction search for next character, insert in previous space 
  ; repeat f{letter} search
  , reverse direction f{letter} search
  :+4 move down four lines
  :-n move up n lines

  BASICS

  i insert mode
  a append mode
  esc normal mode
  x delete charac
  o insert mode below current line
  O insert mode above current line
  u undo
  U undo all
  zz center window on current line
  == auto format the indentation on given line
  ⇧s insert on current line at correction indentation level	
  :q quit 
  :wq! save quit
  :wqa save quit all
  :help :COMMAND
  ie, :help :AV will reveal all kinds of important info related to this
  h move left
  j move up
  k move down
  l move right
  :n create a new buffer
  :e /xyz/file.rb open file.rb located in xyz in buffer
  :NERDTree opens nerdtree
  ⌘t fuzzy logic file search in dir
  ⌘ts opens selected file in horizontal split
  ⌘tv opens selected file in vertical split
  :ls lists the open buffers, which can be selected ie :ls 1 or :ls 3
  \ the "leader" character


  COPY - PASTE - SEARCH - REPLACE 

  :s%/foo/bar/g repalces on all lines foo with bar
  :s/foo/bar/g repalces on just this line foo with bar
  /hs to turn on/off highliting
  yy yank things into vim clipboard
  shift p paste after current cursor position
  # on a word, highlights that word
  * on a word, highlights and searches for that word
  gf on a word, highlights and searches file path for that word
  u undo last action
  U undo all changes on current line
  ^r redo
  :%s/word/replacement/g :% (all lines), s (substitute), /search/replace, /g all instances (global)
  :s/word/replacement/g :% s (substitute), /search/replace, /g all instances (global) -just one line

  CHARACTER & LINE EDITING

  r replace one character
  w jumps to beginning of next word
  e jumps to end of current word
  b jumps words backwards
  o starts new line w/ correct indentation underneath current line
  O starts new line w/ correct indentation above current line
  a append at cursor
  A append at end of line
  dd delete line
  d$ delete to end of line
  d^ delete to beginning of line
  c$ change to end of line
  c2w change 2 words
  d3w delete 3 words
  J joins the line on with the line below
  ⌘ j moves a line of code up
  ⌘ k moves a line of code down
  ⇧s moves to correct point of indentation in a line
  :12 jump to line 12
  ~ applied to visual selected text, change case of all characters
  ^w activates window command
  ^ws splits the current window horizontally
  ^wv splits the current window vertically
  :bs /dir/file.rb opens file.rb from the buffer into a horizontal split
  :bv /dir/file.rb opens file.rb from the buffer into a vertical split

  FILE MANAGEMENT

  :AV opens the alternate "spec" file in a vertical split
  :AS opens the alternate "spec" file in the hoirzonal split
  :A  opens the alternate "spec" file in same window - alternate is usually spec, defined by janus
  :R  opens the related file
  :bn opens next buffer 
  :bp previous buffer
  :b some_file_name opens any file in the buffer and uses tab 2 complete

  CUSTOM FUNK

  :set foldmethod=syntax  sets the file to display as a tree based on method/context definitions
  :help fold-commands
  :help zo

SUBLIME TEXT 2 - http://net.tutsplus.com/tutorials/tools-and-tips/sublime-text-2-tips-and-tricks/

  ⌘D select next occurence of current selection, multi select
  ^⌘g adds a cursor to all instances of current selection
  fn⌘ [ ] block indent right or left a line selection
  ⇧⌘p opens the command pallete
  ^g go to line
  ⌘t fuzzy logic file search
  ⇧⌘f find xyz in a project
  ⇧⌘f duplicates current selection in same spot
  ^⇧k delete entire line
  ⌘⌥1 create one column
  ⌘⌥2 create two columns
  ^⌘⌥2 create two horizontal windows
  ^1 / ^2 toggle open column/horizontal windows
  ^⇧ 1,2 moves current file indicated column/window

POSTGRESQL

  postgres -D /usr/local/var/postgres
  createdb/dropdb xyzdatabase 
  \q
  \d show tables
  \d some_db_name show columns
  \d+ some_db_name describe the table

GIT

  BASIC COMMANDS

  git add .  #adds everything to current point to git
  git status  #shows the current status of git
  git commit -m "Inital commit" #executes commit w "xyz" message
  git log
  git status
  git checkout - f #force overwrite from most recent git commit
  git checkout -b  xyzname #creates xyz branch and switches to it 
  git branch  #shows current branch being used
  git push heroku master
  git merge branchname  #merges whatever branch name into current branch


  REBASING

  MERGE CONFLICTS
  reset --hard HEAD force reset all current changes to most recent head state

  opendiff -file1 -file2 
    opens the filediff file that is native to xcode
