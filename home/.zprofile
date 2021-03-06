# derived from base-files version 3.7-1

# WARNING
#
# IF THIS FILE IS MODIFIED IT WILL NOT BE UPDATED BY THE CYGWIN
# SETUP PROGRAM.  IT BECOMES YOUR RESPONSIBILITY.

# The latest version as installed by the Cygwin Setup program can
# always be found at /usr/share/doc/zsh-X.Y.Z/StartupFiles/etc/zprofile

# Some resources...

# Customizing Your Shell: http://www.dsl.org/cookbook/cookbook_5.html#SEC69
# Consistent BackSpace and Delete Configuration:
#   http://www.ibb.net/~anne/keyboard.html
# The Linux Documentation Project: http://www.tldp.org/
# The Linux Cookbook: http://www.tldp.org/LDP/linuxcookbook/html/

# Setup some default paths.  Note that this order will allow user installed
#  software to override 'system' software

# If you wish to change the path for all users, it is recommended you edit
#    /etc/zshenv # runs before /etc/zprofile
# or /etc/zshrc  # runs after /etc/zprofile (for interactive shells)
# or /etc/zlogin # runs after /etc/zprofile (for login shells)

# If you wish to change the path on a user by user basis, it is recommended you
#  edit
#    ~/.zshenv   # runs before ~/.zprofile
# or ~/.zprofile # (for login shells)
# or ~/.zshrc    # runs after ~/.zprofile (for interactive shells)
# or ~/.zlogin   # runs after ~/.zprofile (for login shells)

PATH=/usr/local/bin:/usr/bin:/bin:/usr/X11R6/bin:$PATH
export PATH

MANPATH=/usr/local/man:/usr/share/man:/usr/man:$MANPATH
export MANPATH

INFOPATH=/usr/local/info:/usr/share/info:/usr/info:$INFOPATH
export INFOPATH

# Set the user id
USER="`id -un`"
export USER

# Here is how HOME is set, in order of priority, when starting from Windows
#  1) From existing HOME in the Windows environment, translated to a Posix path
#  2) from /etc/passwd, if there is an entry with a non empty directory field
#  3) from HOMEDRIVE/HOMEPATH
#  4) / (root)

# If the home directory doesn't exist, create it.
if [ ! -d "${HOME}" ]; then
	mkdir -p "${HOME}"
	echo "Copying skeleton files."
	echo "These files are for the user to personalise"
	echo "their cygwin experience."
	echo
	echo "These will never be overwritten."
	echo
	cd /etc/skel
	/bin/find . -type f | while read f; do
		fDest=`echo ${f} | sed -e 's/^\.//g'`
		if [ ! -e "${HOME}${fDest}" -a ! -L "${HOME}${fDest}" ]; then
			/usr/bin/install -D -p -v "${f}" "${HOME}/${fDest}"
		fi
	done
fi

chmod 1777 /tmp 2>/dev/null

# Default to unix make mode
MAKE_MODE=unix
export MAKE_MODE

# It is recommended that cvs uses ssh for it's remote shell environment
CVS_RSH=/bin/ssh
export CVS_RSH

# Patches to Cygwin always appreciated ;)
# CVSROOT=:pserver:anoncvs@sources.redhat.com:/cvs/src
# export CVSROOT

# Shell dependent settings
case "`echo "_$0" | /usr/bin/tr '[:upper:]' '[:lower:]' | /usr/bin/sed -e 's/^_//'`" in
bash     | -bash     | */bash | \
bash.exe | -bash.exe | */bash.exe )
	# Set a HOSTNAME variable
	HOSTNAME=`hostname`
	export HOSTNAME

	# Set a default prompt of: user@host and current_directory
	PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n\$ '
	;;
ksh*     | -ksh*     | */ksh* | \
ksh*.exe | -ksh*.exe | */ksh*.exe )
	# Set a HOSTNAME variable
	typeset -l HOSTNAME

	# Set a default prompt of: user@host and current_directory
	PS1='^[]0;${PWD}^G
