# This is a tweaked version of https://github.com/rails/rails-dev-box

$ar_databases = ['activerecord_unittest', 'activerecord_unittest2']
$as_vagrant   = 'sudo -u vagrant -H bash -l -c'
$home         = '/home/vagrant'

# Pick a Ruby version modern enough, that works in the currently supported Rails
# versions, and for which RVM provides binaries.
$ruby_version = '2.1.2'

Exec {
  path => ['/usr/sbin', '/usr/bin', '/sbin', '/bin']
}

# --- Preinstall Stage ---------------------------------------------------------

stage { 'preinstall':
  before => Stage['main']
}

class apt_get_update {
  exec { 'apt-get -y update':
    unless => "test -e ${home}/.rvm"
  }
}
class { 'apt_get_update':
  stage => preinstall
}

# --- SQLite -------------------------------------------------------------------

package { ['sqlite3', 'libsqlite3-dev']:
  ensure => installed;
}

# --- Memcached ----------------------------------------------------------------

class { 'memcached': }

# --- Packages -----------------------------------------------------------------

package { 'curl':
  ensure => installed
}

package { 'build-essential':
  ensure => installed
}

package { 'git-core':
  ensure => installed
}

# Nokogiri dependencies.
package { ['libxml2', 'libxml2-dev', 'libxslt1-dev']:
  ensure => installed
}

# ExecJS runtime.
package { 'nodejs':
  ensure => installed
}

# --- Ruby ---------------------------------------------------------------------

exec { 'install_gpg_keys':
  command => "${as_vagrant} 'gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3'",
}

exec { 'install_rvm':
  command => "${as_vagrant} 'curl -L https://get.rvm.io | bash -s stable'",
  creates => "${home}/.rvm/bin/rvm",
  require => Package['curl']
}

exec { 'install_ruby':
  # We run the rvm executable directly because the shell function assumes an
  # interactive environment, in particular to display messages or ask questions.
  # The rvm executable is more suitable for automated installs.
  #
  # use a ruby patch level known to have a binary
  command => "${as_vagrant} '${home}/.rvm/bin/rvm install ruby-${ruby_version} --binary --autolibs=enabled --max-time 30 && rvm alias create default ${ruby_version}'",
  creates => "${home}/.rvm/bin/ruby",
  require => Exec['install_rvm']
}

# RVM installs a version of bundler, but for edge Rails we want the most recent one.
exec { "install_bundler":
  command => "${as_vagrant} 'gem install bundler --no-rdoc --no-ri'",
  creates => "${home}/.rvm/bin/bundle",
  require => Exec['install_ruby']
}

# --- Locale -------------------------------------------------------------------

# Needed for docs generation.
exec { 'update-locale':
  command => 'update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8'
}

# --- For DC Housing Apps Specifically -----------------------------------------

$rubyhome = "${home}/.rvm/gems/ruby-${ruby_version}/bin"

stage { 'dc-housing': }

class dc-housing-setup {
  package { "pdftk":
    ensure => latest
  }

  # Getting a weird "Zlib::BufError buffer error" when calling this automatically
  # Run it manually by calling "bundle install" after ssh-ing in
  #exec { "run_bundle_install":
  #  command => "${as_vagrant} ${rubyhome}/bundle install",
  #  cwd => "/vagrant",
  #  logoutput => true,
  #  timeout => 900 # Bundle install takes a while
  #}

  # Can't quite get this to work, so you'll have to do it manually the first time you log in to the server
  #exec { "rake_setup_db":
  #  command => "${as_vagrant} ${rubyhome}/rake db:setup",
  #  cwd => "/vagrant",
  #  logoutput => true,
  #  require => Exec['run_bundle_install']
  #}
}

class { 'dc-housing-setup':
  stage => dc-housing
}

# Make sure dc-housing stuff happens after everything else
Stage['main'] -> Stage['dc-housing']
