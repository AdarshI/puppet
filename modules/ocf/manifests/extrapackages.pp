# Packages to be installed on user-facing machines.
#
# In order to avoid confusing users (and to be as convenient as possible), we
# maintain a common set of packages between "login" servers, desktops, and web
# servers.
#
# Some of these packages don't make sense in some of these environments, but
# the marginal cost of installing useless packages is low, and it's easier to
# maintain this one config (and better for users in at least some cases).
#
# This is in a separate manifest so that it can be included by other modules
# without concerns of redeclaring ocf::packages with different parameters.
class ocf::extrapackages {
  # special snowflake packages that require some config
  include ocf::packages::chrome
  include ocf::packages::emacs
  include ocf::packages::kubectl
  include ocf::packages::matplotlib
  include ocf::packages::mysql
  include ocf::packages::mysql_server
  include ocf::packages::nmap

  # other packages
  package {
    # misc. packages helpful for users
    [
    'ack',
    'alpine',
    'apache2-dev',
    'apache2-utils',
    'asciinema',
    'autoconf',
    'autojump',
    'automake',
    'biber',
    'bind9utils',
    'bison',
    'bogofilter',
    'build-essential',
    'cabal-install',
    'cgdb',
    'chicken-bin',
    'chrpath',
    'cmake',
    'cowsay',
    'debhelper',
    'default-jdk',
    'default-libmysqlclient-dev',
    'dh-systemd',
    'dh-virtualenv',
    'elinks',
    'elpa-markdown-mode',
    'epic5',
    'flex',
    'fortune-mod',
    'gdb',
    'gem2deb',
    'genisoimage',
    'ghc',
    'git-buildpackage',
    'golang',
    'graphicsmagick',
    'graphviz',
    'haveged',
    'icedtea-netx',
    'ikiwiki',
    'inotify-tools',
    'intltool',
    'ipython',
    'ipython3',
    'irssi',
    'julia',
    'jupyter-console',
    'jupyter-core',
    'jupyter-notebook',
    'keychain',
    'kubernetes-deploy',
    'libcrack2-dev',
    'libdbi-perl',
    'libexpect-perl',
    'libfcgi-dev',
    'libffi-dev',
    'libgdbm-dev',
    'libgtk-3-dev',
    'libgtk2.0-dev',
    'libicu-dev',
    'libjpeg-dev',
    'liblua5.1-0-dev',
    'libmagickwand-dev',
    'libncurses5-dev',
    'libopencv-dev',
    'libpq-dev',
    'libreadline-dev',
    'libsqlite3-dev',
    'libtidy-dev',
    'libtool',
    'libunicode-map8-perl',
    'libwww-mechanize-perl',
    'libxml2-dev',
    'libxslt1-dev',
    'libyaml-dev',
    'lolcat',
    'lynx',
    'maven',
    'mercurial',
    'mosh',
    'mutt',
    'nasm',
    'neofetch',
    'neovim',
    'nodeenv',
    'nodejs',
    'octave',
    'pandoc',
    'pdfchain',
    'php-bcmath',
    'php-bz2',
    'php-cli',
    'php-curl',
    'php-gd',
    'php-intl',
    'php-mbstring',
    'php-mysql',
    'php-sqlite3',
    'php-soap',
    'php-xml',
    'php-zip',
    'pkg-config',
    'postgresql-client',
    'pssh',
    'puppet-lint',
    'python-cracklib',
    'python-crypto',
    'python-django',
    'python-egenix-mxdatetime',
    'python-flake8',
    'python-flask',
    'python-flup',
    'python-jaxml',
    'python-lxml',
    'python-minimal',
    'python-mock',
    'python-mysqldb',
    'python-nose',
    'python-notebook',
    'python-numpy',
    'python-pandas',
    'python-progressbar',
    'python-pysnmp4',
    'python-pysqlite2',
    'python-pytest',
    'python-pytest-cov',
    'python-reportlab',
    'python-scapy',
    'python-scipy',
    'python-sklearn',
    'python-sqlalchemy',
    'python-stdeb',
    'python-sympy',
    'python-twisted',
    'python-virtualenv',
    'python-yaml',
    'python3-flake8',
    'python3-flask',
    'python3-jinja2',
    'python3-lxml',
    'python3-mock',
    'python3-mysqldb',
    'python3-nose',
    'python3-notebook',
    'python3-pandas',
    'python3-progressbar',
    'python3-pytest',
    'python3-pytest-cov',
    'python3-requests-oauthlib',
    'python3-sleekxmpp',
    'python3-stdeb',
    'python3-sympy',
    'python3-tk',
    'qrencode',
    'quilt',
    'r-base',
    'r-cran-data.table',
    'r-cran-dplyr',
    'r-cran-ggplot2',
    'r-cran-jsonlite',
    'r-cran-lubridate',
    'r-cran-magrittr',
    'r-cran-markdown',
    'r-cran-tidyr',
    'r-cran-xml2',
    'r-cran-zoo',
    'r10k',
    'rails',
    'rbenv',
    'ripgrep',
    'ruby-build',
    'ruby-dev',
    'ruby-fcgi',
    'ruby-mysql2',
    'ruby-ronn',
    'ruby-sqlite3',
    'scala',
    'screenfetch',
    'shellcheck',
    'silversearcher-ag',
    'sqlite3',
    'subversion',
    'texlive',
    'texlive-bibtex-extra',
    'texlive-extra-utils',
    'texlive-humanities',
    'texlive-latex-extra',
    'texlive-publishers',
    'texlive-science',
    'tox',
    'twine',
    'unison',
    'vagrant',
    'valgrind',
    'weechat',
    'xvnc4viewer',
    'zlib1g-dev',
    'znc',
    ]:;
  }

  ocf::repackage { 'git-lfs':
    backport_on =>  ['buster', 'stretch'],
  }

  if $::lsbdistcodename == 'stretch' {
    package {
      [
        # php-mcrypt is deprecated since PHP 7.1 in favor of using openssl
        # instead and buster has PHP 7.3:
        # http://php.net/manual/en/migration71.deprecated.php
        'php-mcrypt',

        # This isn't available as php-dba unfortunately (that's just a virtual
        # package for this), and with virtual packages puppet will try to
        # install them every run, leading to unnecessary noise
        'php7.0-dba',
      ]:;
    }
  } elsif $::lsbdistcodename == 'buster' {
    # This isn't available as php-dba unfortunately (that's just a virtual
    # package for this), and with virtual packages puppet will try to install
    # them every run, leading to unnecessary noise
    package { 'php7.3-dba':; }
  }

  # install wp-cli
  # TODO: can we debian-package this?
  file { '/usr/local/sbin/download-wp-cli':
    source => 'puppet:///modules/ocf/packages/download-wp-cli',
    mode   => '0755';
  }
  cron { 'download-wp-cli':
    command => '/usr/local/sbin/download-wp-cli',
    special => 'weekly',
    require => File['/usr/local/sbin/download-wp-cli'];
  }
  exec { 'download-wp-cli':
    command => '/usr/local/sbin/download-wp-cli',
    creates => '/usr/local/bin/wp',
    require => File['/usr/local/sbin/download-wp-cli'];
  }
}
