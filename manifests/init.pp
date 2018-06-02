# Class: blacklist_acpi_power_meter
# ===========================
#
# Full description of class blacklist_acpi_power_meter here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'blacklist_acpi_power_meter':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Henry Spanka <henry.spanka@vnetso.com>
#
# Copyright
# ---------
#
# Copyright 2018 Henry Spanka, unless otherwise noted.
#
class blacklist_acpi_power_meter (
    Boolean $blacklist = true,
) {
    if ($blacklist) {
        $ensure_real = 'present'
    } else {
        $ensure_real = 'absent'
    }

    case $::operatingsystem {
        'CentOS': {
            if ($blacklist) {
                kmod::load { 'acpi_power_meter':
                    ensure => 'absent',
                }
            }

            kmod::blacklist { 'acpi_power_meter':
                ensure => $ensure_real,
            }
        }
        default: {
            fail('Can only be installed on CentOS.')
        }
    }
}
