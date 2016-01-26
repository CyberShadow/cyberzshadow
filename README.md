cyberzshadow.zsh-theme
======================

An enhanced, optimized fork of af-magic.zsh-theme.

![](http://dump.thecybershadow.net/2ef1a3a3dc833696900cc92570e2ef54/cyberzshadow.png)

Changes/highlights:

 - Full-width bar, to clearly delimit command output.
 - Use Unicode line-drawing characters to draw the bar,
   to create a continuous line.
 - Git status, exit code and ISO timestamp are right-aligned on the bar.
 - The Git status has been moved out of the prompt line,
   to make more room for typing commands.
 - Displays short textual exit status descriptions when applicable.
 - No `RPROMPT`, as it interferes with `mc`.
 - Optimized for speed. Allows excluding paths (e.g. mounted remote filesystems)
   from git status checks using `GIT_PROMPT_EXCLUDE`.
 - Looks best with bitmap fonts.