^[[32m${USER}@${HOSTNAME} ^[[33m${PWD}^[[0m
$ '
	;;
zsh*     | -zsh*     | */zsh* | \
zsh*.exe | -zsh*.exe | */zsh*.exe )
	# Set a HOSTNAME variable
	typeset -l HOSTNAME

	# Set a default prompt of: (user@host)[hist#] and current_directory
	PS1='%{]0;%/
[32m%}(%n@%m)[%h] %{[33m%}%~%{[0m%}
$ '
	if [ ! -z "${ZSH_NAME}" -a -z "${SHELL}" ]; then
		SHELL="/bin/zsh"
		export SHELL
	fi
	;;
sh     | -sh     | */sh | \
sh.exe | -sh.exe | */sh.exe )
	# Set a simple prompt
	PS1='$ '
	;;
* )
	# Sorry, this shell has no defaults in /etc/profile,
	#  feel free to add your own.

	# If you have some recommendations for what these defaults
	#  should be, please contact cygwin@cygwin.com with the
	#  shell details and what you would like added.

	# Thanks
	
	PS1='$ '
	;;
esac

export PS1

# Run all of the profile.d scripts
# Note that these are supplied by separate packages
# Ascending alphanumerical order enforced
if [ -d "/etc/profile.d" ]; then
	while read f; do
		if [ -f "${f}" ]; then
			. "${f}"
		fi
	done <<- EOF
	`/bin/find -L /etc/profile.d -type f -iname '*.sh' -or -iname '*.zsh' | LC_ALL=C sort`
	EOF
fi

# Uncomment to use the terminal colours set in DIR_COLOR
# eval "`dircolors -b /etc/DIR_COLORS`"

# Default to removing the write permission for group and other
#  (files normally created with mode 777 become 755; files created with
#  mode 666 become 644)
umask 022

# Define default printer
PRINTER=""
case `uname -s` in
CYGWIN_NT-*)
	PRINTER="`regtool -q get '\user\Software\Microsoft\Windows NT\CurrentVersion\Windows\Device' | sed 's/,.*$//'`"
	;;
CYGWIN_9?-*)
	PRINTER="`regtool -q get '\config\System\CurrentControlSet\Control\Print\Printers\Default'`"
	;;
esac
export PRINTER

# Make sure we start in home unless invoked by CHERE
if [ ! -z "${CHERE_INVOKING}" ]; then
  unset CHERE_INVOKING
else
  cd "${HOME}"
fi

# Check to see if mkpasswd/mkgroup needs to be run try and cut down the emails
#   about this on the lists!
# If this message keeps appearing and you are sure it's a mistake (ie, don't
#   email about it!), comment out the test below.
case `id -ng` in
mkpasswd )
  echo "Your group is currently \"mkpasswd\".  This indicates that"
  echo "the /etc/passwd (and possibly /etc/group) files should be rebuilt."
  echo "See the man pages for mkpasswd and mkgroup then, for example, run"
  echo "mkpasswd -l [-d] > /etc/passwd"
  echo "mkgroup  -l [-d] > /etc/group"
  echo "Note that the -d switch is necessary for domain users."
  ;;

mkgroup )
  echo "Your group is currently \"mkgroup\".  This indicates that"
  echo "the /etc/group (and possibly /etc/passwd) files should be rebuilt."
  echo "See the man pages for mkpasswd and mkgroup then, for example, run"
  echo "mkpasswd -l [-d] > /etc/passwd"
  echo "mkgroup  -l [-d] > /etc/group"
  echo "Note that the -d switch is necessary for domain users."
  ;;

mkgroup_l_d )
  echo "Your group name is currently \"mkgroup_l_d\". This indicates that not"
  echo "all domain users and groups are listed in the /etc/passwd and"
  echo "/etc/group files."
  echo "See the man pages for mkpasswd and mkgroup then, for example, run"
  echo "mkpasswd -l -d > /etc/passwd"
  echo "mkgroup  -l -d > /etc/group"
  echo
  echo "This message is only displayed once (unless you recreate /etc/group)"
  echo "and can be safely ignored."

  # only display the above once
  cp -f /etc/group "${HOME}/group.mkgroup_l_d" \
  && ( [ -w /etc/group ] || chmod --silent a+w /etc/group ; )\
  && sed -e 's/^mkgroup_l_d/mkgroup-l-d/' "${HOME}/group.mkgroup_l_d" > /etc/group \
  && chmod --silent --reference=/etc/passwd /etc/group
  rm -f "${HOME}/group.mkgroup_l_d"
  ;;
esac

